user.user:
  user.present:
    - name: {{ pillar['user']['name'] }}
    - groups:
      - {{ pillar['user']['group'] }}
    - optional_groups:
{% for group in salt['pillar.get']('user:groups', []) %}
      - {{ group }}
{% endfor %}
    - remove_groups: False

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
