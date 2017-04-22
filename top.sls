base:
  'kernel:Linux':
    - match: grain
    - gnome
    - gnome-terminal

  '*':
    - atom
    - git
