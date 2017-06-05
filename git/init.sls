git.pkgs:
  pkg.latest:
    - pkgs:
      - git
      - git-gui
      - meld

git.~/.gitconfig:
  file.managed:
    - name: {{ pillar['user']['home'] }}/.gitconfig
    - source: salt://git/git/config.jinja
    - template: jinja
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['group'] }}
    - mode: 0640

git.~/.gitignore:
  file.managed:
    - name: {{ pillar['user']['home'] }}/.gitignore
    - source: salt://git/git/ignore
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['group'] }}
    - mode: 0640
