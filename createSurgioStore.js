'use strict'

const chalk = require('chalk')
const commander = require('commander')
const path = require('path')
const fs = require('fs-extra')
const os = require('os')
const spawn = require('cross-spawn')
const inquirer = require('inquirer')
const Handlebars = require('handlebars')
const Promise = require('bluebird')

const { join, resolve } = path
const packageJson = require('./package.json')
const errorLogFilePatterns = [
  'npm-debug.log',
  'yarn-error.log',
  'yarn-debug.log',
]
let projectName

const program = new commander.Command(packageJson.name)
  .version(packageJson.version)
  .arguments('<project-directory>')
  .usage(`${chalk.green('<project-directory>')} [options]`)
  .action((name) => {
    projectName = name
  })
  .option('--use-cnpm', '使用国内镜像安装依赖')
  .option('--verbose', '打印调试日志')
  .allowUnknownOption()
  .parse(process.argv)

if (typeof projectName === 'undefined') {
  console.error('请指定一个目录保存项目：')
  console.log(
    `  ${chalk.cyan(program.name())} ${chalk.green('<project-directory>')}`
  )
  console.log()
  console.log('例如：')
  console.log(
    `  ${chalk.cyan(program.name())} ${chalk.green('my-surge-rules')}`
  )
  console.log()
  console.log(`运行 ${chalk.cyan(`${program.name()} --help`)} 查看详细指引`)
  process.exit(1)
}

createFn(projectName, program.verbose, program.useCnpm).catch((error) => {
  console.error('发生了错误')
  console.log()
  console.error(error)
  process.exit(1)
})

async function createFn(name, verbose, useCnpm) {
  const root = resolve(name)
  const appName = path.basename(root)

  fs.ensureDirSync(name)
  if (!isSafeToCreateProjectIn(root, name)) {
    process.exit(1)
  }

  console.log(`创建目录中，地址：${chalk.green(root)}.`)
  console.log()

  const packageJson = {
    name: appName,
    version: '0.1.0',
    private: true,
    scripts: {
      update: 'surgio generate',
    },
  }
  const allDependencies = ['surgio']
  const useAliyunOss = process.stdout.isTTY
    ? await inquirer.prompt({
        type: 'confirm',
        name: 'useAliyunOss',
        message: '是否配置将配置文件上传至阿里云 OSS？（默认：是）',
        default: true,
      })
    : true
  const allowAnalytics = process.stdout.isTTY
    ? await inquirer.prompt({
        type: 'confirm',
        name: 'allowAnalytics',
        message: '是否允许我收集非常有限的报错信息用于排查问题？（默认：是）',
        default: true,
      })
    : true

  if (useAliyunOss) {
    packageJson.scripts.update = 'surgio generate && surgio upload'
  }
  if (allowAnalytics) {
    console.log('若对信息收集感到不适，可以稍后在 surgio.conf.js 中关闭')
  }

  // VSCode settings
  await fs.mkdirp(join(root, '.vscode'))
  await fs.writeFile(
    join(root, '.vscode/extensions.json'),
    JSON.stringify(
      {
        extensions: ['dbaeumer.vscode-eslint', 'ronnidc.nunjucks'],
      },
      null,
      2
    ),
    {
      encoding: 'utf8',
    }
  )
  await fs.writeFile(
    join(root, '.vscode/settings.json'),
    JSON.stringify(
      {
        'files.associations': {
          '*.tpl': 'nunjucks',
        },
      },
      null,
      2
    ),
    {
      encoding: 'utf8',
    }
  )

  await fs.writeFile(
    join(root, 'package.json'),
    JSON.stringify(packageJson, null, 2) + os.EOL
  )

  if (useCnpm) {
    await fs.writeFile(
      join(root, '.npmrc'),
      `registry=https://registry.npmmirror.com/` + os.EOL
    )
    // eslint-disable-next-line require-atomic-updates
    process.env.FSEVENTS_BINARY_HOST_MIRROR =
      'https://npmmirror.com/mirrors/fsevents'
  }

  process.chdir(root)

  if (!checkThatNpmCanReadCwd()) {
    process.exit(1)
  }

  console.log('正在安装依赖，可能需要一点时间。安装过程中请不要关闭')

  await install(root, allDependencies, verbose, useCnpm).catch((reason) => {
    console.log()
    console.log('终止安装')
    if (reason.command) {
      console.log(`  ${chalk.cyan(reason.command)} 命令运行失败`)
    } else {
      console.log(chalk.red('发生未知错误'))
      console.log(reason)
    }
    console.log()

    // On 'exit' we will delete these files from target directory.
    const knownGeneratedFiles = [
      'package.json',
      'package-lock.json',
      'node_modules',
    ]
    const currentFiles = fs.readdirSync(join(root))
    currentFiles.forEach((file) => {
      knownGeneratedFiles.forEach((fileToMatch) => {
        // This removes all knownGeneratedFiles.
        if (file === fileToMatch) {
          console.log(`准备删除已生成的文件... ${chalk.cyan(file)}`)
          fs.removeSync(join(root, file))
        }
      })
    })
    const remainingFiles = fs.readdirSync(join(root))
    if (!remainingFiles.length) {
      // Delete target folder if empty
      console.log(
        `删除位于 ${chalk.cyan(resolve(root, '..'))} 的 ${chalk.cyan(
          `${appName}/`
        )}`
      )
      process.chdir(resolve(root, '..'))
      fs.removeSync(join(root))
    }
    console.log('已完成')
    process.exit(1)
  })

  await renderTemplates(root, useAliyunOss, allowAnalytics)

  await copyFolders(root)

  console.log('大功告成！')
  console.log()
  console.log('你可以在目录中执行命令：')
  console.log()
  console.log(`  ${chalk.cyan('npm run update')}`)
  console.log(`    更新所有配置文件，上传至阿里云 OSS（如果已开启该功能）`)
  console.log()
  console.log(`  ${chalk.cyan('npx surgio generate')}`)
  console.log(`    生成新的配置文件`)
  console.log()
  console.log(`  ${chalk.cyan('npx surgio upload')}`)
  console.log(`    上传所有配置文件`)
  console.log()
  console.log('目录中已包含一些用于演示的配置，快去试试吧！')
  console.log()
  console.log(`  ${chalk.cyan('cd')} ${appName}`)
  console.log(`  ${chalk.cyan('npm run update')}`)
  console.log()
  console.log(`使用文档: ${chalk.green('https://surgio.js.org/')}`)
  console.log(`交流群: ${chalk.green('https://t.me/surgiotg')}`)
  console.log()
}

