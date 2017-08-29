sh.~/.profile:
  file.managed:
    - name: {{ pillar['user']['home'] }}/.profile
    - source: salt://sh/sh/profile
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['group'] }}
    - mode: 0640

sh.~/.inputrc:
  file.managed:
    - name: {{ pillar['user']['home'] }}/.inputrc
    - source: salt://sh/bash/inputrc
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['group'] }}
    - mode: 0640

sh.~/.bashrc:
  file.managed:
    - name: {{ pillar['user']['home'] }}/.bashrc
    - source: salt://sh/bash/bashrc
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['group'] }}
    - mode: 0640

sh.~/.shrc.d:
  file.recurse:
    - name: {{ pillar['user']['home'] }}/.shrc.d
    - source: salt://sh/shrc.d
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['group'] }}
    - dir_mode: 0750
    - file_mode: 0640

sh.~/.shrc.d/path.sh:
  file.managed:
    - name: {{ pillar['user']['home'] }}/.shrc.d/path.sh
    - source: salt://sh/shrc.d/path.sh.jinja
    - template: jinja
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['group'] }}
    - mode: 0640
