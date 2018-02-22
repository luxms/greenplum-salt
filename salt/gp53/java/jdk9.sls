include: 
  - gp53.vars

# https://howtoprogram.xyz/2017/09/22/install-oracle-java-9-centos-rhel/
# https://gist.github.com/P7h/9741922
# wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/9.0.1+11/jdk-9.0.1_linux-x64_bin.rpm"
# curl --silent -C - -LR#OH "Cookie: oraclelicense=accept-securebackup-cookie" -k http://download.oracle.com/otn-pub/java/jdk/9.0.1+11/jdk-9.0.1_linux-x64_bin.tar.gz

{% set host = grains['id'] %}

{% if host == 'mdw' %}
greenplum-dist:
  cmd.run:
    - cwd: /srv/salt/gp53/java
    - runas: root
    - name: |
        wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/9.0.1+11/jdk-9.0.1_linux-x64_bin.rpm"
    - unless: "ls jdk-9.0.1_linux-x64_bin.rpm"
{% endif %}

{% set version = 'jdk-9.0.1' %}

jdk-install-rpm:
    pkg.installed:
       - sources:
         - {{ version }}: salt://gp53/java/{{version}}_linux-x64_bin.rpm

java-home-env:
  file.blockreplace:
    - name: /home/gpadmin/.bashrc
    - marker_start: "####Start SALT MANAGED Java env DO NOT EDIT !!! ####"
    - marker_end:   "####End   SALT MANAGED Java env DO NOT EDIT !!! ###############"
    - append_if_not_found: True
    - content: |
        if [ -d /usr/java/{{ version }} ]; then
               export JAVA_HOME=/usr/java/{{ version }}
        fi
