#{ % if pillar['redis'].repo is defined and pillar['redis'].repo == true %}
#{ % if pillar['redis'].repo is defined and pillar['redis'].repo == true %}
#  - .redis-repo
#{ % %}
#  - ???
#{ % endif %}
{% set gpdb_version = pillar['vars']['gpdb_version'] %}

include:
  - gp.vars

# wget https://codeload.github.com/greenplum-db/gpdb/tar.gz/5.5.0 -O gpdb-5.5.0.tar.gz
greenplum-install:
  archive.extracted:
    - name: /usr/local/
#   - source: /home/nouser/data/gpdb-{{ gpdb_version }}.tar.gz
    - source: salt://gp/gpdb-{{ gpdb_version }}.tar.gz
    - options: p

greenplum-install-softlink:
  file.symlink:
    - name: /usr/local/greenplum-db
    - target: /usr/local/gpdb-{{ gpdb_version }}
    - force: True
    - onlyif: test -d /usr/local/gpdb-{{ gpdb_version }}

greenplum-install-softlink-oth:
  file.symlink:
    - name: /usr/local/gpdb
    - target: /usr/local/gpdb-{{ gpdb_version }}
    - force: True
    - onlyif: test -d /usr/local/gpdb-{{ gpdb_version }}
