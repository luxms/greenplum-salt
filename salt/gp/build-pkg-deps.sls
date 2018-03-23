{% if grains['os'] == 'CentOS' %}
  {% set use_scl = True %}
{% endif %}


{% if use_scl %}
scl:
  pkg.installed:
    - pkgs: 
      - centos-release-scl
{%endif %}


gpdb-deps:
  pkg.installed:
    - pkgs:
      - devtoolset-6
      - readline-devel
      - apr-devel
      - apr-util-devel
      - libevent-devel
      - openssl-devel
      - libxml2-devel
      - libxslt-devel
      - xerces-c-devel
      - golang # for compiling gpbackup
      - bzip2-devel
      - libyaml-devel
      - cmake3
      - ninja-build

cmake_soft_link:
  cmd.run:
    - runas: root
    - name: ln -sf ../../bin/cmake3 /usr/local/bin/cmake
    - unless: ls /usr/local/bin/cmake
