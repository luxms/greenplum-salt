{% set gpdb_version = pillar['vars']['gpdb_version'] %}


include:
  - gp.vars

greenplum-db-source:
  cmd.run:
    - name: curl https://codeload.github.com/greenplum-db/gpdb/tar.gz/{{ gpdb_version }} | tar xz
    - runas: gpadmin
    - cwd: /tmp/
    - unless: ls -d /tmp/gpdb-{{ gpdb_version }}

greenplum-build-orca:
  cmd.run:
    - cwd: /tmp/gpdb-{{ gpdb_version }}/depends
    - runas: gpadmin
    - name: |
        source scl_source enable devtoolset-6
        ./configure
        make -j4
    - require:
      - greenplum-db-source
    - unless: ls /tmp/gpdb-{{ gpdb_version }}/depends/build/lib/libgpopt.so

greenplum-build-gpbackup:
  cmd.run:
    - cwd: /tmp/gpdb-{{ gpdb_version }}/depends
    - runas: gpadmin
    - name: |
        source scl_source enable devtoolset-6
        CONAN_USER_HOME=/tmp/gpdb-{{ gpdb_version }}/depends CONAN_CMAKE_GENERATOR=Ninja conan install -s build_type=Release --build=gpbackup conanfile_gpbackup.txt
    - require:
      - greenplum-db-source
    - unless: ls /tmp/gpdb-{{ gpdb_version }}/depends/gpbackup/bin/gpbackup

greenplum-build:
  cmd.run:
    - cwd: /tmp/gpdb-{{ gpdb_version }}
    - runas: gpadmin
    - name: |
        source scl_source enable devtoolset-6
        LD_LIBRARY_PATH=/tmp/gpdb-{{ gpdb_version }}/depends/build/lib ./configure \
        --with-libraries=/tmp/gpdb-{{ gpdb_version }}/depends/build/lib \
        --with-includes=/tmp/gpdb-{{ gpdb_version }}/depends/build/include \
        --with-perl --with-python --with-libxml --with-libxslt --with-gssapi --with-openssl --enable-orca --enable-gpperfmon --disable-segwalrep \
        --prefix=/usr/local/gpdb-{{ gpdb_version }} 
        make -j4
        
    - require:
      - greenplum-db-source
      - greenplum-build-orca
    - unless: ls /tmp/gpdb-{{ gpdb_version }}/src/bin/pg_config/pg_config
    
