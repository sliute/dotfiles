include:
  - user

{% if grains['kernel'] == 'Linux' %}
{% set bin_dir = pillar['user']['home'] + pillar['user']['local_share_dir'] + '/JetBrains/Toolbox/bin' %}
{% set binary = bin_dir + '/jetbrains-toolbox' %}

jetbrains-toolbox.bin_dir:
  file.directory:
    - name: {{ bin_dir }}
    - makedirs: True
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['group'] }}
    - mode: 0700

jetbrains-toolbox.remove-previous:
  cmd.run:
    - name: rm -f {{ binary | yaml_squote }}
    - unless: |
        {{ binary | yaml_squote }} --version \
                | grep {{ pillar['jetbrains-toolbox']['version'] }}

jetbrains-toolbox.binary:
  archive.extracted:
    - name: {{ bin_dir }}
    - enforce_toplevel: False
    - options: --strip-components=1
    - source: https://download.jetbrains.com/toolbox/jetbrains-toolbox-{{ pillar['jetbrains-toolbox']['version'] }}.tar.gz
    - source_hash: {{ pillar['jetbrains-toolbox']['source_hash'] }}
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['group'] }}
    - if_missing: {{ pillar['user']['local_share_dir'] }}/JetBrains/Toolbox/bin/jetbrains-toolbox
    - require:
      - file: jetbrains-toolbox.bin_dir
      - cmd: jetbrains-toolbox.remove-previous
{% endif %}
