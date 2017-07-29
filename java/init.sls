java.jdks:
  pkg.installed:
    - pkgs:
{% for version in pillar['java']['versions'] %}
      - {{ version }}
{% endfor %}

java.default:
  alternatives.set:
    - name: java
    - path: /usr/lib/jvm/{{ pillar['java']['default'] }}/jre/bin/java
