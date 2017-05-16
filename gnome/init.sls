gnome.gsettings.org.gnome.settings-daemon.plugins.color.night-light-enabled:
  gsettings.managed:
    - schema: org.gnome.settings-daemon.plugins.color
    - name: night-light-enabled
    - value: True
    - runas: {{ pillar['user']['name'] }}

gnome.gsettings.org.gnome.shell.app-picker-view:
  gsettings.managed:
    - schema: org.gnome.shell
    - name: app-picker-view
    - value: 1
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

gnome.gsettings.org.gnome.books.night-mode:
  gsettings.managed:
    - schema: org.gnome.books
    - name: night-mode
    - value: True
    - runas: {{ pillar['user']['name'] }}

gnome.gsettings.org.gnome.documents.night-mode:
  gsettings.managed:
    - schema: org.gnome.documents
    - name: night-mode
    - value: True
    - runas: {{ pillar['user']['name'] }}

gnome.gsettings.org.gnome.shell.favorite-apps:
  gsettings.managed:
    - schema: org.gnome.shell
    - name: favorite-apps
    - value:
      - google-chrome.desktop
      - nautilus.desktop
      - gnome-terminal.desktop
    - runas: {{ pillar['user']['name'] }}

gnome.gsettings.org.gnome.desktop.wm.keybindings.show-desktop:
  gsettings.managed:
    - schema: org.gnome.desktop.wm.keybindings
    - name: show-desktop
    - value: []
    - runas: {{ pillar['user']['name'] }}

gnome.gsettings.org.gnome.gnome-system-monitor.show-dependencies:
  gsettings.managed:
    - schema: org.gnome.gnome-system-monitor
    - name: show-dependencies
    - value: True
    - runas: {{ pillar['user']['name'] }}

gnome.gsettings.org.gnome.gnome-system-monitor.show-whose-processes:
  gsettings.managed:
    - schema: org.gnome.gnome-system-monitor
    - name: show-whose-processes
    - value: all
    - runas: {{ pillar['user']['name'] }}

gnome.gsettings.org.gnome.nautilus.preferences.default-folder-viewer:
  gsettings.managed:
    - schema: org.gnome.nautilus.preferences
    - name: default-folder-viewer
    - value: list-view
    - runas: {{ pillar['user']['name'] }}

gnome.gsettings.org.gnome.nautilus.list-view.use-tree-view:
  gsettings.managed:
    - schema: org.gnome.nautilus.list-view
    - name: use-tree-view
    - value: true
    - runas: {{ pillar['user']['name'] }}
