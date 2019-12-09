# {{ downloadUrl }}

{% import './snippet/direct_rules.tpl' as direct_rules %}
{% import './snippet/apple_rules.tpl' as apple_rules %}
{% import './snippet/youtube_rules.tpl' as youtube_rules %}
{% import './snippet/us_rules.tpl' as us_rules %}
{% import './snippet/blocked_rules.tpl' as blocked_rules %}

external-controller: 127.0.0.1:7892
port: 7890
socks-port: 7891

{{ clashProxyConfig | yaml }}

Rule:
{{ apple_rules.main('🚀 Proxy', '🍎 Apple', '🍎 Apple CDN', 'DIRECT', 'US') | clash }}
{{ remoteSnippets.netflix.main('🎬 Netflix') | clash }}
{{ remoteSnippets.hbo.main('🚀 Proxy') | clash }}
{{ remoteSnippets.hulu.main('🚀 Proxy') | clash }}
{{ youtube_rules.main('🚀 Proxy') | clash }}
{{ us_rules.main('US') | clash }}
{{ remoteSnippets.telegram.main('🚀 Proxy') | clash }}
{{ blocked_rules.main('🚀 Proxy') | clash }}
{{ direct_rules.main('DIRECT') | clash }}

# LAN
- DOMAIN-SUFFIX,local,DIRECT
- IP-CIDR,127.0.0.0/8,DIRECT
- IP-CIDR,172.16.0.0/12,DIRECT
- IP-CIDR,192.168.0.0/16,DIRECT
- IP-CIDR,10.0.0.0/8,DIRECT
- IP-CIDR,17.0.0.0/8,DIRECT
- IP-CIDR,100.64.0.0/10,DIRECT

# Final
- GEOIP,CN,DIRECT
- MATCH,🚀 Proxy
