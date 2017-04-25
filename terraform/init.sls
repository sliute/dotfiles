{% if grains['kernel'] == 'Linux' %}
terraform.binary:
  archive.extracted:
    - name: {{ pillar['user']['home'] }}/.local/bin
    - enforce_toplevel: False
    - source: {{ pillar['terraform']['source_url'] }}
    - source_hash: {{ pillar['terraform']['source_hash'] }}
    - source_hash_update: True
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['name'] }}
    - if_missing: {{ pillar['user']['home'] }}/.local/bin/terraform
{% endif %}
