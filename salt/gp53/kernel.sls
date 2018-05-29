#{ % set hosts_records = salt['cmd.run']("salt -E '[m,s]dw*' network.ip_addrs --out txt | sort | awk {'print substr($2, 4, length($2)-5)  substr($1, 1, length($1)-1)'}") %}
#{ % set hosts_records = salt['cmd.run']("salt -E '[m,s]dw*' network.ip_addrs --out txt") %}
#{ % set hosts_records = "test" %}

limits:
  file.append:
    - name: /etc/security/limits.conf
    - text:
      - "* soft nofile 65536"
      - "* hard nofile 65536"
      - "* soft nproc 131072"
      - "* hard nproc 131072"

# on redhat we might need to change it in sysctl.conf as well !!!

kernel.hostname:
  sysctl.present:
    - value: {{ grains['id'] }}
    - config: /etc/sysctl.conf

sysctl:
  file.append:
    - name: /etc/sysctl.conf
    - text:
      - kernel.shmmax = 500000000
      - kernel.shmmni = 4096
      - kernel.shmall = 4000000000
      - ## kernel.sem = {SEMMSL, SEMMNS, SEMOPM, SEMMNI}
      - # kernel.sem = 250 512000 100 2048
      - kernel.sem = 32000 1024000000 500 32000
      - kernel.sysrq = 1
      - kernel.core_uses_pid = 1
      - kernel.msgmnb = 65536
      - kernel.msgmax = 65536
      - kernel.msgmni = 2048
      - net.ipv4.tcp_syncookies = 1
      - net.ipv4.ip_forward = 0
      - net.ipv4.conf.default.accept_source_route = 0
      - net.ipv4.tcp_tw_recycle = 1
      - net.ipv4.tcp_max_syn_backlog = 4096
      - net.ipv4.conf.all.arp_filter = 1
      - net.ipv4.ip_local_port_range = 1025 65535
      - net.core.netdev_max_backlog = 10000
      - net.core.rmem_max = 2097152
      - net.core.wmem_max = 2097152
      - vm.overcommit_memory = 2

# https://gableroux.com/tips/2016/02/18/keep-saltstack-colored-output/
# http://grokbase.com/t/gg/salt-users/1495aa0601/set-variable-after-state-is-executed

hosts_for_add:
  cmd.run:
    - runas: root
    - name: salt -E '[m,s]dw*' network.ip_addrs --out txt | sort | awk {'print substr($2, 4, length($2)-5) " " substr($1, 1, length($1)-1)'} > /etc/hosts.adding

hosts:
  file.append:
    - require:
      - hosts_for_add
    - name: /etc/hosts
    - source: /etc/hosts.adding

    #- contents: { { hosts_records }}
    #- text: |
    #   - { { hosts_records }}
    #  - 10.160.2.49 mdw
    #  - 10.160.2.50 sdw1
    #  - 10.160.2.51 sdw2
    #  - 10.160.2.52 sdw3
    # salt -E '[m,s]dw*' network.ip_addrs --out txt | sort | awk {'print substr($2, 4, length($2)-5) " " substr($1, 1, length($1)-1)'}

correct-hostname:
  cmd.run:
    - runas: root
    - name: hostnamectl set-hostname {{ grains['id'] }}

disk-read-ahead:
  cmd.run:
    - runas: root
    - name: /usr/sbin/blockdev --setra 16384 /dev/sda

scheduler-deadline:
  cmd.run:
    - runas: root
    - name: grubby --update-kernel=ALL --args="elevator=deadline"
    - unless: awk -F/ '$2 == "docker"' /proc/self/cgroup | read

hugepage-never:
  cmd.run:
    - runas: root
    - name: grubby --update-kernel=ALL --args="transparent_hugepage=never"
    - unless: awk -F/ '$2 == "docker"' /proc/self/cgroup | read

/etc/rc.d/rc.local:
  file.append:
    - name: /etc/rc.d/rc.local
    - text:
      - hostnamectl set-hostname {{ grains['id'] }}
      - /usr/sbin/blockdev --setra 16384 /dev/sda

chmod +x /etc/rc.d/rc.local:
  cmd.run

/etc/systemd/logind.conf:
  file.replace:
    - pattern: '#?RemoveIPC=.*'
    - repl: 'RemoveIPC=No'
    - show_changes: True
    - append_if_not_found: True

#system:
#  network.system:
#    - enabled: True
#    - hostname: {{ grains['id'] }}
#    - apply_hostname: True
