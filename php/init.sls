include:
  - user

php.sapis:
  pkg.installed:
    - pkgs:
      - php7.0-cli

php.extensions:
  pkg.installed:
    - pkgs:
      - php7.0-bcmath
      - php7.0-bz2
      - php7.0-curl
      - php7.0-dba
      - php7.0-enchant
      - php7.0-gd
      - php7.0-gmp
      - php7.0-imap
      - php7.0-interbase
      - php7.0-intl
      - php7.0-json
      - php7.0-ldap
      - php7.0-mbstring
      - php7.0-mcrypt
      - php7.0-mysql
      - php7.0-odbc
      - php7.0-opcache
      - php7.0-pgsql
      - php7.0-phpdbg
      - php7.0-pspell
      - php7.0-readline
      - php7.0-recode
      - php7.0-snmp
      - php7.0-soap
      - php7.0-sqlite3
      - php7.0-sybase
      - php7.0-tidy
      - php7.0-xml
      - php7.0-xmlrpc
      - php7.0-xsl
      - php7.0-zip
    - require:
      - pkg: php.sapis

php.utils:
  pkg.installed:
    - pkgs:
      - php7.0-dev
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