function isSafeToCreateProjectIn(root, name) {
  const validFiles = [
    '.DS_Store',
    'Thumbs.db',
    '.git',
    '.gitignore',
    '.idea',
    'README.md',
    'LICENSE',
    '.hg',
    '.hgignore',
    '.hgcheck',
    '.npmignore',
    'mkdocs.yml',
    'docs',
    '.travis.yml',
    '.gitlab-ci.yml',
    '.gitattributes',
  ]
  console.log()

  const conflicts = fs
    .readdirSync(root)
    .filter((file) => !validFiles.includes(file))
    // IntelliJ IDEA creates module files before CRA is launched
    .filter((file) => !/\.iml$/.test(file))
    // Don't treat log files from previous installation as conflicts
    .filter(
      (file) =>
        !errorLogFilePatterns.some((pattern) => file.indexOf(pattern) === 0)
    )

  if (conflicts.length > 0) {
    console.log(`${chalk.green(name)} 目录中包含冲突的文件：`)
    console.log()
    for (const file of conflicts) {
      console.log(`  ${file}`)
    }
    console.log()
    console.log('尝试使用一个新的目录名，或者将上述文件（夹）删除后重试')

    return false
  }

  // Remove any remnant files from a previous installation
  const currentFiles = fs.readdirSync(join(root))
  currentFiles.forEach((file) => {
    errorLogFilePatterns.forEach((errorLogFilePattern) => {
      // This will catch `(npm-debug|yarn-error|yarn-debug).log*` files
      if (file.indexOf(errorLogFilePattern) === 0) {
        fs.removeSync(join(root, file))
      }
    })
  })
  return true
}

