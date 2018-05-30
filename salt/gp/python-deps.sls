{% set bld_user = pillar['vars']['bld_user'] %}


include:
  - gp.vars

pip-deps:
  pkg.installed:
    - names:
      - python2-pip
      - python-devel
      - curl-devel
      - gcc
      - gcc-c++
      - bison
      - flex
      - m4
      - perl-ExtUtils-Embed
      - perl-ExtUtils-MakeMaker
#   - reload_modules: True

# for: salt 2018.3.0 (Oxygen) # salt --version
# fix pip import error in pip 10.0.0 #47121
# https://github.com/saltstack/salt/pull/47121
# https://github.com/pcjeff/salt/blob/e81cf80519d750b16c9b52375bfd0287af91461e/salt/states/pip_state.py
# cd /usr/lib/python2.7/site-packages/salt/states
# rm -rf pip_state.pyo pip_state.pyc
# mv pip_state.py.bug
# wget https://raw.githubusercontent.com/pcjeff/salt/e81cf80519d750b16c9b52375bfd0287af91461e/salt/states/pip_state.py
#
# OR
#
# yum reinstall python-pip   #  python2-pip      noarch      8.1.2-5.el7

#pip-upgr:
#  cmd.run:
#    - name: pip install --upgrade pip

python-modules:
  pip.installed:
    - require: # Require means only install this if the following is already installed
      - pip-deps
#   - mirrors: http://a.pypi.python.org
    - names:
      - psutil
      - lockfile
      - paramiko
      - setuptools
      - epydoc
      - PSI
      - conan
#   - env_vars:
#       http_proxy: socks5://localhost:3128
#       https_proxy: socks5://localhost:3128
#   - upgrade: True

conan_repo_added:
  cmd.run:
    - user: {{ bld_user }} 
    - name: conan remote add GP https://api.bintray.com/conan/greenplum-db/gpdb-oss
    - unless: "conan remote list | grep GP:"

