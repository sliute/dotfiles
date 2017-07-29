{% macro config_dirs(prefix, config_dir) %}
{{ prefix }}.config:
  file.recurse:
    - name: {{ config_dir }}
    - source: salt://{{ prefix }}/platform
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['group'] }}
    - dir_mode: 0750
    - file_mode: 0640

{% for directory in ['colors', 'plugins'] %}
{{ prefix }}.config.{{ directory }}:
  file.directory:
    - name: {{ config_dir }}/config/{{ directory }}
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['group'] }}
    - mode: 0750
    - require:
      - file: {{ prefix }}.config
{% endfor %}
{% endmacro %}

{% macro install_color(prefix, config_dir, source, basename, name) %}
{{ prefix }}.color.{{ basename }}:
  file.managed:
    - name: {{ config_dir }}/config/colors/{{ name }}.icls
    - source: salt://{{ source }}/platform/colors/{{ name }}.icls
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['group'] }}
    - mode: 0640
{% endmacro %}

{% macro install_colors(prefix, config_dir, source, colors) %}
{% for basename, color in colors.items() %}
{{ install_color(prefix, config_dir, source, basename, color['name']) }}
{% endfor %}
{% endmacro %}

{% macro install_plugin(prefix, config_dir, basename, name, source, source_hash) %}
{{ prefix }}.plugin.{{ basename }}.extract:
  archive.extracted:
    - name: {{ config_dir }}/config/plugins/{{ name }} temp
    - enforce_toplevel: False
    - source: {{ source }}
    - source_hash: {{ source_hash }}
    - require:
      - file: {{ prefix }}.config.plugins

{{ prefix }}.plugin.{{ basename }}.relocate:
  file.copy:
    - name: {{ config_dir }}/config/plugins/{{ name }}
    - source: {{ config_dir }}/config/plugins/{{ name }} temp/{{ name }}
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['group'] }}
    - force: True

{{ prefix }}.plugin.{{ basename }}.cleanup:
  file.absent:
    - name: {{ config_dir }}/config/plugins/{{ name }} temp
{% endmacro %}

{% macro install_plugins(prefix, config_dir, plugins) %}
{% for basename, plugin in plugins.items() %}
{{ install_plugin(
    prefix, config_dir, basename, plugin.get('name', basename),
    plugin['source'], plugin['source_hash']) }}
{% endfor %}
{% endmacro %}
