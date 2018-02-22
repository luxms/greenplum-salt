
# also, we need to setup public/private keys!!!

{% set host = grains['id'] %}

{% if host == 'mdw' %}

dist_master_key:
  cmd.run:
    - cwd: /
    - runas: root
    - name: |
        cp /root/.ssh/id_rsa.pub /srv/salt/gp53/root_rsa.pub
{% endif %}


sshkeys:
  ssh_auth.present:
    - user: root
    - source: salt://gp53/root_rsa.pub
