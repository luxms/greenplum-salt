/etc/hadoop/conf/core-site.xml:
  file.managed:
    - source: salt://gp53/pxf/core-site.xml
    
/etc/hadoop/conf/hdfs-site.xml:
  file.managed:
    - source: salt://gp53/pxf/hdfs-site.xml
    
/etc/hadoop/conf/mapred-site.xml:
  file.managed:
    - source: salt://gp53/pxf/mapred-site.xml

ld-library-path:
  file.replace:
    - name: /usr/local/gpdb/pxf/conf/pxf-env.sh
    - pattern: 'export LD_LIBRARY_PATH.*'
    - repl: 'export LD_LIBRARY_PATH=/usr/hdp/2.6.3.0-235/hadoop/lib/native:/usr/hdp/2.6.3.0-235/hadoop/lib/native/Linux-amd64-64:${LD_LIBRARY_PATH}'

hadoop-distro:
  file.replace:
    - name: /usr/local/gpdb/pxf/conf/pxf-env.sh
    - pattern: 'export HADOOP_DISTRO.*'
    - repl: 'export HADOOP_DISTRO=HDP'


hadoop-root:
  file.replace:
    - name: /usr/local/gpdb/pxf/conf/pxf-env.sh
    - pattern: 'export HADOOP_ROOT.*'
    - repl: 'export HADOOP_ROOT=/usr/hdp/2.6.3.0-235'

hive-jdbc:
  file.blockreplace:
    - name: /usr/local/gpdb/pxf/conf/pxf-private.classpath
    - marker_start: "####Start SALT MANAGED Greenplum HIVE JDBC ####"
    - marker_end:   "####End Greenplum HIVE JDBC DO NOT EDIT !!! ###############"
    - append_if_not_found: True
    - content: |
        /usr/hdp/current/hive-client/lib/hive-jdbc.jar
        /usr/hdp/current/hive-client/lib/httpclient-4.4.jar
        /usr/hdp/current/hive-client/lib/httpcore-4.4.jar
        /usr/hdp/current/hive-client/lib/hive-service.jar
        
hive-missed-hdp-libs:
  file.blockreplace:
    - name: /usr/local/gpdb/pxf/conf/pxf-private.classpath
    - marker_start: "####Start SALT MANAGED Greenplum HIVE LIBS  ####"
    - marker_end:   "####End Greenplum HIVE LIBS DO NOT EDIT !!! ###############"
    - append_if_not_found: True
    - content: |
        /usr/hdp/current/hadoop-client/lib/hadoop-lzo-*[0-9].jar
