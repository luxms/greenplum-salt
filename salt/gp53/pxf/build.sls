include:
  - gp.vars
# - gp53.vars

#git:
#  pkg.installed

hawk-source:
  git.latest:
    - name: https://git-wip-us.apache.org/repos/asf/incubator-hawq.git
    - rev: master
    - target: /tmp/hawk
    - runas: gpadmin
    - force_reset: True
    - require:
      - pkg: git

use-proxy-for-gradle1:
  file.replace:
    - name: /tmp/hawk/pxf/gradle.properties
    - pattern: 'systemProp.http.proxyHost=.*'
    - repl: 'systemProp.http.proxyHost=localhost'
    - count: 1
    - append_if_not_found: True

use-proxy-for-gradle2:
  file.replace:
    - name: /tmp/hawk/pxf/gradle.properties
    - pattern: 'systemProp.http.proxyPort=.*'
    - repl: 'systemProp.http.proxyPort=3128'
    - count: 1
    - append_if_not_found: True

use-proxy-for-gradle3:
  file.replace:
    - name: /tmp/hawk/pxf/gradle.properties
    - pattern: 'systemProp.https.proxyHost=.*'
    - repl: 'systemProp.https.proxyHost=localhost'
    - count: 1
    - append_if_not_found: True

use-proxy-for-gradle4:
  file.replace:
    - name: /tmp/hawk/pxf/gradle.properties
    - pattern: 'systemProp.https.proxyPort=.*'
    - repl: 'systemProp.https.proxyPort=3128'
    - count: 1
    - append_if_not_found: True

hive-version:
  file.replace:
    - name: /tmp/hawk/pxf/gradle.properties
    - pattern: 'hiveVersion=.*'
    - repl: 'hiveVersion=1.2.1'
    - count: 1
    - append_if_not_found: True

hadoop-version:
  file.replace:
    - name: /tmp/hawk/pxf/gradle.properties
    - pattern: 'hadoopVersion=.*'
    - repl: 'hadoopVersion=2.7.3'
    - count: 1
    - append_if_not_found: True

hbase-version-jar:
  file.replace:
    - name: /tmp/hawk/pxf/gradle.properties
    - pattern: 'hbaseVersionJar=.*'
    - repl: 'hbaseVersionJar=1.1.2'
    - count: 1
    - append_if_not_found: True

hbase-version-rpm:
  file.replace:
    - name: /tmp/hawk/pxf/gradle.properties
    - pattern: 'hbaseVersionRPM=.*'
    - repl: 'hbaseVersionRPM=1.1.2'
    - count: 1
    - append_if_not_found: True

os-family:
  file.replace:
    - name: /tmp/hawk/pxf/gradle.properties
    - pattern: 'osFamily=.*'
    - repl: 'osFamily=el7'
    - count: 1
    - append_if_not_found: True

tomcat7:
  file.replace:
    - name: /tmp/hawk/pxf/gradle.properties
    - pattern: 'tomcatVersion=.*'
    - repl: 'tomcatVersion=7.0.82'
    - count: 1
    - append_if_not_found: True

pxf-build:
  cmd.run:
    - cwd: /tmp/hawk/pxf
    - runas: gpadmin
    - env:
      - LC_ALL: ru_RU.UTF-8
      - LANG: ru_RU.UTF-8
    - name: |
        source scl_source enable devtoolset-6
        source /usr/local/gpdb/greenplum_path.sh
        make clean
        make bundle DATABASE=gpdb
    - require:
      - hawk-source

copy-bundle:
  cmd.run:
    - cwd: /tmp/hawk/pxf
    - runas: root
    - name: |
         cp ./distributions/pxf-3.3.0.0.tar.gz /srv/salt/gp53/pxf/
    - require:
      - pxf-build

