dotnet.repo:
  pkgrepo.managed:
    - name: deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-{{ grains['oscodename'] }}-prod {{ grains['oscodename'] }} main
    - file: /etc/apt/sources.list.d/dotnetdev.list

dotnet.pkgs:
  pkg.installed:
    - pkgs:
      - dotnet-sdk-{{ pillar['dotnet']['sdk_version'] }}
