'use strict';

const test = require('ava');
const coffee = require('coffee');
const path = require('path');
const fs = require('fs-extra');

const fixtures = path.join(__dirname, 'fixtures');
const testStore = path.join(fixtures, 'test-store');
const bin = require.resolve('../index.js');

test.before('cleanup', async () => {
  if (await fs.exists(testStore)) {
    await fs.remove(testStore);
  }
});

test('will work', async t => {
  await coffee.fork(bin, ['test-store'], {
    cwd: fixtures,
  })
    .waitForPrompt()
    .write('Y\n')
    .debug()
    .expect('code', 0)
    .end();

  await coffee.spawn('npx', ['surgio', 'generate'], {
    cwd: testStore,
  })
    .expect('code', 0)
    .debug()
    .end();

  t.pass();
});
