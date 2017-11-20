{% for pair in pillar.get('alternatives', []) %}
alternatives.{{ pair.keys()[0] }}:
  alternatives.set:
    - name: {{ pair.keys()[0] }}
    - path: {{ pair[pair.keys()[0]] }}
{% endfor %}
