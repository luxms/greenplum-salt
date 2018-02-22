{% set gpdb_version = pillar['vars']['gpdb_version'] %}

pxf-init:
  cmd.run:
    - cwd: /usr/local/gpdb-{{ gpdb_version }}/pxf
    - runas: gpadmin
    - env:
      - LC_ALL: ru_RU.UTF-8
      - LANG: ru_RU.UTF-8
      - PXF_PORT: 51200
      - HADOOP_DISTRO: HDP
      - HADOOP_ROOT: '/usr/hdp/2.6.3.0-235'

    - name: |
        source /usr/local/gpdb-{{ gpdb_version }}/greenplum_path.sh
        export JAVA_HOME=/usr/java/jdk1.8.0_152
        source /usr/local/gpdb-{{ gpdb_version }}/pxf/conf/pxf-env.sh
        bin/pxf start
