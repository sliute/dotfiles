user.bin_dir:
  file.directory:
    - name: {{ pillar['user']['home'] }}{{ pillar['user']['bin_dir'] }}
    - makedirs: True
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['group'] }}
    - mode: 0750

user.config_dir:
  file.directory:
    - name: {{ pillar['user']['home'] }}{{ pillar['user']['config_dir'] }}
    - makedirs: True
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['group'] }}
    - mode: 0700

user.local_share_dir:
  file.directory:
    - name: {{ pillar['user']['home'] }}{{ pillar['user']['local_share_dir'] }}
    - makedirs: True
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['group'] }}
    - mode: 0700

user.code_dir:
  file.directory:
    - name: {{ pillar['user']['home'] }}{{ pillar['user']['code_dir'] }}
    - makedirs: True
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['group'] }}
    - mode: 0700
