{% macro main(rule) %}
# 可能被屏蔽
DOMAIN-KEYWORD,evernote,{{ rule }}

# Bloombeg
USER-AGENT,Bloomberg*,{{ rule }}

# Taiwan
DOMAIN-SUFFIX,tw,{{ rule }}

DOMAIN-KEYWORD,bitly,{{ rule }}
DOMAIN-KEYWORD,blogspot,{{ rule }}
DOMAIN-KEYWORD,dropbox,{{ rule }}
DOMAIN-KEYWORD,facebook,{{ rule }}
DOMAIN-KEYWORD,gmail,{{ rule }}
DOMAIN-KEYWORD,google,{{ rule }}
DOMAIN-KEYWORD,instagram,{{ rule }}
DOMAIN-KEYWORD,oculus,{{ rule }}
DOMAIN-KEYWORD,twitter,{{ rule }}
DOMAIN-KEYWORD,whatsapp,{{ rule }}
DOMAIN-KEYWORD,youtube,{{ rule }}

DOMAIN-SUFFIX,fb.com,{{ rule }}
DOMAIN-SUFFIX,fb.me,{{ rule }}
DOMAIN-SUFFIX,fbcdn.net,{{ rule }}
DOMAIN-SUFFIX,gstatic.com,{{ rule }}
DOMAIN-SUFFIX,scdn.co,{{ rule }}
DOMAIN-SUFFIX,t.co,{{ rule }}
DOMAIN-SUFFIX,telegra.ph,{{ rule }}
DOMAIN-SUFFIX,twimg.co,{{ rule }}
DOMAIN-SUFFIX,twimg.com,{{ rule }}
DOMAIN-SUFFIX,twitpic.com,{{ rule }}
DOMAIN-SUFFIX,youtu.be,{{ rule }}
DOMAIN-SUFFIX,ytimg.com,{{ rule }}
{% endmacro %}
