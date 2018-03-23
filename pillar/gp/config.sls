{#- set the version you want to compile #}
{%- set gpdb_version = '5.5.0' %}

{#- set username who will build gpdb, root is not recommended #}
{%- set bld_user = 'bi' %}

{%- set http_proxy = 'socks5://localhost:3128' %}
{%- set https_proxy = 'socks5://localhost:3128' %}

{%- set http_proxy = 'http://localhost:3128' %}
{%- set https_proxy = 'https://localhost:3128' %}

{%- set http_proxy = False %}
{%- set https_proxy = False %}

vars:
  http_proxy: '{{ http_proxy }}'
  https_proxy: '{{ https_proxy }}'
  gpdb_version: '{{ gpdb_version }}'
  bld_user: '{{ bld_user }}'
