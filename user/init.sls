user.bin_dir:
  file.directory:
    - name: {{ pillar['user']['home'] }}{{ pillar['user']['bin_dir'] }}
    - makedirs: True
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['name'] }}
    - mode: 0750
