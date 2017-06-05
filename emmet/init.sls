emmet.~/.emmet:
  file.directory:
    - name: {{ pillar['user']['home'] }}/.emmet
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['group'] }}
    - mode: 0750

emmet.~/.emmet/preferences.json:
  file.managed:
    - name: {{ pillar['user']['home'] }}/.emmet/preferences.json
    - source: salt://emmet/emmet/preferences.json
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['group'] }}
    - mode: 0750
