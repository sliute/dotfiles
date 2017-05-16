nvm.core:
  git.latest:
    - name: https://github.com/creationix/nvm.git
    - target: {{ pillar['user']['home'] }}/.nvm
    - user: {{ pillar['user']['name'] }}

nvm.shell:
  file.managed:
    - name: {{ pillar['user']['home'] }}/.shrc.d/nvm.sh
    - source: salt://nvm/shrc.d/nvm.sh
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['name'] }}
    - mode: 0640
