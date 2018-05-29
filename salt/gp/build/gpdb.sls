{% set gpdb_version = pillar['vars']['gpdb_version'] %}
{% set bld_user = pillar['vars']['bld_user'] %}
{% set bld_path = pillar['vars']['bld_path'] %}

include:
  - gp.vars

greenplum-db-source:
  cmd.run:
    - name: curl https://codeload.github.com/greenplum-db/gpdb/tar.gz/{{ gpdb_version }} | tar xz
    - runas: {{ bld_user }}
    - cwd: {{ bld_path }}/
    - unless: ls -d {{ bld_path }}/gpdb-{{ gpdb_version }}

greenplum-build-orca:
  cmd.run:
    - cwd: {{ bld_path }}/gpdb-{{ gpdb_version }}/depends
    - runas: {{ bld_user }}
    - name: |
        conan remote add conan-gpdb https://api.bintray.com/conan/greenplum-db/gpdb-oss
        source scl_source enable devtoolset-6
        ./configure
        make -j4
    - require:
      - greenplum-db-source
    - unless: ls {{ bld_path }}/gpdb-{{ gpdb_version }}/depends/build/lib/libgpopt.so

greenplum-build-gpbackup:
  cmd.run:
    - cwd: {{ bld_path }}/gpdb-{{ gpdb_version }}/depends
    - runas: {{ bld_user }}
    - name: |
        source scl_source enable devtoolset-6
        CONAN_USER_HOME={{ bld_path }}/gpdb-{{ gpdb_version }}/depends CONAN_CMAKE_GENERATOR=Ninja conan install -s build_type=Release --build=gpbackup conanfile_gpbackup.txt
    - require:
      - greenplum-db-source
    - unless: ls {{ bld_path }}/gpdb-{{ gpdb_version }}/depends/gpbackup/bin/gpbackup

greenplum-build:
  cmd.run:
    - cwd: {{ bld_path }}/gpdb-{{ gpdb_version }}
    - runas: {{ bld_user }}
    - name: |
        source scl_source enable devtoolset-6
        LD_LIBRARY_PATH={{ bld_path }}/gpdb-{{ gpdb_version }}/depends/build/lib ./configure \
        --with-libraries={{ bld_path }}/gpdb-{{ gpdb_version }}/depends/build/lib \
        --with-includes={{ bld_path }}/gpdb-{{ gpdb_version }}/depends/build/include \
        --with-perl --with-python --with-libxml --with-libxslt --with-gssapi --with-openssl --enable-orca --enable-gpperfmon --disable-segwalrep \
        --prefix=/usr/local/gpdb-{{ gpdb_version }} 
        make -j4

    - require:
      - greenplum-db-source
      - greenplum-build-orca
    - unless: ls {{ bld_path }}/gpdb-{{ gpdb_version }}/src/bin/pg_config/pg_config

