{% set gpdb_version = pillar['vars']['gpdb_version'] %}

pxf-init:
  cmd.run:
    - cwd: /usr/local/gpdb-{{ gpdb_version }}
    - runas: gpadmin
    - env:
      - LC_ALL: ru_RU.UTF-8
      - LANG: ru_RU.UTF-8
    - name: |
        source /usr/local/gpdb-{{ gpdb_version }}/greenplum_path.sh
        pxf/bin/pxf init
