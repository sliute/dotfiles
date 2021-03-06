base:
  'kernel:Linux':
    - match: grain
    - sh
    - gnome
    - gnome-terminal
    - tilix
    - remmina
    - nvm
    - docker

  '*':
    - atom
    - emmet
    - git
    - google-chrome
    - packer
    - terraform
    - vagrant
    - vim
    - virtualbox
