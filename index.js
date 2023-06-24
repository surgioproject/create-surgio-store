#!/usr/bin/env node

'use strict'

const currentNodeVersion = process.versions.node
const semver = currentNodeVersion.split('.')
const major = semver[0]

if (major < 18) {
  console.error(
    '你当前运行的 Node 版本 ' +
      currentNodeVersion +
      '.\n' +
      'Surgio 需要 Node 18 以上版本。 \n' +
      '请更新你的 Node 版本。'
  )
  process.exit(1)
}

require('./createSurgioStore')
