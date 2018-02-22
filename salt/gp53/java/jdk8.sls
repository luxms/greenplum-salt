include: 
  - gp53.vars

# https://howtoprogram.xyz/2017/09/22/install-oracle-java-9-centos-rhel/
# https://gist.github.com/P7h/9741922
# wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/9.0.1+11/jdk-9.0.1_linux-x64_bin.rpm"
# curl --silent -C - -LR#OH "Cookie: oraclelicense=accept-securebackup-cookie" -k http://download.oracle.com/otn-pub/java/jdk/9.0.1+11/jdk-9.0.1_linux-x64_bin.tar.gz

# https://lv.binarybabel.org/catalog/java/jdk8
#
{% set host = grains['id'] %}

{% if host == 'mdw' %}
greenplum-dist:
  cmd.run:
    - cwd: /srv/salt/gp53/java
    - runas: root
    - name: |
        wget --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u152-b16/aa0333dd3019491ca4f6ddbe78cdb6d0/jdk-8u152-linux-x64.rpm"
    - unless: "ls jdk-8u152-linux-x64.rpm"
{% endif %}

{% set version = 'jdk-8u152' %}
{% set java_home = 'jdk1.8.0_152' %}

jdk-install-rpm:
    pkg.installed:
       - sources:
         - {{ version }}: salt://gp53/java/{{version}}-linux-x64.rpm

java-home-env:
  file.blockreplace:
    - name: /home/gpadmin/.bashrc
    - marker_start: "####Start SALT MANAGED Java env DO NOT EDIT !!! ####"
    - marker_end:   "####End   SALT MANAGED Java env DO NOT EDIT !!! ###############"
    - append_if_not_found: True
    - content: |
        if [ -d /usr/java/{{ java_home }} ]; then
               export JAVA_HOME=/usr/java/{{ java_home }}
        fi
