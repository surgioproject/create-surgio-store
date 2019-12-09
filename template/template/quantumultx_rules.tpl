{% import './snippet/blocked_rules.tpl' as blocked_rules %}
{% import './snippet/direct_rules.tpl' as direct_rules %}
{% import './snippet/apple_rules.tpl' as apple_rules %}
{% import './snippet/nowe_rules.tpl' as nowe_rules %}
{% import './snippet/youtube_rules.tpl' as youtube_rules %}
{% import './snippet/us_rules.tpl' as us_rules %}

{{ apple_rules.main('PROXY', 'Apple', 'Apple CDN', 'DIRECT', 'PROXY') | quantumultx }}
{{ remoteSnippets.hbo.main('PROXY') | quantumultx }}
{{ us_rules.main('🇺🇸 Auto US') | quantumultx }}
{{ remoteSnippets.netflix.main('Netflix') | quantumultx }}
{{ remoteSnippets.hulu.main('PROXY') | quantumultx }}
{{ remoteSnippets.telegram.main('PROXY') | quantumultx }}
{{ youtube_rules.main('YouTube') | quantumultx }}
{{ remoteSnippets.paypal.main('Paypal') | quantumultx }}
{{ nowe_rules.main('PROXY') | quantumultx }}
{{ blocked_rules.main('PROXY') | quantumultx }}
{{ direct_rules.main('DIRECT') | quantumultx }}

# LAN, debugging rules should place above this line
DOMAIN-SUFFIX,local,DIRECT
IP-CIDR,10.0.0.0/8,DIRECT
IP-CIDR,100.64.0.0/10,DIRECT
IP-CIDR,127.0.0.0/8,DIRECT
IP-CIDR,172.16.0.0/12,DIRECT
IP-CIDR,192.168.0.0/16,DIRECT

GEOIP,CN,DIRECT
FINAL,PROXY
