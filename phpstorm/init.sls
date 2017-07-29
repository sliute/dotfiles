{% from 'jetbrains-toolbox/macros.sls'
    import config_dirs, install_colors, install_plugins %}
{% set config_dir = pillar['user']['home'] + '/.PhpStorm2017.2' %}

{{ config_dirs('phpstorm', config_dir) }}

{{ install_colors(
    'phpstorm', config_dir, 'jetbrains-toolbox',
    salt['pillar.get']('jetbrains-toolbox:common:colors', {})) }}
{{ install_colors(
    'phpstorm', config_dir, 'phpstorm',
    salt['pillar.get']('jetbrains-toolbox:phpstorm:colors', {})) }}

{{ install_plugins(
    'phpstorm', config_dir,
    salt['pillar.get']('jetbrains-toolbox:common:plugins', {})) }}
{{ install_plugins(
    'phpstorm', config_dir,
    salt['pillar.get']('jetbrains-toolbox:phpstorm:plugins', {})) }}
