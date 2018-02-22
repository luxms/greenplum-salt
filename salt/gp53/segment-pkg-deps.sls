yum-fix:
  file.append:
    - name: /etc/yum.conf
    - text:
      - timeout=1
      - retries=1


hadoop-deps:
  pkg.installed:
    - pkgs:
      - cups-client
      - libtirpc-devel
      - nmap-ncat
      - redhat-lsb-core
      - redhat-lsb-submod-security
      - spax
      - python2-pip
