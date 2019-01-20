atom.hunspell.en-gb:
  pkg.latest:
    - name: hunspell-en-gb

atom.core:
  pkgrepo.managed:
    - ppa: webupd8team/atom
  pkg.latest:
    - name: atom

atom.clang-format:
  pkg.latest:
    - name: clang-format

atom.~/.atom:
  file.directory:
    - name: {{ pillar['user']['home'] }}/.atom
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['group'] }}
    - mode: 0750

{% for file in ['config.cson', 'keymap.cson'] %}
atom.~/.atom/{{ file }}:
  file.managed:
    - name: {{ pillar['user']['home'] }}/.atom/{{ file }}
    - source: salt://atom/atom/{{ file }}
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['group'] }}
    - mode: 0640
{% endfor %}

atom.pkgs:
  atompkg.latest:
    - runas: {{ pillar['user']['name'] }}
    - pkgs:
      - Zen
      - advanced-open-file
      - atom-ctags
      - atom-ide-ui
      - atom-jinja2
      - autocomplete-clang
      - base16-ocean-dark-syntax-theme
      - clang-format
      - editorconfig
      - emmet
      - file-icons
      - highlight-line
      - ide-csharp
      - ide-java
      - ide-php
      - ide-typescript
      - language-cmake
      - language-docker
      - language-glsl
      - language-gradle
      - language-hcl
      - language-nginx
      - language-powershell
      - linter
      - linter-alex
      - linter-ui-default
      - minimap
      - minimap-autohide
      - minimap-codeglance
      - minimap-cursorline
      - minimap-find-and-replace
      - minimap-git-diff
      - minimap-linter
      - minimap-split-diff
      - pigments
      - sort-all-the-things
      - split-diff
