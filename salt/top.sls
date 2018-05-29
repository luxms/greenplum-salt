base:
  'bld':
    - gp.build-pkg-deps
    - gp.python-deps
    - gp.gpadmin
    - gp.build
#   - gp.java.jdk8
#   - gp.pxf.build
    - gp.dist
  'mdw':
    - gp.kernel
    - gp.runtime
    - gp.gpadmin
    - gp.install
#   - gp.java.jdk8
    - gp.datadir
  'sdw*':
    - gp.kernel
    - gp.runtime
    - gp.gpadmin
    - gp.install
#   - gp.java.jdk8
    - gp.datadir
#   - gp.segment-pkg-deps
#   - gp.segment-python-pkg-deps
#   - gp.pxf.hdp
#   - gp.pxf.connect-cfg
