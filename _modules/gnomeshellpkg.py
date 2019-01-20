import json
import logging
import os
import re
import shutil
import urllib

from salt.exceptions import CommandExecutionError
from salt.utils.http import query

log = logging.getLogger(__name__)

USER_EXTENSIONS_DIR = '~{0}/.local/share/gnome-shell/extensions'
METADATA_FILENAME = 'metadata.json'

# SweetTooth is open source -- see its routes:
# https://git.gnome.org/browse/extensions-web/tree/sweettooth/extensions/urls.py
EXTENSION_BASE_URL = 'https://extensions.gnome.org'
EXTENSION_INFO_URL = '/extension-info/?n_per_page=-1&uuid={0}&shell_version={1}'

def _user_extensions_dir(user):
    return os.path.expanduser(USER_EXTENSIONS_DIR.format(user))

def _extension_dir(user, uuid):
    return os.path.join(_user_extensions_dir(user), uuid)

def _extension_info(uuid):
    shell_version = _shell_major_version()
    url = EXTENSION_BASE_URL + EXTENSION_INFO_URL.format(
            urllib.quote_plus(uuid), shell_version)
    log.debug('Looking up extension {0} at URL {1}'.format(uuid, url))
    info = query(url, decode=False)
    log.debug('Got extension info {0}'.format(info))

    return json.loads(info['body'].strip())

def _primary_group(user):
    user = __salt__['user.info'](user)
    for name in user['groups']:
        group = __salt__['group.info'](name)
        if group['gid'] == user['gid']:
            return group

def _shell_version():
    ret = __salt__['cmd.run_all']([
        'gnome-shell',
        '--version',
    ])

    if ret['retcode'] != 0:
        raise CommandExecutionError('Failed to determine Gnome Shell version: {0}'.format(
                ret['stderr']))

    matches = re.search('\d+\.\d+\.\d+', ret['stdout'])
    return matches.group(0).split('.')

def _shell_major_version():
    return '.'.join(_shell_version()[0:2])

def list_pkgs(runas):
    user_extensions_dir = _user_extensions_dir(runas)
    log.debug('Seeking extensions in {0}'.format(user_extensions_dir))
    extensions = os.listdir(user_extensions_dir)

    ret = {}
    for uuid in extensions:
        metadata_filename = os.path.join(
                user_extensions_dir, uuid, METADATA_FILENAME)
        with open(metadata_filename, 'r') as f:
            metadata = json.load(f)

        ret[uuid] = metadata['version']

    return ret

def list_upgrades(runas):
    installed = list_pkgs(runas)
    shell_version = _shell_major_version()

    ret = {}
    for uuid, version in installed.items():
        try:
            info = _extension_info(uuid)

            available_version = info['shell_version_map'][shell_version]['version']
            if available_version > version:
                ret[uuid] = available_version
        except KeyError:
            log.warn('Extension {0} not available'.format(uuid))

    return ret

def install(runas, uuid):
    shell_version = _shell_major_version()
    target = _extension_dir(runas, uuid)
    info = _extension_info(uuid)
    url = EXTENSION_BASE_URL + info['download_url']
    log.debug('Downloading extension from {0}'.format(url))

    group = _primary_group(runas)
    log.debug('Primary group for {0} is {1}'.format(runas, group['name']))

    client = urllib.FancyURLopener()
    filename, response = client.retrieve(url)
    log.debug('Extracting extension from {0} to {1}'.format(filename, target))

    try:
        if os.path.exists(target):
            log.debug('Removing existing extension dir {0}'.format(target))
            shutil.rmtree(target)

        __salt__['archive.unzip'](filename, target)
        __salt__['cmd.run']([
            'chown',
            '-R',
            '{0}:{1}'.format(runas, group['name']),
            target,
        ], runas='root')
    finally:
        os.unlink(filename)

def upgrade(runas, uuid=None):
    if uuid:
        shell_version = _shell_major_version()
        installed = list_pkgs(runas)
        info = _extension_info(uuid)
        available_version = info['shell_version_map'][shell_version]['version']

        if available_version > installed[uuid]:
            upgrades[uuid] = available_version
    else:
        upgrades = list_upgrades(runas)

    for uuid, available_version in upgrades.items():
        install(runas, uuid)
        ret[uuid] = available_version

    return ret

def version(runas, *uuids):
    installed = list_pkgs(runas)

    if len(uuids) == 1:
        return installed[uuids[0]]
    else:
        return {uuid: version for uuid, version in installed.items() if uuid in uuids}
