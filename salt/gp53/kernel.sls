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
      - kernel.sem = 250 512000 100 2048
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

hosts:
  file.append:
    - name: /etc/hosts
    - text:
      - 10.160.2.49 mdw
      - 10.160.2.50 sdw1
      - 10.160.2.51 sdw2
      - 10.160.2.52 sdw3 

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

hugepage-never:
  cmd.run:
    - runas: root
    - name: grubby --update-kernel=ALL --args="transparent_hugepage=never"

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
  
