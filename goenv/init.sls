goenv.go:
  pkg.latest:
    - name: golang-go

goenv.core:
  git.latest:
    - name: https://github.com/syndbg/goenv.git
    - target: {{ pillar['user']['home'] }}/.goenv
    - user: {{ pillar['user']['name'] }}

goenv.shell:
  file.managed:
    - name: {{ pillar['user']['home'] }}/.shrc.d/goenv.sh
    - source: salt://goenv/shrc.d/goenv.sh
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['group'] }}
    - mode: 0640
