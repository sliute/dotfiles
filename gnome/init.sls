gnome.gsettings.org.gnome.desktop.interface.clock-show-date:
  gsettings.managed:
    - schema: org.gnome.desktop.interface
    - name: clock-show-date
    - value: True
    - runas: {{ pillar['user']['name'] }}
