selinux-salt-deps:
  pkg.installed:
    - pkgs:
      - policycoreutils-python 
      - selinux-policy-targeted
      - xerces-c-devel

disabled:
  selinux.mode

firewalld:
  service.dead:
    - enable: False

ldconfig-file:
  file:
    - managed
    - source: salt://gp53/ld.so.conf.d/greenplum.conf
    - name: /etc/ld.so.conf.d/greenplum.conf
    - stateful: True

run-ldconfig:
  cmd.run:
    - name: ldconfig
    - onchanges:
      - file: /etc/ld.so.conf.d/greenplum.conf
