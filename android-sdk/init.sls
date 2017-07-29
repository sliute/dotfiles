{% from 'android-sdk/macros.sls' import install_sdk_package %}
{% set sdk_dir = pillar['user']['home'] + '/.android' %}
{% set udev_dir = '/opt/android-udev-rules' %}

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

{{ install_sdk_package(sdk_dir, 'platform-tools') }}

{% for platform in pillar['android-sdk']['platforms'] %}
{{ install_sdk_package(sdk_dir, 'platforms;' + platform) }}
{% endfor %}

android-sdk.udev.repo:
  git.latest:
    - name: https://github.com/M0Rf30/android-udev-rules.git
    - target: {{ udev_dir }}
    - rev: master
    - user: root

android-sdk.udev.udev:
  file.symlink:
    - name: /etc/udev/rules.d/51-android.rules
    - target: {{ udev_dir }}/51-android.rules

android-sdk.udev.adb-usb:
  file.symlink:
    - name: {{ sdk_dir }}/adb_usb.ini
    - target: {{ udev_dir }}/adb_usb.ini
