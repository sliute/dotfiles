from salt.exceptions import CommandExecutionError

def get(name, runas, schema, path=None):
    if path is not None:
        schema = "{0}:{1}".format(schema, path)

    cmd = [
        'gsettings',
        'get',
        schema,
        name,
    ]

    ret_get = __salt__['cmd.run_all'](cmd, runas=runas)
    if ret_get['retcode'] != 0:
        raise CommandExecutionError('Failed to get value for schema {0} key {1}: {2}'.format(
                schema, name, ret_get['stderr']))

    return ret_get['stdout']

def set(name, runas, schema, value, path=None):
    if path is not None:
        schema = "{0}:{1}".format(schema, path)

    cmd = [
        'gsettings',
        'set',
        schema,
        name,
        value,
    ]

    ret_set = __salt__['cmd.run_all'](cmd, runas=runas)
    if ret_set['retcode'] != 0:
        raise CommandExecutionError('Failed to set value for {0} to {1}: {2}'.format(
                name, value, ret_set['stderr']))
