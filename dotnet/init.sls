dotnet.repo:
  pkgrepo.managed:
    - name: deb [arch=amd64] https://apt-mo.trafficmanager.net/repos/dotnet-release/ yakkety main
    - file: /etc/apt/sources.list.d/dotnetdev.list
    - keyid: 417A0893
    - keyserver: hkp://keyserver.ubuntu.com:80

dotnet.pkgs:
  pkg.installed:
    - pkgs:
      - dotnet-dev-1.0.4
