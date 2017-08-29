{% if grains['os'] == 'Ubuntu' %}
vagrant.pkg:
  pkg.installed:
    - sources:
      - vagrant: {{ pillar['vagrant']['package_url'] }}

vagrant.bash-completion.pkg:
  pkg.installed:
    - sources:
      - vagrant-bash-completion: {{ pillar['vagrant']['bash_completion_package_url'] }}
{% endif %}
