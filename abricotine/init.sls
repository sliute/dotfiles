abricotine.pkg:
  pkg.installed:
    - sources:
      - abricotine: {{ pillar['abricotine']['source_url']}}
