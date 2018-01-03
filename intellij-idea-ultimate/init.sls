{% from 'jetbrains-toolbox/macros.sls'
import config_dirs, install_colors, install_plugins %}
{% set config_dir = pillar['user']['home'] + '/.IntelliJIdea'
    + pillar['jetbrains-toolbox']['versions']['intellij-idea-ultimate'] %}

include:
  - android-sdk
  - java

{{ config_dirs('intellij-idea-ultimate', config_dir) }}

{{ install_colors(
    'intellij-idea-ultimate', config_dir, 'jetbrains-toolbox',
    salt['pillar.get']('jetbrains-toolbox:common:colors', {})) }}
{{ install_colors(
    'intellij-idea-ultimate', config_dir, 'intellij-idea-ultimate',
    salt['pillar.get']('jetbrains-toolbox:intellij-idea-ultimate:colors', {})) }}

{{ install_plugins(
    'intellij-idea-ultimate', config_dir,
    salt['pillar.get']('jetbrains-toolbox:common:plugins', {})) }}
{{ install_plugins(
    'intellij-idea-ultimate', config_dir,
    salt['pillar.get']('jetbrains-toolbox:intellij-idea-ultimate:plugins', {})) }}
