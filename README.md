# Luke's dotfiles

Round three, but this time using Salt, because it's sensibler.

* * *

## Using

Install Salt:

```
$ sudo _bootstrap/install-salt.sh
```

Enable the desired configurations with the following stanza in `/etc/salt/grains` (see the [top file](top.sls) for a complete list):

```yaml
roles:
  - development
  - gaming
```

Then run the states:

```
$ sudo salt-call --local state.apply
```

