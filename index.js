#!/usr/bin/env node

'use strict';

var currentNodeVersion = process.versions.node;
var semver = currentNodeVersion.split('.');
var major = semver[0];

if (major < 10) {
  console.error(
    '你当前运行的 Node 版本 ' +
      currentNodeVersion +
      '.\n' +
      'Surgio 需要 Node 10 以上版本。 \n' +
      '请更新你的 Node 版本。'
  );
  process.exit(1);
}

require('./createSurgioStore');
