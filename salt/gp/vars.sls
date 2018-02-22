{% set http_proxy = pillar['vars']['http_proxy'] %}
{% set https_proxy = pillar['vars']['https_proxy'] %}

http_proxy:
   environ.setenv:
     - name: http_proxy
     {% if http_proxy %}
     - value: {{ http_proxy }}
     {% else %}
     - value: 
       http_proxy: False
     - false_unsets: True
     {% endif %}

https_proxy:
   environ.setenv:
     - name: https_proxy
     {% if https_proxy %}
     - value: {{ https_proxy }}
     {% else %}
     - value:
       https_proxy: False
     - false_unsets: True
     {% endif %}
