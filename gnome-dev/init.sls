{% set root_dir = pillar['user']['code_dir'] + '/GNOME' %}
{% set common_dir = root_dir + '/Common' %}

include:
  - git
  - user

gnome-dev.root:
  file.directory:
    - name: {{ pillar['user']['home'] }}{{ root_dir }}
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['group'] }}
    - mode: 0700
    - require:
      - file: user.code_dir

gnome-dev.common.repo:
  git.latest:
    - name: https://github.com/GNOME/gnome-common.git
    - target: {{ pillar['user']['home'] }}{{ common_dir }}
    - user: {{ pillar['user']['name'] }}
    - require:
      - file: gnome-dev.root
      - pkg: git.pkgs

gnome-dev.common.sh:
  file.managed:
    - name: {{ pillar['user']['home'] }}/.shrc.d/gnome-common.sh
    - source: salt://gnome-dev/shrc.d/gnome-common.sh.jinja
    - template: jinja
    - context:
      common_dir: {{ common_dir }}
