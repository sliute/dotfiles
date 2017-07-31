{% from 'jetbrains-toolbox/macros.sls'
import config_dirs, install_colors, install_plugins %}
{% set config_dir = pillar['user']['home'] + '/.Rider2017.1' %}

include:
  - dotnet

{{ config_dirs('rider', config_dir) }}

{{ install_colors(
    'rider', config_dir, 'jetbrains-toolbox',
    salt['pillar.get']('jetbrains-toolbox:common:colors', {})) }}
{{ install_colors(
    'rider', config_dir, 'rider',
    salt['pillar.get']('jetbrains-toolbox:rider:colors', {})) }}

{{ install_plugins(
    'rider', config_dir,
    salt['pillar.get']('jetbrains-toolbox:common:plugins', {})) }}
{{ install_plugins(
    'rider', config_dir,
    salt['pillar.get']('jetbrains-toolbox:rider:plugins', {})) }}
