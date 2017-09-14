{% set rbenv_root = pillar['user']['home'] + '/.rbenv' %}

rbenv.core:
  git.latest:
    - name: https://github.com/rbenv/rbenv.git
    - target: {{ rbenv_root }}
    - user: {{ pillar['user']['name'] }}

rbenv.bash-extension:
  cmd.run:
    - name: src/configure && make -C src
    - cwd: {{ rbenv_root }}
    - runas: {{ pillar['user']['name'] }}

rbenv.plugin.ruby-build.deps:
  pkg.latest:
    - pkgs:
      - gcc-6
      - autoconf
      - bison
      - build-essential
      - libssl-dev
      - libyaml-dev
      - libreadline6-dev
      - zlib1g-dev
      - libncurses5-dev
      - libffi-dev
      - libgdbm3
      - libgdbm-dev

rbenv.plugin.ruby-build:
  git.latest:
    - name: https://github.com/rbenv/ruby-build.git
    - target: {{ rbenv_root }}/plugins/ruby-build
    - user: {{ pillar['user']['name'] }}

rbenv.shell:
  file.managed:
    - name: {{ pillar['user']['home'] }}/.shrc.d/rbenv.sh
    - source: salt://rbenv/shrc.d/rbenv.sh
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['group'] }}
    - mode: 0640
