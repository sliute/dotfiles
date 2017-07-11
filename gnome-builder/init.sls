include:
  - user

gnome-builder.pkgs:
  pkg.installed:
    - pkgs:
      - gnome-builder

gnome-builder.projects-directory:
  gsettings.managed:
    - schema: org.gnome.builder
    - name: projects-directory
    - value: {{ pillar['user']['home'] }}{{ pillar['user']['code_dir'] }}
    - runas: {{ pillar['user']['name'] }}
    - require:
      - file: user.code_dir
