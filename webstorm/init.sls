{% from 'jetbrains-toolbox/macros.sls'
import config_dirs, install_colors, install_plugins %}
{% set config_dir = pillar['user']['home'] + '/.WebStorm2017.2' %}

{{ config_dirs('webstorm', config_dir) }}

{{ install_colors(
    'webstorm', config_dir, 'jetbrains-toolbox',
    salt['pillar.get']('jetbrains-toolbox:common:colors', {})) }}
{{ install_colors(
    'webstorm', config_dir, 'webstorm',
    salt['pillar.get']('jetbrains-toolbox:webstorm:colors', {})) }}

{{ install_plugins(
    'webstorm', config_dir,
    salt['pillar.get']('jetbrains-toolbox:common:plugins', {})) }}
{{ install_plugins(
    'webstorm', config_dir,
    salt['pillar.get']('jetbrains-toolbox:webstorm:plugins', {})) }}
