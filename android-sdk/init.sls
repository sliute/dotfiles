{% set sdk_dir = pillar['user']['home'] + '/.android' %}

android-sdk.remove-previous:
  cmd.run:
    - name: rm -rf {{ sdk_dir | yaml_squote }}
    - unless: |
        grep \
                {{ pillar['android-sdk']['version'] }} \
                {{ sdk_dir | yaml_squote }}/version

android-sdk.sdk:
  archive.extracted:
    - name: {{ sdk_dir }}
    - source: https://dl.google.com/android/repository/sdk-tools-linux-{{ pillar['android-sdk']['version'] }}.zip
    - source_hash: {{ pillar['android-sdk']['source_hash'] }}
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['group'] }}
    - if_missing: {{ sdk_dir }}

android-sdk.version:
  file.managed:
    - name: {{ sdk_dir }}/version
    - contents_pillar: android-sdk:version
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['group'] }}
    - mode: 0640
    - require:
      - android-sdk.sdk

android-sdk.licenses:
  cmd.run:
    - name: yes | {{ sdk_dir }}/tools/bin/sdkmanager --licenses
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['group'] }}
    - require:
      - android-sdk.sdk

{% for platform in pillar['android-sdk']['platforms'] %}
android-sdk.platform.{{ platform }}:
  cmd.run:
    - name: {{ sdk_dir }}/tools/bin/sdkmanager 'platforms;{{ platform }}'
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['group'] }}
    - require:
      - android-sdk.sdk
      - android-sdk.licenses
{% endfor %}
