# URL: {{ downloadUrl }}
#
# 使用方法：
#
# 1. 点击右上角保存
# 2. 到「订阅」界面从上到下逐个更新（替换）
# 3. 开始使用
#

[SERVER]

[SOURCE]
Surgio(左滑选择更新), server, {{ getDownloadUrl('Shadowsocks_subscribe.conf') }}, false, true, false, Surgio
分流规则(左滑选择替换), filter, {{ getDownloadUrl('Quantumult_rules.conf') }}, true

[BACKUP-SERVER]

[POLICY]

[DNS]
system, 119.29.29.29, 223.5.5.5

[REWRITE]

[URL-REJECTION]

[TCP]

[GLOBAL]

[HOST]

[STATE]
STATE,AUTO

[MITM]

