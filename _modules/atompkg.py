import json
from salt.exceptions import CommandExecutionError

def list_pkgs(runas):
    cmd = [
        'apm',
        'list',
        '--bare',
        '--installed',
    ]
    ret_installed = __salt__['cmd.run_all'](cmd, runas=runas)

    if ret_installed['retcode'] != 0:
        raise CommandExecutionError('Failed to list packages: {0}'.format(
                ret_installed['stderr']))

    ret = {}
    if len(ret_installed['stdout']):
        for line in ret_installed['stdout'].split('\n'):
            pkg, version = line.rsplit('@', 1)
            ret[pkg] = version

    return ret

def list_upgrades(runas):
    cmd = [
        'apm',
        'upgrade',
        '--list',
        '--json',
    ]
    ret_upgrades = __salt__['cmd.run_all'](cmd, runas=runas)

    if ret_upgrades['retcode'] != 0:
        raise CommandExecutionError('Failed to list upgrades: {0}'.format(
                ret_upgrades['stderr']))

    upgrades = json.loads(ret_upgrades['stdout'])
    ret = {}
    for pkg in upgrades:
        ret[pkg['name']] = pkg['latestVersion']

    return ret

def install(runas, name):
    cmd = [
        'apm',
        'install',
        '--no-confirm',
        name,
    ]

    ret_install = __salt__['cmd.run_all'](cmd, runas=runas)
    if ret_install['retcode'] != 0:
        raise CommandExecutionError('Failed to install {0}: {1}'.format(
                name, ret_install['stderr']))

def upgrade(runas, name=None):
    cmd = [
        'apm',
        'upgrade',
        '--no-confirm',
    ]

    if name is not None:
        cmd.append(name)

    ret_upgrade = __salt__['cmd.run_all'](cmd, runas=runas)
    if ret_upgrade['retcode'] != 0:
        raise CommandExecutionError('Failed to upgrade {0}: {1}'.format(
                name, ret_upgrade['stderr']))

def version(runas, *names):
    installed = list_pkgs(runas)

    if len(names) == 1:
        return installed[names[0]]
    else:
        return {name: version for name, version in installed.items() if name in names}
