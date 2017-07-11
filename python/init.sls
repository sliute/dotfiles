python.pkgs:
  pkg.latest:
    - pkgs:
      - python
      - python-pip

python.modules:
  pip.installed:
    - pkgs:
      - maybe
    - user: {{ pillar['user']['name'] }}
