{% from 'jetbrains-toolbox/macros.sls'
import config_dirs, install_colors, install_plugins %}
{% set config_dir = pillar['user']['home'] + '/.GoLand'
    + pillar['jetbrains-toolbox']['versions']['goland'] %}

{{ config_dirs('goland', config_dir) }}

{{ install_colors(
    'goland', config_dir, 'jetbrains-toolbox',
    salt['pillar.get']('jetbrains-toolbox:common:colors', {})) }}
{{ install_colors(
    'goland', config_dir, 'goland',
    salt['pillar.get']('jetbrains-toolbox:goland:colors', {})) }}

{{ install_plugins(
    'goland', config_dir,
    salt['pillar.get']('jetbrains-toolbox:common:plugins', {})) }}
{{ install_plugins(
    'goland', config_dir,
    salt['pillar.get']('jetbrains-toolbox:goland:plugins', {})) }}
