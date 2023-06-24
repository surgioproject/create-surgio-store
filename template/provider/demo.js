'use strict'

module.exports = {
  type: 'custom',
  nodeList: [
    {
      nodeName: '🇺🇸US',
      type: 'shadowsocks',
      hostname: 'us.example.com',
      port: 10000,
      method: 'chacha20-ietf-poly1305',
      password: 'password',
      obfs: 'tls',
      obfsHost: 'gateway-carry.icloud.com',
      udpRelay: true,
    },
    {
      nodeName: '🇭🇰HK(Netflix)',
      type: 'shadowsocks',
      hostname: 'hk.example.com',
      port: 10000,
      method: 'chacha20-ietf-poly1305',
      password: 'password',
      udpRelay: true,
    },
  ],
}
