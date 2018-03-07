git.pkgs:
  pkg.latest:
    - pkgs:
      - aeson-pretty
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
    - require_in:
      - file: git.~/.gitconfig
{% endfor %}

git.~/.gittextconv:
  file.directory:
    - name: {{ pillar['user']['home'] }}/.gittextconv
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['group'] }}
    - mode: 0750

{% for helper in ['json'] %}
git.~/.gittextconv/{{ helper }}:
  file.managed:
    - name: {{ pillar['user']['home'] }}/.gittextconv/{{ helper }}
    - source: salt://git/textconv/{{ helper }}
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['group'] }}
    - mode: 0750
    - require:
      - file: git.~/.gittextconv
    - require_in:
      - file: git.~/.gitconfig
{% endfor %}
