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

docker.group:
  user.present:
    - name: {{ pillar['user']['name'] }}
    - remove_groups: False
    - optional_groups:
      - docker
    - require:
      - pkg: docker.pkg
