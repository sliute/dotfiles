{% set pyenv_root = pillar['user']['home'] + '/.pyenv' %}

pyenv.core:
  git.latest:
    - name: https://github.com/pyenv/pyenv.git
    - target: {{ pyenv_root }}
    - user: {{ pillar['user']['name'] }}

pyenv.build-deps:
  pkg.latest:
    - pkgs:
      - build-essential
      - curl
      - libbz2-dev
      - libncurses5-dev
      - libreadline-dev
      - libsqlite3-dev
      - libssl-dev
      - llvm
      - make
      - tk-dev
      - wget
      - xz-utils
      - zlib1g-dev

pyenv.shell:
  file.managed:
    - name: {{ pillar['user']['home'] }}/.shrc.d/pyenv.sh
    - source: salt://pyenv/shrc.d/pyenv.sh
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['group'] }}
    - mode: 0640
