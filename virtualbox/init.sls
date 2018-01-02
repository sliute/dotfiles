{% if grains['os'] == 'Ubuntu' %}
virtualbox.repo:
  pkgrepo.managed:
    - name: deb http://download.virtualbox.org/virtualbox/debian {{ grains['oscodename'] }} contrib
    - file: /etc/apt/sources.list.d/oracle-virtualbox.list
    - key_url: http://download.virtualbox.org/virtualbox/debian/oracle_vbox_2016.asc

virtualbox.pkg:
  pkg.latest:
    - name: virtualbox-{{ pillar['virtualbox']['version'] }}
{% endif %}

{% if grains['kernel'] == 'Linux' %}
virtualbox.extpack:
  cmd.run:
    - name: |
        if [ ! -f {{ pillar['virtualbox']['extension_pack_tmp'] }} ]; then
            wget -O {{ pillar['virtualbox']['extension_pack_tmp'] }} {{ pillar['virtualbox']['extension_pack_url'] }}
        fi
        yes | vboxmanage extpack install {{ pillar['virtualbox']['extension_pack_tmp'] }}
        rm -f {{ pillar['virtualbox']['extension_pack_tmp'] }}
    - unless: VBoxManage list extpacks | grep Usable | grep true
{% endif %}
