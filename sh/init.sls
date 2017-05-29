sh.~/.profile:
  file.managed:
    - name: {{ pillar['user']['home'] }}/.profile
    - source: salt://sh/sh/profile
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['name'] }}
    - mode: 0640

sh.~/.inputrc:
  file.managed:
    - name: {{ pillar['user']['home'] }}/.inputrc
    - source: salt://sh/bash/inputrc
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['name'] }}
    - mode: 0640

sh.~/.bashrc:
  file.managed:
    - name: {{ pillar['user']['home'] }}/.bashrc
    - source: salt://sh/bash/bashrc
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['name'] }}
    - mode: 0640

sh.~/.shrc.d:
  file.recurse:
    - name: {{ pillar['user']['home'] }}/.shrc.d
    - source: salt://sh/shrc.d
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['name'] }}
    - dir_mode: 0750
    - file_mode: 0640
