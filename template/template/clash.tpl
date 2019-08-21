# {{ downloadUrl }}

{% import './snippet/proxy_rules.tpl' as proxy_rules %}
{% import './snippet/direct_rules.tpl' as direct_rules %}
{% import './snippet/apple_rules.tpl' as apple_rules %}
{% import './snippet/netflix_rules.tpl' as netflix_rules %}
{% import './snippet/youtube_rules.tpl' as youtube_rules %}
{% import './snippet/us_rules.tpl' as us_rules %}
{% import './snippet/telegram_rules.tpl' as telegram_rules %}
{% import './snippet/alibaba_rules.tpl' as alibaba_rules %}
{% import './snippet/blocked_rules.tpl' as blocked_rules %}

external-controller: 127.0.0.1:7892
port: 7890
socks-port: 7891

{{ clashProxyConfig | yaml }}

Rule:
{{ alibaba_rules.main('DIRECT') | patchYamlArray }}
{{ apple_rules.main('🚀 Proxy', '🍎 Apple', '🍎 Apple CDN', 'DIRECT', 'US') | patchYamlArray }}
{{ netflix_rules.main('🎬 Netflix') | patchYamlArray }}
{{ youtube_rules.main('🚀 Proxy') | patchYamlArray }}
{{ us_rules.main('US') | patchYamlArray }}
{{ telegram_rules.main('🚀 Proxy') | patchYamlArray }}
{{ blocked_rules.main('🚀 Proxy') | patchYamlArray }}
{{ proxy_rules.main('🚀 Proxy') | patchYamlArray }}
{{ direct_rules.main('DIRECT') | patchYamlArray }}

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
