{% macro main(rule) %}
# TVB Viu NOWe
USER-AGENT,mytv*,{{ rule }}
DOMAIN-SUFFIX,mytvsuper.com,{{ rule }}
DOMAIN-KEYWORD,nowtv100,{{ rule }}
DOMAIN-KEYWORD,rthklive,{{ rule }}
DOMAIN-SUFFIX,tvb.com,{{ rule }}
USER-AGENT,OTT_iPhone*,{{ rule }}
USER-AGENT,Viu*,{{ rule }}
USER-AGENT,*nowe*,{{ rule }}
USER-AGENT,*PCCW*,{{ rule }}
USER-AGENT,*pccw*,{{ rule }}
DOMAIN-SUFFIX,bcbolthboa-a.akamaihd.net,{{ rule }}
DOMAIN-SUFFIX,boltdns.net,{{ rule }}
DOMAIN-SUFFIX,now.com,{{ rule }},force-remote-dns
DOMAIN-SUFFIX,nowe.com,{{ rule }},force-remote-dns
DOMAIN-SUFFIX,nowestatic.com,{{ rule }}
DOMAIN-SUFFIX,youboranqs01.com,{{ rule }}
DOMAIN-SUFFIX,emarsys.net,{{ rule }}
DOMAIN-SUFFIX,api.segment.io,{{ rule }}
DOMAIN-SUFFIX,segment.com,{{ rule }}
DOMAIN-SUFFIX,nqs.nice264.com,{{ rule }}
DOMAIN-SUFFIX,viu.com,{{ rule }}
DOMAIN-SUFFIX,viu.tv,{{ rule }}
{% endmacro %}
