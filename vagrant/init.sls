{% if grains['os'] == 'Ubuntu' %}
vagrant.pkg:
  pkg.installed:
    - sources:
      - vagrant: {{ pillar['vagrant']['package_url'] }}
{% endif %}
