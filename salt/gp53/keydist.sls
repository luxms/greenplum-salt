{% set addrs = salt['mine.get']('*', 'network.ip_addrs') %}

sshkeys:
  ssh_auth.present:
    - user: gpadmin
    - source: salt://gp53/id_rsa.pub

id_rsa:
  file:
    - managed
    - source: salt://gp53/id_rsa
    - name: /home/gpadmin/.ssh/id_rsa
    - user: gpadmin
    - group: gpadmin
    - mode: 600

id_rsa_pub:
  file:
    - managed
    - source: salt://gp53/id_rsa.pub
    - name: /home/gpadmin/.ssh/id_rsa.pub
    - user: gpadmin
    - group: gpadmin
    - mode: 600
