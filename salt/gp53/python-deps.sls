include:
  - gp53.vars

pip-deps:
  pkg.installed:
    - name: python2-pip


python_modules:
  pip.installed:
    - require: # Require means only install this if the following is already installed
      - pkg: python2-pip 
    - names:
      - psutil
      - lockfile
      - paramiko
      - setuptools
      - epydoc
      - PSI
      - conan
#    - env_vars:
#        http_proxy: socks5://localhost:3128
#        https_proxy: socks5://localhost:3128
    - upgrade: True

conan_repo_added:
  cmd.run:
    - user: admin
    - name: conan remote add GP https://api.bintray.com/conan/greenplum-db/gpdb-oss
    - unless: "conan remote list | grep GP:"

