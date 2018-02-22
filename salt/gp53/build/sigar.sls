include: 
  - gp53.vars

git:
  pkg.installed

https://github.com/hyperic/sigar.git:
  git.latest:
    - rev: master
    - target: /tmp/libsigar
    - runas: admin
    - require:
      - pkg: git

foo_deployed:
  cmd.run:
    - cwd: /tmp/libsigar
    - runas: admin
    - name: |
        source scl_source enable devtoolset-6
        mkdir -p build
        cd build
        env CMAKE_C_FLAGS=-fgnu89-inline cmake3 ..
        make
        sudo make install
    - require:
      - git: https://github.com/hyperic/sigar.git
    - unless: ls /usr/local/lib/libsigar.so
