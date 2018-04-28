rust.rustup-init.dir:
  file.directory:
    - name: {{ pillar['user']['home'] }}/.cargo
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['group'] }}
    - mode: 0750

rust.rustup-init.bin:
  file.managed:
    - name: {{ pillar['user']['home'] }}/.cargo/rustup-init
    - source: https://static.rust-lang.org/rustup/archive/{{ pillar['rust']['rustup']['version'] }}/{{ pillar['rust']['rustup']['host'] }}/rustup-init
    - source_hash: {{ pillar['rust']['rustup']['source_hash'] }}
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['group'] }}
    - mode: 0750
    - require:
      - file: rust.rustup-init.dir

rust.rustup-init.run:
  cmd.run:
    - name: {{ pillar['user']['home'] }}/.cargo/rustup-init -y --no-modify-path --default-toolchain {{ pillar['rust']['rustup']['toolchain'] }} --default-host {{ pillar['rust']['rustup']['host'] }}
    - runas: {{ pillar['user']['name'] }}
    - require:
      - file: rust.rustup-init.bin

rust.shell:
  file.managed:
    - name: {{ pillar['user']['home'] }}/.shrc.d/rust.sh
    - source: salt://rust/shrc.d/rust.sh
    - user: {{ pillar['user']['name'] }}
    - group: {{ pillar['user']['group'] }}
    - mode: 0640
