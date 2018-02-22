base:
  'mdw':
    - gp53.kernel
    - gp53.runtime
    - gp53.build-pkg-deps
    - gp53.python-deps
    - gp53.gpadmin
    - gp53.java.jdk8
    - gp53.pxf.build
    - gp53.build
    - gp53.dist
    - gp53.datadir
  'sdw*':
    - gp53.kernel
    - gp53.runtime
    - gp53.gpadmin
    - gp53.install
    - gp53.java.jdk9
    - gp53.datadir
    - gp53.segment-pkg-deps
    - gp53.segment-python-pkg-deps
    - gp53.pxf.hdp
    - gp53.pxf.connect-cfg
