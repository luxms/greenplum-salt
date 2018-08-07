{% set gpdb_version = pillar['vars']['gpdb_version'] %}
{% set bld_path = pillar['vars']['bld_path'] %}

include:
  - gp.vars
  - gp.build.gpdb
# - gp53.build.gpdb

# will install on MASTER only AND will create tar.gz for dist to the segments!
#

greenplum-install-local:
  cmd.run:
    - cwd: {{ bld_path }}/gpdb-{{ gpdb_version }}
    - runas: root
    - name: |
        source scl_source enable devtoolset-6
        make install
        [ -d /usr/local/gpdb{{ gpdb_version }} ] && [ ! -L /usr/local/gpdb ] && ln -s gpdb-{{ gpdb_version }}/usr/local/gpdb
        cd depends
        cp -R --preserve=links build/* /usr/local/gpdb-{{ gpdb_version }}
        cp -R --preserve=links gpbackup/* /usr/local/gpdb-{{ gpdb_version }}
        # rm -f /usr/local/gpdb-{{ gpdb_version }}/gpdb53
    - require:
      - greenplum-build

greenplum-dist:
  cmd.run:
    - cwd: {{ bld_path }}/gpdb-{{ gpdb_version }}
    - runas: root
    - name: |
        tar czf /srv/salt/gp/gpdb-{{ gpdb_version }}.tar.gz -C /usr/local gpdb-{{ gpdb_version }}
        # tar czf /srv/salt/gp/gpdb-{{ gpdb_version }}.tar.gz -C /usr/local gpdb-{{ gpdb_version }}
    - require:
      - greenplum-install-local
