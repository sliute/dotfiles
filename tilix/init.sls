{% set config_dir = pillar['user']['home'] + '/.config/tilix' %}
{% set scheme_dir = config_dir + '/schemes' %}

{%
  set scheme_profile_option_map = {
    'use-theme-colors':           'use-theme-colors',
    'palette':                    'palette',
    'background-color':           'background-color',
    'foreground-color':           'foreground-color',
    'use-cursor-color':           'cursor-colors-set',
    'cursor-background-color':    'cursor-background-color',
    'cursor-foreground-color':    'cursor-foreground-color',
    'use-highlight-color':        'highlight-colors-set',
    'highlight-background-color': 'highlight-background-color',
    'highlight-foreground-color': 'highlight-foreground-color',
  }
%}

{% macro tilix_profile_option(profile, option, value, runas) %}
tilix.profile.{{ profile }}.{{ option }}:
  gsettings.managed:
    - schema: com.gexperts.Tilix.Profile
    - path: /com/gexperts/Tilix/profiles/{{ profile }}/
    - name: {{ option }}
    - value: {{ value }}
    - runas: {{ runas }}
{% endmacro %}

tilix.pkg:
  pkg.latest:
    - name: tilix

tilix.default:
  alternatives.set:
    - name: x-terminal-emulator
    - path: /usr/bin/tilix

tilix.config:
  file.directory:
    - name: {{ config_dir }}
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['group'] }}
    - mode: 0750

tilix.config.schemes:
  file.directory:
    - name: {{ scheme_dir }}
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['group'] }}
    - mode: 0750

{% for scheme in salt['pillar.get']('tilix:schemes', {}).keys() %}
tilix.config.schemes.{{ scheme }}:
  file.managed:
    - name: {{ scheme_dir }}/{{ scheme }}.json
    - source: salt://tilix/tilix/scheme.json.jinja
    - template: jinja
    - context:
      scheme: {{ scheme }}
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['group'] }}
    - mode: 0640
{% endfor %}

tilix.profiles.list:
  gsettings.managed:
    - schema: com.gexperts.Tilix.ProfilesList
    - name: list
    - value:
{% for profile in pillar['tilix']['profiles'].keys() %}
      - {{ profile }}
{% endfor %}
    - runas: {{ pillar['user']['name'] }}

{% for profile, values in pillar['tilix']['profiles'].items() %}
  {% for option, value in values.items() %}
    {% if option == 'scheme' %}
      {% set scheme = pillar['tilix']['schemes'][value] %}
      {% for scheme_option, profile_option in scheme_profile_option_map.items() %}
        {% if scheme_option in scheme %}
        {% set scheme_value = scheme[scheme_option] %}
        {% if scheme_value is string %}
          {% set scheme_value = scheme_value | yaml_squote %}
        {% endif %}
{{ tilix_profile_option(
    profile, profile_option, scheme_value,
    pillar['user']['name']) }}
        {% endif %}
      {% endfor %}
    {% else %}
{{ tilix_profile_option(
    profile, option, value, pillar['user']['name']) }}
    {% endif %}
  {% endfor %}
{% endfor %}

tilix.default_profile:
  gsettings.managed:
    - schema: com.gexperts.Tilix.ProfilesList
    - name: default
    - value: {{ pillar['tilix']['default_profile'] }}
    - runas: {{ pillar['user']['name'] }}
