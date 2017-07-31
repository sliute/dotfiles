{% from 'jetbrains-toolbox/macros.sls'
import config_dirs, install_colors, install_plugins %}
{% set config_dir = pillar['user']['home'] + '/.RubyMine2017.2' %}

{{ config_dirs('rubymine', config_dir) }}

{{ install_colors(
    'rubymine', config_dir, 'jetbrains-toolbox',
    salt['pillar.get']('jetbrains-toolbox:common:colors', {})) }}
{{ install_colors(
    'rubymine', config_dir, 'rubymine',
    salt['pillar.get']('jetbrains-toolbox:rubymine:colors', {})) }}

{{ install_plugins(
    'rubymine', config_dir,
    salt['pillar.get']('jetbrains-toolbox:common:plugins', {})) }}
{{ install_plugins(
    'rubymine', config_dir,
    salt['pillar.get']('jetbrains-toolbox:rubymine:plugins', {})) }}
