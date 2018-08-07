selinux-salt-deps:
  pkg.installed:
    - pkgs:
      - policycoreutils-python
      - selinux-policy-targeted
      - xerces-c-devel
      - python-paramiko
      - python-setuptools
      - python-lockfile
      - net-tools
      - htop
      - hostname
      - openssh-server
      - libevent
      - apr-util

disabled:
  selinux.mode

firewalld:
  service.dead:
    - enable: False

# systemctl enable sshd.service
# systemctl start sshd.service
sshd:
  service.running:
    - enable: True
    - reload: True

#sshd_service:
# - require:
#    selinux-salt-deps

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
