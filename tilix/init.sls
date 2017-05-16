tilix.repo:
  pkgrepo.managed:
    - ppa: webupd8team/terminix

tilix.pkg:
  pkg.latest:
    - name: tilix

tilix.com.gexperts.Tilix.profiles.list:
  gsettings.managed:
    - schema: com.gexperts.Tilix.ProfilesList
    - name: list
    - value:
      - 2b7c4080-0ddd-46c5-8f23-563fd3ba789d
      - 8624eae2-809a-4ed6-b26b-4311e37e34c0
    - runas: {{ pillar['user']['name'] }}

tilix.com.gexperts.Tilix.profiles.default:
  gsettings.managed:
    - schema: com.gexperts.Tilix.ProfilesList
    - name: default
    - value: 8624eae2-809a-4ed6-b26b-4311e37e34c0
    - runas: {{ pillar['user']['name'] }}

tilix.com.gexperts.Tilix.profile.base16-ocean-dark.palette:
  gsettings.managed:
    - schema: com.gexperts.Tilix.Profile
    - path: /com/gexperts/Tilix/profiles/8624eae2-809a-4ed6-b26b-4311e37e34c0/
    - name: palette
    - value:
      - rgb(43,48,59)
      - rgb(191,97,106)
      - rgb(163,190,140)
      - rgb(235,203,139)
      - rgb(143,161,179)
      - rgb(180,142,173)
      - rgb(150,181,180)
      - rgb(192,197,206)
      - rgb(101,115,126)
      - rgb(191,97,106)
      - rgb(163,190,140)
      - rgb(235,203,139)
      - rgb(143,161,179)
      - rgb(180,142,173)
      - rgb(150,181,180)
      - rgb(239,241,245)
    - runas: {{ pillar['user']['name'] }}

tilix.com.gexperts.Tilix.profile.base16-ocean-dark.scrollback-unlimited:
  gsettings.managed:
    - schema: com.gexperts.Tilix.Profile
    - path: /com/gexperts/Tilix/profiles/8624eae2-809a-4ed6-b26b-4311e37e34c0/
    - name: scrollback-unlimited
    - value: True
    - runas: {{ pillar['user']['name'] }}

tilix.com.gexperts.Tilix.profile.base16-ocean-dark.visible-name:
  gsettings.managed:
    - schema: com.gexperts.Tilix.Profile
    - path: /com/gexperts/Tilix/profiles/8624eae2-809a-4ed6-b26b-4311e37e34c0/
    - name: visible-name
    - value: Base16 (Ocean Dark)
    - runas: {{ pillar['user']['name'] }}
