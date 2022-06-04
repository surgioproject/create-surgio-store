{% filter quantumultx %}
{{ remoteSnippets.apple.main('PROXY', 'Apple', 'Apple CDN', 'DIRECT', 'PROXY') }}
{{ remoteSnippets.hbo.main('PROXY') }}
{{ remoteSnippets.netflix.main('Netflix') }}
{{ remoteSnippets.telegram.main('PROXY') }}
{{ snippet("snippet/youtube_rules.tpl").main('YouTube') }}
{{ snippet("snippet/blocked_rules.tpl").main('PROXY') }}
{{ snippet("snippet/direct_rules.tpl").main('DIRECT') }}
{{ remoteSnippets.overseaTlds.main('PROXY') }}
{% endfilter %}

# LAN, debugging rules should place above this line
DOMAIN-SUFFIX,local,DIRECT
IP-CIDR,10.0.0.0/8,DIRECT
IP-CIDR,100.64.0.0/10,DIRECT
IP-CIDR,127.0.0.0/8,DIRECT
IP-CIDR,172.16.0.0/12,DIRECT
IP-CIDR,192.168.0.0/16,DIRECT

GEOIP,CN,DIRECT
FINAL,PROXY
