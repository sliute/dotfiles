{% macro install_sdk_package(sdk_dir, package) %}
android-sdk.package.{{ package }}:
  cmd.run:
    - name: {{ sdk_dir }}/tools/bin/sdkmanager {{ package | yaml_squote }}
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['group'] }}
    - require:
      - android-sdk.sdk
      - android-sdk.licenses
{% endmacro %}
