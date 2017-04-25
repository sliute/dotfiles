base:
  'kernel:Linux':
    - match: grain
    - sh
    - gnome
    - gnome-terminal
    - remmina

  '*':
    - atom
    - git
    - google-chrome
    - terraform
    - vagrant
    - vim
    - virtualbox
