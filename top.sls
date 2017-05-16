base:
  'kernel:Linux':
    - match: grain
    - sh
    - gnome
    - gnome-terminal
    - tilix
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
