'use strict';

module.exports = {
  type: 'custom',
  nodeList: [
    {
      nodeName: '🇺🇸US',
      type: 'shadowsocks',
      hostname: 'us.example.com',
      port: '10000',
      method: 'chacha20-ietf-poly1305',
      password: 'password',
      obfs: 'tls',
      'obfs-host': 'gateway-carry.icloud.com',
      'udp-relay': true,
    },
    {
      nodeName: '🇭🇰HK(Netflix)',
      type: 'shadowsocks',
      hostname: 'hk.example.com',
      port: '10000',
      method: 'chacha20-ietf-poly1305',
      password: 'password',
      'udp-relay': true,
    },
  ],
};