function checkThatNpmCanReadCwd() {
  const cwd = process.cwd()
  let childOutput = null
  try {
    // Note: intentionally using spawn over exec since
    // the problem doesn't reproduce otherwise.
    // `npm config list` is the only reliable way I could find
    // to reproduce the wrong path. Just printing process.cwd()
    // in a Node process was not enough.
    childOutput = spawn.sync('npm', ['config', 'list']).output.join('')
  } catch (err) {
    // Something went wrong spawning node.
    // Not great, but it means we can't do this check.
    // We might fail later on, but let's continue.
    return true
  }
  if (typeof childOutput !== 'string') {
    return true
  }
  const lines = childOutput.split('\n')
  // `npm config list` output includes the following line:
  // "; cwd = C:\path\to\current\dir" (unquoted)
  // I couldn't find an easier way to get it.
  const prefix = '; cwd = '
  const line = lines.find((line) => line.indexOf(prefix) === 0)
  if (typeof line !== 'string') {
    // Fail gracefully. They could remove it.
    return true
  }
  const npmCWD = line.substring(prefix.length)
  if (npmCWD === cwd) {
    return true
  }
  console.error(
    chalk.red(
      `Could not start an npm process in the right directory.\n\n` +
        `The current directory is: ${chalk.bold(cwd)}\n` +
        `However, a newly started npm process runs in: ${chalk.bold(
          npmCWD
        )}\n\n` +
        `This is probably caused by a misconfigured system terminal shell.`
    )
  )
  if (process.platform === 'win32') {
    console.error(
      chalk.red(`On Windows, this can usually be fixed by running:\n\n`) +
        `  ${chalk.cyan(
          'reg'
        )} delete "HKCU\\Software\\Microsoft\\Command Processor" /v AutoRun /f\n` +
        `  ${chalk.cyan(
          'reg'
        )} delete "HKLM\\Software\\Microsoft\\Command Processor" /v AutoRun /f\n\n` +
        chalk.red(`Try to run the above two lines in the terminal.\n`) +
        chalk.red(
          `To learn more about this problem, read: https://blogs.msdn.microsoft.com/oldnewthing/20071121-00/?p=24433/`
        )
    )
  }
  return false
}

function install(root, dependencies, verbose) {
  return new Promise((resolve, reject) => {
    let command
    let args

    command = 'npm'
    args = ['install', '--save', '--save-exact', '--loglevel', 'error'].concat(
      dependencies
    )

    if (verbose) {
      args.push('--verbose')
    }

    const child = spawn(command, args, { stdio: 'inherit' })
    child.on('close', (code) => {
      if (code !== 0) {
        reject({
          command: `${command} ${args.join(' ')}`,
        })
        return
      }
      resolve()
    })
  })
}

async function renderTemplates(root, useAliyunOss, allowAnalytics) {
  const confTpl = Handlebars.compile(
    await fs.readFile(join(__dirname, 'template/surgio.conf.js.hbs'), {
      encoding: 'utf8',
    })
  )
  const gitignoreTpl = Handlebars.compile(
    await fs.readFile(join(__dirname, 'template/gitignore.hbs'), {
      encoding: 'utf8',
    })
  )
  const eslintrcTpl = Handlebars.compile(
    await fs.readFile(join(__dirname, 'template/eslintrc.js.hbs'), {
      encoding: 'utf8',
    })
  )

  const paths = {
    conf: join(root, 'surgio.conf.js'),
    gitignore: join(root, '.gitignore'),
    eslintrc: join(root, '.eslintrc.js'),
  }

  await fs.writeFile(
    paths.conf,
    confTpl({
      useAliyunOss,
      allowAnalytics,
    }) + os.EOL
  )
  await fs.writeFile(paths.gitignore, gitignoreTpl({}) + os.EOL)
  await fs.writeFile(paths.eslintrc, eslintrcTpl({}) + os.EOL)

  console.log(`配置已生成至 ${chalk.green(paths.conf)}，请将配置补全`)
  if (useAliyunOss) {
    console.log('阿里云 OSS 配置可以在管理面板中找到')
  }
  console.log()
}

async function copyFolders(root) {
  const folders = ['provider', 'template']

  await Promise.each(folders, async (item) => {
    const source = join(__dirname, `template/${item}`)
    await fs.copy(source, join(root, item))
  })
}
