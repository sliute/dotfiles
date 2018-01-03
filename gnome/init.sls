gnome.pkgs:
  pkg.latest:
    - pkgs:
      - gnome-documents

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
      - firefox.desktop
      - google-chrome.desktop
      - org.gnome.Nautilus.desktop
      - com.gexperts.Tilix.desktop
      - virtualbox.desktop
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

gnome.gdm.theme:
  alternatives.set:
    - name: gdm3.css
    - path: /usr/share/gnome-shell/theme/gnome-shell.css

gnome.shell.extension-dir:
  file.directory:
    - name: {{ pillar['user']['home'] }}/.local/share/gnome-shell/extensions
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['group'] }}
    - mode: 0700

gnome.shell.extensions:
  gnomeshellpkg.installed:
    - uuids:
      - alternate-tab@gnome-shell-extensions.gcampax.github.com
      - appindicatorsupport@rgcjonas.gmail.com
      - caffeine@patapon.info
      - user-theme@gnome-shell-extensions.gcampax.github.com
    - runas: {{ pillar['user']['name'] }}

gnome.gsettings.org.gnome.shell.enabled-extensions:
  gsettings.managed:
    - schema: org.gnome.shell
    - name: enabled-extensions
    - value:
      - alternate-tab@gnome-shell-extensions.gcampax.github.com
      - appindicatorsupport@rgcjonas.gmail.com
      - caffeine@patapon.info
      - user-theme@gnome-shell-extensions.gcampax.github.com
    - runas: {{ pillar['user']['name'] }}
    - require:
      - gnome.shell.extensions

gnome.arc-theme:
  pkg.latest:
    - name: arc-theme

gnome.arc-theme.gtk-theme:
  gsettings.managed:
    - schema: org.gnome.desktop.interface
    - name: gtk-theme
    - value: Arc-Darker
    - runas: {{ pillar['user']['name'] }}
    - require:
      - gnome.arc-theme

gnome.arc-theme.shell-theme:
  gsettings.managed:
    - schema: org.gnome.shell.extensions.user-theme
    - name: name
    - value: Arc-Dark
    - runas: {{ pillar['user']['name'] }}
    - require:
      - gnome.arc-theme
      - gnome.gsettings.org.gnome.shell.enabled-extensions
