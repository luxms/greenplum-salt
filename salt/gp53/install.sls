{% set gpdb_version = pillar['vars']['gpdb_version'] %}

include:
  - gp.vars

greenplum-install:
  archive.extracted:
    - name: /usr/local/
    - source: salt://gp/gpdb-{{ gpdb_version }}.tar.gz
    - options: p

greenplum-install-softlink:
  file.symlink:
    - name: /usr/local/gpdb
    - target: /usr/local/gpdb-{{ gpdb_version }}
    - force: True
    - onlyif: test -d /usr/local/gpdb-{{ gpdb_version }}
