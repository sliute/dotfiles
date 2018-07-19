include:
  - user

php.snmp.pkgs:
  pkg.installed:
    - name: snmp-mibs-downloader

php.sapis:
  pkg.installed:
    - pkgs:
{% for sapi in salt['pillar.get']('php:sapis', []) %}
      - php{{ pillar['php']['version'] }}-{{ sapi }}
{% endfor %}

php.extensions:
  pkg.installed:
    - pkgs:
{% for extension in salt['pillar.get']('php:extensions', []) %}
      - php{{ pillar['php']['version'] }}-{{ extension }}
{% endfor %}
    - require:
      - pkg: php.sapis

php.utils:
  pkg.installed:
    - pkgs:
      - php{{ pillar['php']['version'] }}-dev
      - php-pear
    - require:
      - pkg: php.sapis

php.composer.shell:
  file.managed:
    - name: {{ pillar['user']['home'] }}/.shrc.d/composer.sh
    - source: salt://php/shrc.d/composer.sh
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['group'] }}
    - mode: 0640

php.composer.binary:
  file.managed:
    - name: {{ pillar['user']['home'] }}{{ pillar['user']['bin_dir'] }}/composer
    - source: https://getcomposer.org/composer.phar
    - skip_verify: True
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['group'] }}
    - mode: 0750

php.composer.config:
  file.directory:
    - name: {{ pillar['user']['home'] }}{{ pillar['user']['config_dir'] }}/composer
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['group'] }}
    - mode: 0750
    - require:
      - file: user.config_dir

php.composer.config.keys.dev:
  file.managed:
    - name: {{ pillar['user']['home'] }}{{ pillar['user']['config_dir'] }}/composer/keys.dev.pub
    - source: salt://php/composer/keys/keys.dev.pub
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['group'] }}
    - mode: 0640
    - require:
      - file: php.composer.config

php.composer.config.keys.tags:
  file.managed:
    - name: {{ pillar['user']['home'] }}{{ pillar['user']['config_dir'] }}/composer/keys.tags.pub
    - source: salt://php/composer/keys/keys.tags.pub
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['group'] }}
    - mode: 0640
    - require:
      - file: php.composer.config

php.composer.global:
  file.managed:
    - name: {{ pillar['user']['home'] }}{{ pillar['user']['config_dir'] }}/composer/composer.json
    - source: salt://php/composer/composer.json
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['group'] }}
    - mode: 0640
    - require:
      - file: php.composer.config

php.cgr:
  composer.installed:
    - name: {{ pillar['user']['home'] }}{{ pillar['user']['config_dir'] }}/composer
    - composer: {{ pillar['user']['home'] }}{{ pillar['user']['bin_dir'] }}/composer
    - composer_home: {{ pillar['user']['home'] }}{{ pillar['user']['config_dir'] }}/composer
    - user: {{ pillar['user']['name'] }}
    - require:
      - file: php.composer.binary
      - file: php.composer.config.keys.dev
      - file: php.composer.config.keys.tags
      - file: php.composer.global
