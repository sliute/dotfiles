gnome-terminal.org.gnome.terminal.legacy.default-show-menubar:
  gsettings.managed:
    - schema: org.gnome.Terminal.Legacy.Settings
    - name: default-show-menubar
    - value: False
    - runas: {{ pillar['user']['name'] }}

gnome-terminal.org.gnome.terminal.legacy.theme-variant:
  gsettings.managed:
    - schema: org.gnome.Terminal.Legacy.Settings
    - name: theme-variant
    - value: dark
    - runas: {{ pillar['user']['name'] }}

gnome-terminal.org.gnome.terminal.profileslist.list:
  gsettings.managed:
    - schema: org.gnome.Terminal.ProfilesList
    - name: list
    - value:
      - b1dcc9dd-5262-4d8d-a863-c897e6d979b9
      - 87f7eb7f-b7d1-4841-908f-d3f3ae29fa99
    - runas: {{ pillar['user']['name'] }}

gnome-terminal.org.gnome.terminal.profileslist.default:
  gsettings.managed:
    - schema: org.gnome.Terminal.ProfilesList
    - name: default
    - value: 87f7eb7f-b7d1-4841-908f-d3f3ae29fa99
    - runas: {{ pillar['user']['name'] }}

gnome-terminal.org.gnome.terminal.profile.base16-ocean-dark.palette:
  gsettings.managed:
    - schema: org.gnome.Terminal.Legacy.Profile
    - path: /org/gnome/terminal/legacy/profiles:/:87f7eb7f-b7d1-4841-908f-d3f3ae29fa99/
    - name: palette
    - value:
      - rgb(43,48,59)
      - rgb(191,97,106)
      - rgb(163,190,140)
      - rgb(235,203,139)
      - rgb(143,161,179)
      - rgb(180,142,173)
      - rgb(150,181,180)
      - rgb(192,197,206)
      - rgb(101,115,126)
      - rgb(191,97,106)
      - rgb(163,190,140)
      - rgb(235,203,139)
      - rgb(143,161,179)
      - rgb(180,142,173)
      - rgb(150,181,180)
      - rgb(239,241,245)
    - runas: {{ pillar['user']['name'] }}

gnome-terminal.org.gnome.terminal.profile.base16-ocean-dark.scrollback-unlimited:
  gsettings.managed:
    - schema: org.gnome.Terminal.Legacy.Profile
    - path: /org/gnome/terminal/legacy/profiles:/:87f7eb7f-b7d1-4841-908f-d3f3ae29fa99/
    - name: scrollback-unlimited
    - value: True
    - runas: {{ pillar['user']['name'] }}

gnome-terminal.org.gnome.terminal.profile.base16-ocean-dark.use-theme-colors:
  gsettings.managed:
    - schema: org.gnome.Terminal.Legacy.Profile
    - path: /org/gnome/terminal/legacy/profiles:/:87f7eb7f-b7d1-4841-908f-d3f3ae29fa99/
    - name: use-theme-colors
    - value: True
    - runas: {{ pillar['user']['name'] }}

gnome-terminal.org.gnome.terminal.profile.base16-ocean-dark.visible-name:
  gsettings.managed:
    - schema: org.gnome.Terminal.Legacy.Profile
    - path: /org/gnome/terminal/legacy/profiles:/:87f7eb7f-b7d1-4841-908f-d3f3ae29fa99/
    - name: visible-name
    - value: Base16 (Ocean Dark)
    - runas: {{ pillar['user']['name'] }}
