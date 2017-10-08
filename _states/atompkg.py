import logging
from salt.exceptions import CommandExecutionError

log = logging.getLogger(__name__)

def installed(name, runas, pkgs=None):
    ret = {
        'name': name,
        'result': False,
        'changes': {},
        'comment': '',
    }

    pre_installed = __salt__['atompkg.list_pkgs'](runas)
    missing = [name for name in pkgs if name not in pre_installed]
    changed = []

    if len(missing) == 0:
        ret['result'] = True
        ret['comment'] = 'Packages already installed'
        return ret

    log.debug('Missing packages: {0}'.format(', '.join(missing)))

    for name in missing:
        try:
            ret_install = __salt__['atompkg.install'](runas, name)
            changed.append(name)
        except CommandExecutionError as e:
            pass

    if len(missing) + len(changed):
        ret['result'] = True

    post_installed = __salt__['atompkg.list_pkgs'](runas)
    for name in changed:
        ret['changes'][name] = {
            'old': None,
            'new': post_installed[name],
        }

    return ret

def latest(name, runas, pkgs=None):
    ret = {
        'name': name,
        'result': False,
        'changes': {},
        'comment': '',
    }

    pre_installed = __salt__['atompkg.list_pkgs'](runas)
    outdated = __salt__['atompkg.list_upgrades'](runas)
    missing = [name for name in pkgs if name not in pre_installed]
    changed = []

    if len(missing) + len(outdated) == 0:
        ret['result'] = True
        ret['comment'] = 'Packages already installed and up to date'
        return ret

    log.debug('Missing packages: {0}'.format(', '.join(missing)))
    log.debug('Outdated packages: {0}'.format(', '.join(outdated.keys())))

    for name in missing:
        try:
            __salt__['atompkg.install'](runas, name)
            changed.append(name)
        except CommandExecutionError as e:
            pass

    for name in outdated:
        try:
            __salt__['atompkg.upgrade'](runas, name)
            changed.append(name)
        except CommandExecutionError as e:
            pass

    if len(missing) + len(outdated) == len(changed):
        ret['result'] = True

    post_installed = __salt__['atompkg.list_pkgs'](runas)
    for name in changed:
        ret['changes'][name] = {
            'old': None if name in missing else pre_installed[name],
            'new': post_installed[name],
        }

    return ret
