#!/usr/bin/env node

'use strict'

const currentNodeVersion = process.versions.node
const minimumNodeVersion = [22, 22, 2]

function isSupportedNodeVersion(version) {
  const parts = version.split('.').map(Number)
  for (let i = 0; i < minimumNodeVersion.length; i++) {
    if (parts[i] !== minimumNodeVersion[i]) {
      return parts[i] > minimumNodeVersion[i]
    }
  }
  return true
}

if (!isSupportedNodeVersion(currentNodeVersion)) {
  console.error(
    '你当前运行的 Node 版本 ' +
      currentNodeVersion +
      '.\n' +
      'Surgio 需要 Node 22.22.2 以上版本。 \n' +
      '请更新你的 Node 版本。'
  )
  process.exit(1)
}

require('./createSurgioStore')
