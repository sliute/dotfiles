{% set vim_dir = pillar['user']['home'] + '/.vim' %}
{% set config_dir = vim_dir + '/config' %}
{% set bundle_dir = vim_dir + '/bundle' %}

{% if grains['kernel'] == 'Linux' %}
vim.core:
  pkg.installed:
    - pkgs:
      - git
      - vim
{% endif %}

vim.vim:
  file.directory:
    - name: {{ vim_dir }}
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['group'] }}
    - mode: 0750

vim.vimrc:
  file.managed:
    - name: {{ pillar['user']['home'] }}/.vimrc
    - source: salt://vim/vim/vimrc.jinja
    - template: jinja
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['group'] }}
    - mode: 0640
    - require:
      - file: vim.vim

vim.vim.config:
  file.directory:
    - name: {{ config_dir }}
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['group'] }}
    - mode: 0750
    - require:
      - file: vim.vim

{% for name in salt['pillar.get']('vim:config', {}).keys() %}
vim.vim.config.{{ name }}:
  file.managed:
    - name: {{ config_dir }}/{{ name }}
    - contents_pillar: vim:config:{{ name }}
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['group'] }}
    - mode: 0750
    - require:
      - file: vim.vim.config
{% endfor %}

vim.bundle:
  file.directory:
    - name: {{ bundle_dir }}
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['group'] }}
    - mode: 0750
    - require:
      - file: vim.vim.config

vim.bundle.vundle.vim:
  git.latest:
    - name: https://github.com/VundleVim/Vundle.vim.git
    - target: {{ bundle_dir }}/vundle.vim
    - user: {{ pillar['user']['name'] }}
    - require:
      - file: vim.bundle

# Since Vundle updates packages via git reset --hard origin/HEAD it needs the
# origin/HEAD ref to point at the default branch on the origin remote. For some
# reason, git.latest doesn't preserve this.
vim.bundle.vundle.vim.head:
  cmd.run:
    - name: 'git symbolic-ref refs/remotes/origin/HEAD refs/remotes/origin/master'
    - cwd: {{ bundle_dir }}/vundle.vim
    - runas: {{ pillar['user']['name'] }}
    - unless: 'git show-ref | grep refs/remotes/origin/HEAD'
    - require:
      - git: vim.bundle.vundle.vim

vim.vundle:
  file.managed:
    - name: {{ vim_dir }}/vundle
    - source: salt://vim/vim/vundle.jinja
    - template: jinja
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['group'] }}
    - mode: 0750
