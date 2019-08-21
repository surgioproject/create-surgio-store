{% macro main(rule) %}
# Hulu
USER-AGENT,Hulu*,{{ rule }}
DOMAIN-SUFFIX,happyon.jp,{{ rule }}
DOMAIN-KEYWORD,hulu,{{ rule }}
DOMAIN-KEYWORD,huluim,{{ rule }}
DOMAIN-KEYWORD,hulustream,{{ rule }}
{% endmacro %}
