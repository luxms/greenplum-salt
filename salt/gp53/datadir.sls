{% set host = grains['id'] %}

{% if host == 'mdw' %}

recursive_perms:
  file.directory:
    - name: /data/master/
    - user: root
    - group: root
    - dir_mode: 755
    - file_mode: 644
    - makedirs: True
    - recurse:
      - user
      - group
      - mode

root_perms:
  file.directory:
    - name: /data/master/
    - user: gpadmin
    - group: gpadmin
    - dir_mode: 700
    - require:
      - file: recursive_perms

{% else %}

recursive_perms:
  file.directory:
    #- name: /data1/primary/
    - name: /data/primary
    - user: root
    - group: root
    - dir_mode: 755
    - file_mode: 644
    - makedirs: True
    - recurse:
      - user
      - group
      - mode

root_perms:
  file.directory:
    #- name: /data1/primary/
    - name: /data/primary/
    - user: gpadmin
    - group: gpadmin
    - dir_mode: 700
    - require:
      - file: recursive_perms

recursive_perms2:
  file.directory:
    #- name: /data2/primary/
    - name: /data/primary
    - user: root
    - group: root
    - dir_mode: 755
    - file_mode: 644
    - makedirs: True
    - recurse:
      - user
      - group
      - mode

root_perms2:
  file.directory:
    #- name: /data2/primary/
    - name: /data/primary/
    - user: gpadmin
    - group: gpadmin
    - dir_mode: 700
    - require:
      - file: recursive_perms2

mirror_perms:
  file.directory:
    #- name: /data1/mirror
    - name: /data/mirror
    - user: gpadmin
    - group: gpadmin
    - dir_mode: 700
    - makedirs: True
    - require:
      - file: recursive_perms

{% endif %}
