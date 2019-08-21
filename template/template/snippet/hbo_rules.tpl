{% macro main(rule) %}
# HBO
USER-AGENT,HBO%20NOW*,{{ rule }}
DOMAIN-SUFFIX,hbo.com,{{ rule }}
DOMAIN-SUFFIX,hbogo.com,{{ rule }}
USER-AGENT,HBO%20GO*,{{ rule }}
USER-AGENT,HBOAsia*,{{ rule }}
DOMAIN-SUFFIX,execute-api.ap-southeast-1.amazonaws.com,{{ rule }}
DOMAIN-SUFFIX,hboasia.com,{{ rule }}
DOMAIN-SUFFIX,hbogoasia.hk,{{ rule }}
{% endmacro %}
