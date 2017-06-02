include:
  - user

docker.linux-headers:
  pkg.latest:
    - pkgs:
      - linux-image-extra-{{ grains['kernelrelease'] }}
      - linux-image-extra-virtual

docker.apt:
  pkg.latest:
    - pkgs:
      - apt-transport-https
      - ca-certificates
      - curl
      - software-properties-common

docker.pkgrepo:
  pkgrepo.managed:
    - name: deb [arch={{ grains['osarch'] }}] https://download.docker.com/linux/ubuntu {{ grains['oscodename'] }} edge
    - file: /etc/apt/sources.list.d/docker.list
    - key_url: https://download.docker.com/linux/ubuntu/gpg

docker.pkg:
  pkg.latest:
    - name: docker-ce
    - require:
      - pkg: docker.linux-headers
      - pkg: docker.apt
      - pkgrepo: docker.pkgrepo

docker.compose:
  file.managed:
    - name: {{ pillar['user']['home'] }}{{ pillar['user']['bin_dir'] }}/docker-compose
    - source: https://github.com/docker/compose/releases/download/{{ pillar['docker']['compose']['version'] }}/docker-compose-{{ grains['kernel'] }}-{{ grains['cpuarch'] }}
    - skip_verify: True
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['name'] }}
    - mode: 0750
    - require:
      - file: user.bin_dir

docker.group:
  user.present:
    - name: {{ pillar['user']['name'] }}
    - remove_groups: False
    - optional_groups:
      - docker
    - require:
      - pkg: docker.pkg

docker.sh:
  file.managed:
    - name: {{ pillar['user']['home'] }}/.shrc.d/docker.sh
    - source: salt://docker/shrc.d/docker.sh
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['name'] }}
    - mode: 0640
