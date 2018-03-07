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

{% for file in ['attributes', 'ignore'] %}
git.~/.git{{ file }}:
  file.managed:
    - name: {{ pillar['user']['home'] }}/.git{{ file }}
    - source: salt://git/git/{{ file }}
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['group'] }}
    - mode: 0640
{% endfor %}
