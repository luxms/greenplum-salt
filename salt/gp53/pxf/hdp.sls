include:
  - gp53.vars

/etc/yum.repos.d/hdp.repo:
    file.managed:
      - source: salt://gp53/pxf/hdp.repo
      - skip_verify: True

pxf-deps:
  pkg.installed:
    - require: 
      - /etc/yum.repos.d/hdp.repo
    - pkgs:
      - hadoop-client
      - hive
      - hbase
      - snappy
      - snappy-devel
      - hadooplzo 
      - hadooplzo-native
