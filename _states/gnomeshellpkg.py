import logging
from salt.exceptions import CommandExecutionError

log = logging.getLogger(__name__)

def installed(runas, name, uuids=None):
    ret = {
        'name': name,
        'result': False,
        'changes': {},
        'comment': '',
    }

    pre_installed = __salt__['gnomeshellpkg.list_pkgs'](runas)
    missing = [uuid for uuid in uuids if uuid not in pre_installed]
    changed = []

    if len(missing) == 0:
        ret['result'] = True
        ret['comment'] = 'Packages already installed'
        return ret

    log.debug('Missing packages: {0}'.format(', '.join(missing)))

    for uuid in missing:
        try:
            ret_install = __salt__['gnomeshellpkg.install'](runas, uuid)
            changed.append(uuid)
        except CommandExecutionError as e:
            pass

    if len(missing) + len(changed):
        ret['result'] = True

    post_installed = __salt__['gnomeshellpkg.list_pkgs'](runas)
    for uuid in changed:
        ret['changes'][uuid] = {
            'old': None,
            'new': post_installed[uuid]
        }

    return ret

def latest(name, runas, uuids=None):
    ret = {
        'name': name,
        'result': False,
        'changes': {},
        'comment': '',
    }

    pre_installed = __salt__['gnomeshellpkg.list_pkgs'](runas)
    outdated = __salt__['gnomeshellpkg.list_upgrades'](runas)
    missing = [uuid for uuid in pkgs if uuid not in pre_installed]
    changed = []

    if len(missing) + len(outdated) == 0:
        ret['result'] = True
        ret['comment'] = 'Packages already installed and up to date'
        return ret

    log.debug('Missing packages: {0}'.format(', '.join(missing)))
    log.debug('Outdated packages: {0}'.format(', '.join(outdated.keys())))

    for uuid in missing:
        try:
            __salt__['gnomeshellpkg.install'](runas, uuid)
            changed.append(uuid)
        except CommandExecutionError as e:
            pass

    for uuid in outdated:
        try:
            __salt__['gnomeshellpkg.upgrade'](runas, uuid)
            changed.append(uuid)
        except CommandExecutionError as e:
            pass

    if len(missing) + len(outdated) == len(changed):
        ret['result'] = True

    post_installed = __salt__['gnomeshellpkg.list_pkgs'](runas)
    for uuid in changed:
        ret['changes'][uuid] = {
            'old': None if name in missing else pre_installed['name'],
            'new': post_installed[uuid],
        }

    return ret
