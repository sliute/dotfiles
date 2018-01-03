{% from 'jetbrains-toolbox/macros.sls'
import config_dirs, install_colors, install_plugins %}
{% set config_dir = pillar['user']['home'] + '/.DataGrip'
    + pillar['jetbrains-toolbox']['versions']['datagrip'] %}

{{ config_dirs('datagrip', config_dir) }}

{{ install_colors(
    'datagrip', config_dir, 'jetbrains-toolbox',
    salt['pillar.get']('jetbrains-toolbox:common:colors', {})) }}
{{ install_colors(
    'datagrip', config_dir, 'datagrip',
    salt['pillar.get']('jetbrains-toolbox:datagrip:colors', {})) }}

{{ install_plugins(
    'datagrip', config_dir,
    salt['pillar.get']('jetbrains-toolbox:common:plugins', {})) }}
{{ install_plugins(
    'datagrip', config_dir,
    salt['pillar.get']('jetbrains-toolbox:datagrip:plugins', {})) }}
