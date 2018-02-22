# openJDK and python bullshit and tzdata go as dependency for hadoop-lzo-native, I don' know why !!!
pxf-deps:
  pkg.installed:
    - pkgs:
      - lzo
      - lzo-devel
      - java-1.6.0-openjdk 
      - javapackages-tools
      - python-javapackages
      - tzdata-java
