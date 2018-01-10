include:
  - user

php.snmp.pkgs:
  pkg.installed:
    - name: snmp-mibs-downloader

php.sapis:
  pkg.installed:
    - pkgs:
      - php{{ pillar['php']['version'] }}-cli

php.extensions:
  pkg.installed:
    - pkgs:
      - php{{ pillar['php']['version'] }}-bcmath
      - php{{ pillar['php']['version'] }}-bz2
      - php{{ pillar['php']['version'] }}-curl
      - php{{ pillar['php']['version'] }}-dba
      - php{{ pillar['php']['version'] }}-enchant
      - php{{ pillar['php']['version'] }}-gd
      - php{{ pillar['php']['version'] }}-gmp
      - php{{ pillar['php']['version'] }}-imap
      - php{{ pillar['php']['version'] }}-interbase
      - php{{ pillar['php']['version'] }}-intl
      - php{{ pillar['php']['version'] }}-json
      - php{{ pillar['php']['version'] }}-ldap
      - php{{ pillar['php']['version'] }}-mbstring
      - php{{ pillar['php']['version'] }}-mcrypt
      - php{{ pillar['php']['version'] }}-mysql
      - php{{ pillar['php']['version'] }}-odbc
      - php{{ pillar['php']['version'] }}-opcache
      - php{{ pillar['php']['version'] }}-pgsql
      - php{{ pillar['php']['version'] }}-phpdbg
      - php{{ pillar['php']['version'] }}-pspell
      - php{{ pillar['php']['version'] }}-readline
      - php{{ pillar['php']['version'] }}-recode
      - php{{ pillar['php']['version'] }}-snmp
      - php{{ pillar['php']['version'] }}-soap
      - php{{ pillar['php']['version'] }}-sqlite3
      - php{{ pillar['php']['version'] }}-sybase
      - php{{ pillar['php']['version'] }}-tidy
      - php{{ pillar['php']['version'] }}-xml
      - php{{ pillar['php']['version'] }}-xmlrpc
      - php{{ pillar['php']['version'] }}-xsl
      - php{{ pillar['php']['version'] }}-zip
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
