
# also, we need to setup public/private keys!!!
gpadmin:
  group:
    - present
  user.present:
    - fullname: Greenplum Admin
    - shell: /bin/bash
    - home: /home/gpadmin
    - gid_from_name: True
    - password: $1$5BQOz0RR$gNHfZNx5MyFXogW80DlTn1
    - groups:
      - tty
      - gpadmin
    - require:
      - group: gpadmin

source-gp-env:
  file.blockreplace:
    - name: /home/gpadmin/.bashrc
    - marker_start: "####Start SALT MANAGED Greenplum env ####"
    - marker_end:   "####End DO NOT EDIT !!! ###############"
    - append_if_not_found: True
    - content: |
        # Source definitions for Greenplum
        if [ -f /usr/local/gpdb/greenplum_path.sh ]; then
            source /usr/local/gpdb/greenplum_path.sh
        fi
 

{% set host = grains['id'] %}

{% if host == 'mdw' %}
generate_ssh_key_gpadmin:
  cmd.run:
    - name: ssh-keygen -q -N '' -f /home/gpadmin/.ssh/id_rsa
    - runas: gpadmin
    - unless: test -f /home/gpadmin/.ssh/id_rsa

dist_master_key:
  cmd.run:
    - cwd: /
    - runas: root
    - name: |
        cp /home/gpadmin/.ssh/id_rsa.pub /srv/salt/gp53/
        cp /home/gpadmin/.ssh/id_rsa /srv/salt/gp53/
    - require:
      - generate_ssh_key_gpadmin
{% endif %}
