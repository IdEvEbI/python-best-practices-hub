# Prettier 文档格式化配置指南

> 基于 Python 高级开发工程师+架构师+高级文档工程师的专业视角制定的 Prettier 配置指南

## 1. 快速开始与基础应用

### 1.1 5 分钟快速上手

Prettier 是现代化的代码格式化工具，支持多种语言和文件格式。在 Python 项目中，主要用于 Markdown、JSON、YAML 等配置文件的格式化，确保代码风格的一致性。

#### 安装与基础使用

```bash
# 项目本地安装（推荐）
pnpm add -D prettier prettier-plugin-zh

# 格式化所有文件
prettier --write .

# 检查格式化状态
prettier --check .

# 格式化特定文件
prettier --write "**/*.md"
```

#### 核心命令速查

```bash
# 基础格式化
prettier --write file.js              # 格式化单个文件
prettier --write "**/*.{js,md}"       # 格式化多种文件类型
prettier --check .                    # 检查格式化状态

# 输出控制
prettier --write --list-different .   # 只显示需要格式化的文件
prettier --write --log-level debug .  # 调试模式

# 项目脚本
pnpm run format                       # 格式化所有文件
pnpm run format:check                 # 检查格式化状态
```

### 1.2 项目集成配置

#### 基础项目配置

```json
// .prettierrc
{
  "semi": false,
  "singleQuote": true,
  "trailingComma": "es5",
  "printWidth": 80,
  "tabWidth": 2,
  "useTabs": false,
  "endOfLine": "lf",
  "plugins": ["prettier-plugin-zh"],
  "overrides": [
    {
      "files": "*.md",
      "options": {
        "printWidth": 100,
        "proseWrap": "preserve"
      }
    }
  ]
}
```

## 2. 项目配置与最佳实践

### 2.1 配置文件管理

#### 配置文件优先级

1. **命令行参数** - 最高优先级
2. **配置文件** - `.prettierrc`、`.prettierrc.json`、`.prettierrc.yaml`、`prettier.config.js`
3. **package.json** - `prettier` 字段
4. **默认配置** - 内置默认值

#### 配置文件格式

```json
// .prettierrc - JSON 格式（推荐）
{
  "semi": false,
  "singleQuote": true,
  "trailingComma": "es5",
  "printWidth": 80,
  "tabWidth": 2,
  "useTabs": false,
  "endOfLine": "lf",
  "plugins": ["prettier-plugin-zh"]
}
```

### 2.2 规则配置策略

#### 核心规则配置

```json
{
  "semi": false,
  "singleQuote": true,
  "trailingComma": "es5",
  "printWidth": 80,
  "tabWidth": 2,
  "useTabs": false,
  "endOfLine": "lf",
  "plugins": ["prettier-plugin-zh"],
  "overrides": [
    {
      "files": "*.md",
      "options": {
        "printWidth": 100,
        "proseWrap": "preserve"
      }
    }
  ]
}
```

#### 扩展配置示例

```json
{
  "semi": false,
  "singleQuote": true,
  "trailingComma": "es5",
  "printWidth": 80,
  "tabWidth": 2,
  "useTabs": false,
  "endOfLine": "lf",
  "plugins": ["prettier-plugin-zh"],
  "overrides": [
    {
      "files": "*.md",
      "options": {
        "printWidth": 100,
        "proseWrap": "preserve"
      }
    },
    {
      "files": "*.json",
      "options": {
        "printWidth": 120,
        "tabWidth": 2
      }
    },
    {
      "files": "*.yaml",
      "options": {
        "printWidth": 200,
        "tabWidth": 2
      }
    }
  ]
}
```

### 2.3 文件级配置

#### 文件内忽略规则

```javascript
// prettier-ignore
const matrix = [
  [1, 2, 3],
  [4, 5, 6],
  [7, 8, 9]
];
```

#### 目录级配置

```json
// .prettierignore
node_modules/
dist/
build/
*.min.js
*.bundle.js
pnpm-lock.yaml
```

