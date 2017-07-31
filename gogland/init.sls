{% from 'jetbrains-toolbox/macros.sls'
import config_dirs, install_colors, install_plugins %}
{% set config_dir = pillar['user']['home'] + '/.Gogland1.0' %}

{{ config_dirs('gogland', config_dir) }}

{{ install_colors(
    'gogland', config_dir, 'jetbrains-toolbox',
    salt['pillar.get']('jetbrains-toolbox:common:colors', {})) }}
{{ install_colors(
    'gogland', config_dir, 'gogland',
    salt['pillar.get']('jetbrains-toolbox:gogland:colors', {})) }}

{{ install_plugins(
    'gogland', config_dir,
    salt['pillar.get']('jetbrains-toolbox:common:plugins', {})) }}
{{ install_plugins(
    'gogland', config_dir,
    salt['pillar.get']('jetbrains-toolbox:gogland:plugins', {})) }}
