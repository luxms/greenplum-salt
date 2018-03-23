{% set bld_user = pillar['vars']['bld_user'] %}

include: 
  - gp.vars

git:
  pkg.installed

#https://github.com/hyperic/sigar.git:
sigar-source:
  git.latest:
    - name: https://github.com/kostya/sigar.git
    - rev: master
    - target: /tmp/libsigar
    - runas: {{ bld_user }}
    - require:
      - pkg: git

sigar-compiled:
  cmd.run:
    - cwd: /tmp/libsigar
    - runas: {{ bld_user }}
    - name: |
        source scl_source enable devtoolset-6
        mkdir -p build
        cd build
        env CMAKE_C_FLAGS=-fgnu89-inline CFLAGS=-fgnu89-inline cmake3 ..
        make
    - require:
      - git: sigar-source
    - unless: ls /tmp/libsigar/build/build-src/libsigar.so

sigar-installed:
  cmd.run:
    - cwd: /tmp/libsigar/build
    - name: |
         make install
    - unless: ls /usr/local/lib/libsigar.so