## 3. 工作流程集成

### 3.1 IDE 集成

#### VS Code 集成

```json
// .vscode/settings.json
{
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "editor.formatOnSave": true,
  "editor.formatOnPaste": true,
  "prettier.configPath": ".prettierrc",
  "prettier.ignorePath": ".prettierignore",
  "[markdown]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "[json]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  }
}
```

#### 扩展配置

```json
// .vscode/extensions.json
{
  "recommendations": ["esbenp.prettier-vscode"]
}
```

### 3.2 CI/CD 集成

#### GitHub Actions 配置

```yaml
# .github/workflows/prettier.yml
name: Prettier

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  prettier:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'
      - name: Install prettier
        run: pnpm install
      - name: Check formatting
        run: pnpm run format:check
```

#### Pre-commit 集成

```yaml
# .pre-commit-config.yaml
repos:
  - repo: local
    hooks:
      - id: format-markdown
        name: Format Markdown
        entry: pnpm run format
        language: system
        files: \.md$
        pass_filenames: true
```

## 4. 故障排除与问题解决

### 4.1 常见问题诊断

#### 格式化冲突问题

```bash
# 检查配置文件
prettier --check --config .prettierrc .

# 输出详细信息
prettier --write --log-level debug .
```

#### 配置文件问题

```bash
# 验证配置文件语法
node -e "console.log(JSON.parse(require('fs').readFileSync('.prettierrc', 'utf8')))"

# 检查配置文件路径
prettier --config .prettierrc --help
```

### 4.2 性能优化

#### 排除大文件

```bash
# 排除特定文件
prettier --write --ignore-path .prettierignore .

# 排除特定目录
prettier --write --ignore-path .prettierignore "**/*.{md,json,yaml}"
```

#### 增量格式化

```bash
# 只格式化修改的文件
git diff --name-only HEAD~1 | grep -E '\.(md|json|yaml)$' | xargs prettier --write

# 只格式化暂存的文件
git diff --cached --name-only | grep -E '\.(md|json|yaml)$' | xargs prettier --write
```

## 5. 技术原理深度解析

### 5.1 格式化引擎架构

#### 解析器机制

```javascript
// 解析器选择逻辑
const parsers = {
  javascript: 'babel',
  typescript: 'typescript',
  markdown: 'markdown',
  json: 'json',
  yaml: 'yaml',
}

function selectParser(filePath) {
  const ext = path.extname(filePath).slice(1)
  return parsers[ext] || 'babel'
}
```

#### 格式化策略

```javascript
// 格式化策略
function formatCode(code, options) {
  const ast = parse(code)
  const formatted = format(ast, options)
  return formatted
}
```

### 5.2 性能优化技术

#### 文件解析优化

```javascript
// 增量解析
function parseIncremental(files, lastCheck) {
  return files.filter((file) => file.mtime > lastCheck || file.size !== lastCheck.size)
}
```

#### 缓存机制

```javascript
// 格式化缓存
const formatCache = new Map()

function getCachedFormat(code, options) {
  const key = `${code}-${JSON.stringify(options)}`
  if (formatCache.has(key)) {
    return formatCache.get(key)
  }

  const formatted = format(code, options)
  formatCache.set(key, formatted)
  return formatted
}
```

### 5.3 扩展机制

#### 插件系统

```javascript
// 插件加载机制
function loadPlugins(pluginPaths) {
  return pluginPaths
    .map((path) => {
      try {
        return require(path)
      } catch (error) {
        console.warn(`Failed to load plugin: ${path}`)
        return null
      }
    })
    .filter(Boolean)
}
```

#### 配置合并策略

```javascript
// 配置合并逻辑
function mergeConfigs(defaultConfig, fileConfig, cliConfig) {
  return {
    ...defaultConfig,
    ...fileConfig,
    ...cliConfig,
  }
}
```

---

**总结**: Prettier 通过统一的格式化引擎确保代码风格一致性，支持多种语言和灵活的配置管理，是现代项目代码质量的重要工具。
