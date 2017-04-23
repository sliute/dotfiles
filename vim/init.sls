{% if grains['kernel'] == 'Linux' %}
vim.core:
  pkg.installed:
    - name: vim
{% endif %}
