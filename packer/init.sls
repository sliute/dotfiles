{% if grains['kernel'] == 'Linux' %}
packer.binary:
  archive.extracted:
    - name: {{ pillar['user']['home'] }}/.local/bin
    - enforce_toplevel: False
    - source: {{ pillar['packer']['source_url'] }}
    - source_hash: {{ pillar['packer']['source_hash'] }}
    - source_hash_update: True
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['name'] }}
    - if_missing: {{ pillar['user']['home'] }}/.local/bin/packer
{% endif %}
