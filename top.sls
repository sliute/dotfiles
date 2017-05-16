base:
  'kernel:Linux':
    - match: grain
    - sh
    - gnome
    - gnome-terminal
    - tilix
    - remmina
    - nvm

  '*':
    - atom
    - git
    - google-chrome
    - packer
    - terraform
    - vagrant
    - vim
    - virtualbox
