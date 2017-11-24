dotnet.repo:
  pkgrepo.managed:
    - name: deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-{{ grains['oscodename'] }}-prod {{ grains['oscodename'] }} main
    - file: /etc/apt/sources.list.d/dotnetdev.list
    - keyid: 417A0893
    - keyserver: hkp://keyserver.ubuntu.com:80

dotnet.pkgs:
  pkg.installed:
    - pkgs:
      - dotnet-dev-1.0.4
      - dotnet-sdk-2.0.3
