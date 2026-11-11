'use strict';

const test = require('ava');
const coffee = require('coffee');
const path = require('path');
const fs = require('fs-extra');

const fixtures = path.join(__dirname, 'fixtures');
const testStore = path.join(fixtures, 'test-store');
const bin = require.resolve('../index.js');

const runInStore = (command, args) =>
  coffee.spawn('npx', [command, ...args], { cwd: testStore })
    .debug()
    .expect('code', 0)
    .end();

test.before('create store', async () => {
  await fs.remove(testStore);
  await coffee.fork(bin, ['test-store'], { cwd: fixtures })
    .debug()
    .expect('code', 0)
    .end();
});

test.serial('creates a v4 project', async t => {
  const pkg = await fs.readJson(path.join(testStore, 'package.json'));
  const project = await fs.readFile(path.join(testStore, 'surgio.project.ts'), 'utf8');

  t.is(pkg.type, 'module');
  t.is(pkg.engines.node, '>=22.22.2');
  t.regex(pkg.dependencies.surgio, /^4\./);
  t.regex(pkg.dependencies['@surgio/gateway'], /^3\./);
  t.true(await fs.pathExists(path.join(testStore, 'server.ts')));
  t.false(await fs.pathExists(path.join(testStore, 'surgio.conf.js')));
  t.false(await fs.pathExists(path.join(testStore, 'provider')));
  t.notRegex(project, /\{\{|\}\}/);
  t.regex(project, /accessToken: '[\w-]{32}'/);
});

test.serial('generated project passes checks', async t => {
  await runInStore('surgio', ['generate']);
  await runInStore('tsc', ['--noEmit']);
  await runInStore('eslint', ['.']);
  await runInStore('prettier', ['--check', '.']);

  t.true(await fs.pathExists(path.join(testStore, 'dist/SurgeV3.conf')));
  t.true(await fs.pathExists(path.join(testStore, 'dist/sing-box.json')));
});
