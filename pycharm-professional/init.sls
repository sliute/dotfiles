{% from 'jetbrains-toolbox/macros.sls'
import config_dirs, install_colors, install_plugins %}
{% set config_dir = pillar['user']['home'] + '/.PyCharm2017.2' %}

{{ config_dirs('pycharm-professional', config_dir) }}

{{ install_colors(
    'pycharm-professional', config_dir, 'jetbrains-toolbox',
    salt['pillar.get']('jetbrains-toolbox:common:colors', {})) }}
{{ install_colors(
    'pycharm-professional', config_dir, 'pycharm-professional',
    salt['pillar.get']('jetbrains-toolbox:pycharm:colors', {})) }}

{{ install_plugins(
    'pycharm-professional', config_dir,
    salt['pillar.get']('jetbrains-toolbox:common:plugins', {})) }}
{{ install_plugins(
    'pycharm-professional', config_dir,
    salt['pillar.get']('jetbrains-toolbox:pycharm:plugins', {})) }}
