{% from 'jetbrains-toolbox/macros.sls'
import config_dirs, install_colors, install_plugins %}
{% set config_dir = pillar['user']['home'] + '/.CLion'
    + pillar['jetbrains-toolbox']['versions']['clion'] %}

{{ config_dirs('clion', config_dir) }}

{{ install_colors(
    'clion', config_dir, 'jetbrains-toolbox',
    salt['pillar.get']('jetbrains-toolbox:common:colors', {})) }}
{{ install_colors(
    'clion', config_dir, 'clion',
    salt['pillar.get']('jetbrains-toolbox:clion:colors', {})) }}

{{ install_plugins(
    'clion', config_dir,
    salt['pillar.get']('jetbrains-toolbox:common:plugins', {})) }}
{{ install_plugins(
    'clion', config_dir,
    salt['pillar.get']('jetbrains-toolbox:clion:plugins', {})) }}
