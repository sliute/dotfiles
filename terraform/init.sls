include:
  - user

{% if grains['kernel'] == 'Linux' %}
{% set binary = pillar['user']['home'] + "{{ pillar['user']['bin_dir'] }}/terraform" %}
terraform.remove-previous:
  cmd.run:
    - name: rm -f {{ binary | yaml_dquote }}
    - unless: |
        {{ binary | yaml_dquote }} version \
                | head -n1 \
                | grep v{{ pillar['terraform']['version'] | yaml_dquote }}

terraform.binary:
  archive.extracted:
    - name: {{ pillar['user']['home'] }}{{ pillar['user']['bin_dir'] }}
    - enforce_toplevel: False
    - source: https://releases.hashicorp.com/terraform/{{ pillar['terraform']['version'] }}/terraform_{{ pillar['terraform']['version'] }}_linux_amd64.zip
    - source_hash: https://releases.hashicorp.com/terraform/{{ pillar['terraform']['version'] }}/terraform_{{ pillar['terraform']['version'] }}_SHA256SUMS
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['name'] }}
    - if_missing: {{ binary | yaml_dquote }}
    - require:
      - file: user.bin_dir
{% endif %}
