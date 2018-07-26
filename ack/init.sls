ack.pkg:
  pkg.installed:
    - name: ack

ack.ackrc:
  file.managed:
    - name: {{ pillar['user']['home'] }}/.ackrc
    - contents: {{ salt['pillar.get']('ack:ackrc', '') }}
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['group'] }}
    - mode: 0640
