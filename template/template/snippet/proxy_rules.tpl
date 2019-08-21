{% macro main(rule) %}
# 可能被屏蔽
DOMAIN-KEYWORD,evernote,{{ rule }}

# Bloombeg
USER-AGENT,Bloomberg*,{{ rule }}

# Taiwan
DOMAIN-SUFFIX,tw,{{ rule }}
{% endmacro %}
