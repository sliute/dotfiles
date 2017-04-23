gnome.gsettings.org.gnome.settings-daemon.plugins.color.night-light-enabled:
  gsettings.managed:
    - schema: org.gnome.settings-daemon.plugins.color
    - name: night-light-enabled
    - value: True
    - runas: {{ pillar['user']['name'] }}

gnome.gsettings.org.gnome.desktop.interface.clock-show-date:
  gsettings.managed:
    - schema: org.gnome.desktop.interface
    - name: clock-show-date
    - value: True
    - runas: {{ pillar['user']['name'] }}

gnome.gtk.~/.config/gtk-3.0/settings.ini:
  file.managed:
    - name: {{ pillar['user']['home'] }}/.config/gtk-3.0/settings.ini
    - source: salt://gnome/gtk/settings.ini
