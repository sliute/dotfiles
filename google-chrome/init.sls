{% if grains['os'] == 'Ubuntu' %}
google-chrome.repo:
  pkgrepo.managed:
    - name: deb [arch={{ grains['osarch'] }}] http://dl.google.com/linux/chrome/deb/ stable main
    - file: /etc/apt/sources.list.d/google-chrome.list
    - key_url: https://dl-ssl.google.com/linux/linux_signing_key.pub

google-chrome.pkg:
  pkg.installed:
    - name: google-chrome-stable
{% endif %}

google-chrome.~/.config/google-chrome:
  file.directory:
    - name: {{ pillar['user']['home'] }}/.config/google-chrome
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['group'] }}
    - mode: 0750

google-chrome.~/.config/google-chrome/local-state:
  file.managed:
    - name: {{ pillar['user']['home'] }}/.config/google-chrome/Local State
    - source: salt://google-chrome/google-chrome/local-state.json.jinja
    - template: jinja
    - replace: False
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['group'] }}
    - mode: 0640

{% for profile in pillar['google_chrome']['profiles'] if profile['slug'] != 'Default' %}
google-chrome.profile.{{ profile['slug'] }}:
  file.managed:
    - name: {{ pillar['user']['home'] }}/.local/share/applications/google-chrome-{{ profile['slug'] }}.desktop
    - source: salt://google-chrome/applications/google-chrome-profile.desktop.jinja
    - template: jinja
    - context:
      profile: {{ profile | yaml }}
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['group'] }}
    - mode: 0640
{% endfor %}
