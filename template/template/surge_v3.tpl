#!MANAGED-CONFIG {{ downloadUrl }} interval=43200 strict=false

{% import './snippet/direct_rules.tpl' as direct_rules %}
{% import './snippet/apple_rules.tpl' as apple_rules %}
{% import './snippet/netflix_rules.tpl' as netflix_rules %}
{% import './snippet/youtube_rules.tpl' as youtube_rules %}
{% import './snippet/us_rules.tpl' as us_rules %}
{% import './snippet/telegram_rules.tpl' as telegram_rules %}
{% import './snippet/alibaba_rules.tpl' as alibaba_rules %}
{% import './snippet/blocked_rules.tpl' as blocked_rules %}

[General]
# 日志等级: warning, notify, info, verbose (默认值: notify)
loglevel = notify
# 跳过某个域名或者 IP 段，这些目标主机将不会由 Surge Proxy 处理。(在 macOS
# 版本中，如果启用了 Set as System Proxy,  那么这些值会被写入到系统网络代理
# 设置中.)
skip-proxy = 127.0.0.1, 192.168.0.0/16, 10.0.0.0/8, 172.16.0.0/12, 100.64.0.0/10, 100.84.0.0/10, localhost, *.local
# 强制使用特定的 DNS 服务器
dns-server = system, 119.29.29.29, 223.5.5.5, 1.1.1.1

# 以下参数仅供 iOS 版本使用
# 将系统相关请求交给 Surge TUN 处理，并自动追加规则
# "IP-CIDR,17.0.0.0/8,DIRECT,no-resolve"
bypass-system = true
# 将特定 IP 段跳过 Surge TUN，详见 Manual
bypass-tun = 192.168.0.0/16, 10.0.0.0/8, 172.16.0.0/12
# 是否截取并保存 HTTP 流量 (启用后将对性能有较大影响) (默认值: false)
replica = false
# 是否启动完整的 IPv6 支持 (默认值: false)
ipv6 = false

# 以下参数仅供 macOS 版本使用（多端口监听仅 Surge 3 支持）
http-listen = 0.0.0.0:6152
socks5-listen = 0.0.0.0:6153

# 测速地址
internet-test-url = http://www.qualcomm.cn/generate_204
proxy-test-url = http://www.qualcomm.cn/generate_204

# 其它
# external-controller-access = password@0.0.0.0:6170
show-primary-interface-changed-notification = true
proxy-settings-interface = Primary Interface (Auto)
menu-bar-show-speed = false
allow-wifi-access = true
hide-crashlytics-request = true

[Proxy]
{{ getSurgeNodes(nodeList) }}

[Proxy Group]
🚀 Proxy = select, {{ getNodeNames(nodeList) }}
🎬 Netflix = select, {{ getNodeNames(nodeList, netflixFilter) }}
📺 YouTube = select, 🚀 Proxy, US, HK
🍎 Apple = select, DIRECT, 🚀 Proxy, US, HK
🍎 Apple CDN = select, DIRECT, 🍎 Apple
US = url-test, {{ getNodeNames(nodeList, usFilter) }}, url = http://www.qualcomm.cn/generate_204, interval = 1200
HK = url-test, {{ getNodeNames(nodeList, hkFilter) }}, url = http://www.qualcomm.cn/generate_204, interval = 1200

[Rule]
{{ apple_rules.main('🚀 Proxy', '🍎 Apple', '🍎 Apple CDN', 'DIRECT', 'US') }}

{{ netflix_rules.main('🎬 Netflix') }}

{{ youtube_rules.main('📺 YouTube') }}

{{ us_rules.main('US') }}

{{ telegram_rules.main('🚀 Proxy') }}

{{ alibaba_rules.main('DIRECT') }}

{{ blocked_rules.main('🚀 Proxy') }}

{{ direct_rules.main('DIRECT') }}

# Rulesets
RULE-SET,SYSTEM,DIRECT

# LAN
RULE-SET,LAN,DIRECT

# GeoIP CN
GEOIP,CN,DIRECT

# Final
FINAL,🚀 Proxy,dns-failed

[URL Rewrite]
^https?://(www.)?g.cn https://www.google.com 302
^https?://(www.)?google.cn https://www.google.com 302
