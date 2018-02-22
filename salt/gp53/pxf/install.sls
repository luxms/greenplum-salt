{% set gpdb_version = pillar['vars']['gpdb_version'] %}

include:
  - gp.vars

pxf-install:
  archive.extracted:
    - name: /usr/local/gpdb-{{ gpdb_version }}
    - user: gpadmin
    - source: salt://gp53/pxf/pxf-3.3.0.0.tar.gz
    - options: p

{% for file in ['pxf-api','pxf-hbase','pxf-hdfs','pxf-hive','pxf-jdbc','pxf-json','pxf-service']%}
jarfile-link-{{ file }}:
  file.symlink:
    - name: /usr/local/gpdb-{{ gpdb_version }}/pxf/lib/{{ file }}.jar
    - target: /usr/local/gpdb-{{ gpdb_version }}/pxf/lib/{{ file }}-3.3.0.0.jar
    - force: True
    - onlyif: test -f /usr/local/gpdb-{{ gpdb_version }}/pxf/lib/{{ file }}-3.3.0.0.jar
{% endfor %}  
