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
    - packer
    - terraform
    - vagrant
    - vim
    - virtualbox
