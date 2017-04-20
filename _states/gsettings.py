import six

def _normalise_value(value):
    if isinstance(value, list):
        value = '[' + ', '.join([_normalise_value(item) for item in value]) + ']'
    elif isinstance(value, bool):
        value = str(value).lower()
    elif isinstance(value, six.string_types):
        value = '\'{0}\''.format(value)

    return value

def managed(name, runas, schema, value, path=None):
    ret = {
        'name': name,
        'result': False,
        'changes': None,
        'comment': '',
    }

    value = _normalise_value(value)
    current = __salt__['gsettings.get'](name, runas, schema, path)

    if current == value:
        ret['result'] = True
        ret['comment'] = 'Value {0} already set'.format(current)
        return ret

    __salt__['gsettings.set'](name, runas, schema, value, path)

    ret['result'] = True
    ret['changes'] = {
        name: {
            'old': current,
            'new': value,
        }
    }
    ret['comment'] = 'Value for schema {0} path {1} key {2} set to {3}'.format(
            schema, path, name, value)

    return ret
