{% macro main(rule) %}
# Netflix
DOMAIN-SUFFIX,netflix.com,{{ rule }}
DOMAIN-SUFFIX,netflix.net,{{ rule }}
DOMAIN-SUFFIX,nflxso.net,{{ rule }}
DOMAIN-SUFFIX,nflxext.com,{{ rule }}
DOMAIN-SUFFIX,nflximg.com,{{ rule }}
DOMAIN-SUFFIX,nflximg.net,{{ rule }}
DOMAIN-SUFFIX,nflxvideo.net,{{ rule }}
IP-CIDR,23.246.0.0/12,{{ rule }},no-resolve
IP-CIDR,37.77.0.0/12,{{ rule }},no-resolve
IP-CIDR,45.57.0.0/12,{{ rule }},no-resolve
IP-CIDR,64.120.128.0/17,{{ rule }},no-resolve
IP-CIDR,66.197.128.0/17,{{ rule }},no-resolve
IP-CIDR,108.175.0.0/12,{{ rule }},no-resolve
IP-CIDR,185.2.0.0/12,{{ rule }},no-resolve
IP-CIDR,185.9.188.0/22,{{ rule }},no-resolve
IP-CIDR,192.173.64.0/18,{{ rule }},no-resolve
IP-CIDR,198.38.0.0/12,{{ rule }},no-resolve
IP-CIDR,198.45.0.0/12,{{ rule }},no-resolve
{% endmacro %}
