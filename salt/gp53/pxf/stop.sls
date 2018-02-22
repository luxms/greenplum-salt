{% set gpdb_version = pillar['vars']['gpdb_version'] %}

pxf-init:
  cmd.run:
    - cwd: /usr/local/gpdb-{{ gpdb_version }}
    - runas: gpadmin
    - env:
      - LC_ALL: ru_RU.UTF-8
      - LANG: ru_RU.UTF-8
    - name: |
        source /usr/local/gpdb/greenplum_path.sh
        export JAVA_HOME=/usr/java/jdk1.8.0_152
        pxf/bin/pxf stop
