# https://stackoverflow.com/questions/33953099/salt-and-managing-ssh-authorized-keys
# https://docs.saltstack.com/en/latest/ref/states/all/salt.states.ssh_auth.html
# https://serverfault.com/questions/779950/saltstack-call-a-single-state-of-a-sls-file

# https://docs.saltstack.com/en/latest/ref/modules/all/salt.modules.ssh.html
# http://grokbase.com/t/gg/salt-users/163j3x5v2m/module-run-with-ssh-set-known-host
# http://blog.siphos.be/2016/03/using-salt-ssh-with-agent-forwarding/

# https://docs.saltstack.com/en/latest/ref/modules/all/salt.modules.cp.html#salt.modules.cp.push

gpadmin:
  ssh_auth.present:
    - user: gpadmin
    - source: salt://gp/id_rsa.pub
    - config: /%h/.ssh/authorized_keys

gpadmin_ed25519:
  ssh_auth.present:
    - user: gpadmin
    - source: salt://gp/id_ed25519.pub
    - config: /%h/.ssh/authorized_keys

#      - salt://gp/id_ed25519.pub
#      - salt://gp/root.id_ed25519.pub
#      - salt://gp/sdw1.id_ed25519.pub
#      - salt://gp/sdw2.id_ed25519.pub

root:
  ssh_auth.present:
    - user: root
    - source: salt://gp/root.id_rsa.pub
    - config: /%h/.ssh/authorized_keys

root_ed25519:
  ssh_auth.present:
    - user: root
    - source: salt://gp/id_ed25519.pub
    - config: /%h/.ssh/authorized_keys

#      - salt://gp/root.id_ed25519.pub
#      - salt://gp/sdw1.id_ed25519.pub
#      - salt://gp/sdw2.id_ed25519.pub

ssh_keygen_rsa:
  cmd.run:
      - name: rm -rf /home/gpadmin/.ssh/id_rsa*; ssh-keygen -t rsa -f /home/gpadmin/.ssh/id_rsa -q -N ""
      - runas: gpadmin

ssh_keygen_ed25519:
  cmd.run:
      - name: rm -rf /home/gpadmin/.ssh/id_ed25519*; ssh-keygen -t ed25519 -f /home/gpadmin/.ssh/id_ed25519 -q -N ""
      - runas: gpadmin

sdw1_ed25519:
  ssh_auth.present:
    - user: gpadmin
    - source: salt://gp/sdw1.id_ed25519.pub
    - config: /%h/.ssh/authorized_keys

sdw2_ed25519:
  ssh_auth.present:
    - user: gpadmin
    - source: salt://gp/sdw2.id_ed25519.pub
    - config: /%h/.ssh/authorized_keys

root_keys_rsa:
  ssh_auth.present:
    - user: root
    - source: salt://gp/id_rsa.keys
    - config: /%h/.ssh/authorized_keys

root_keys_ed25519:
  ssh_auth.present:
    - user: root
    - source: salt://gp/id_ed25519.keys
    - config: /%h/.ssh/authorized_keys

gpadmin_keys_rsa:
  ssh_auth.present:
    - user: gpadmin
    - source: salt://gp/id_rsa.keys
    - config: /%h/.ssh/authorized_keys

gpadmin_keys_ed25519:
  ssh_auth.present:
    - user: gpadmin
    - source: salt://gp/id_ed25519.keys
    - config: /%h/.ssh/authorized_keys
