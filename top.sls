base:
  'kernel:Linux':
    - match: grain
    - sh
    - gnome
    - gnome-terminal

  '*':
    - atom
    - git
    - google-chrome
    - vim
