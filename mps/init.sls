{% from 'jetbrains-toolbox/macros.sls'
import config_dirs, install_colors, install_plugins %}
{% set config_dir = pillar['user']['home'] + '/.MPS2017.1' %}

{{ config_dirs('mps', config_dir) }}

{{ install_colors(
    'mps', config_dir, 'jetbrains-toolbox',
    salt['pillar.get']('jetbrains-toolbox:common:colors', {})) }}
{{ install_colors(
    'mps', config_dir, 'mps',
    salt['pillar.get']('jetbrains-toolbox:mps:colors', {})) }}

{{ install_plugins(
    'mps', config_dir,
    salt['pillar.get']('jetbrains-toolbox:common:plugins', {})) }}
{{ install_plugins(
    'mps', config_dir,
    salt['pillar.get']('jetbrains-toolbox:mps:plugins', {})) }}
