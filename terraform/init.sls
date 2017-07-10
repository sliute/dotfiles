include:
  - user

{% if grains['kernel'] == 'Linux' %}
{% set binary = pillar['user']['home'] + pillar['user']['bin_dir'] + "/terraform" %}

terraform.remove-previous:
  cmd.run:
    - name: rm -f {{ binary | yaml_squote }}
    - unless: |
        {{ binary | yaml_squote }} version \
                | head -n1 \
                | grep v{{ pillar['terraform']['version'] | yaml_squote }}

terraform.binary:
  archive.extracted:
    - name: {{ pillar['user']['home'] }}{{ pillar['user']['bin_dir'] }}
    - enforce_toplevel: False
    - source: https://releases.hashicorp.com/terraform/{{ pillar['terraform']['version'] }}/terraform_{{ pillar['terraform']['version'] }}_linux_amd64.zip
    - source_hash: https://releases.hashicorp.com/terraform/{{ pillar['terraform']['version'] }}/terraform_{{ pillar['terraform']['version'] }}_SHA256SUMS
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['group'] }}
    - if_missing: {{ binary | yaml_squote }}
    - require:
      - file: user.bin_dir
      - cmd: terraform.remove-previous

terraform.binary.mode:
  file.managed:
    - name: {{ pillar['user']['home'] }}{{ pillar['user']['bin_dir'] }}/terraform
    - mode: 0750
    - replace: False
    - require:
      - archive: terraform.binary
{% endif %}
