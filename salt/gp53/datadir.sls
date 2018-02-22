
{% set host = grains['id'] %}

{% if host == 'mdw' %}
/data/master:
  file.directory:
    - user: gpadmin
    - group: gpadmin
    - dir_mode: 700
{% else %}
/data/primary:
  file.directory:
    - user: gpadmin
    - group: gpadmin
    - dir_mode: 700

/data/mirror:
  file.directory:
    - user: gpadmin
    - group: gpadmin
    - dir_mode: 700
{% endif %}
