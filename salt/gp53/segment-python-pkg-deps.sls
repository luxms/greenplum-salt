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
      - paramiko
      - epydoc
      - lockfile
      - PSI
    - upgrade: True
