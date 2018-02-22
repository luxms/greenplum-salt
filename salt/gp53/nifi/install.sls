include:
  - gp53.vars

# salt internal http loader (Tornado) does not respect env vars for proxy settings :-(
# https://github.com/saltstack/salt/issues/23617
# should we switch to ansible?

download-nifi:
  cmd.run:
    - name: "wget -q -O /srv/salt/gp53/nifi/nifi-1.5.0-bin.tar.gz http://apache-mirror.rbc.ru/pub/apache/nifi/1.5.0/nifi-1.5.0-bin.tar.gz"
    - creates: /srv/salt/gp53/nifi/nifi-1.5.0-bin.tar.gz

nifi-install:
  archive.extracted:
    - name: /usr/local/
    - source: salt://gp53/nifi/nifi-1.5.0-bin.tar.gz
    - source_hash: md5=3a74c126e81ba88f0aedf49c395ff5d1
    - archive_format: tar
    - user: root
    - options: z

