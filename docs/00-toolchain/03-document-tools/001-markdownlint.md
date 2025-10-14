# Markdownlint 文档质量检查配置指南

> 基于 Python 高级开发工程师+架构师+高级文档工程师的专业视角制定的 Markdownlint 配置指南

## 1. 快速开始与基础应用

### 1.1 5 分钟快速上手

Markdownlint 是 Node.js 生态中的 Markdown 文档质量检查工具，通过规则引擎确保 Markdown 文档的一致性和可读性。在 Python 项目中，主要用于技术文档的质量控制。

#### 安装与基础使用

```bash
# 项目本地安装（推荐）
pnpm add -D markdownlint-cli

# 检查单个文件
markdownlint README.md

# 检查整个项目
markdownlint "**/*.md"

# 自动修复部分问题
markdownlint --fix "**/*.md"
```

#### 核心命令速查

```bash
# 基础检查
markdownlint file.md                    # 检查单个文件
markdownlint "**/*.md"                  # 检查所有 Markdown 文件
markdownlint --config .markdownlint.json "**/*.md"  # 使用配置文件

# 输出控制
markdownlint --format json "**/*.md"     # JSON 格式输出
markdownlint --quiet "**/*.md"          # 静默模式

# 修复功能
markdownlint --fix "**/*.md"            # 自动修复可修复的问题
```

### 1.2 项目集成配置

#### 基础项目配置

```json
// .markdownlint.json
{
  "default": true,
  "MD013": {
    "line_length": 200,
    "code_blocks": false,
    "tables": false
  },
  "MD033": {
    "allowed_elements": ["details", "summary", "br", "hr"]
  },
  "MD041": false,
  "MD036": false,
  "MD040": false,
  "MD051": false,
  "MD029": {
    "style": "ordered"
  },
  "MD024": {
    "siblings_only": true
  },
  "MD007": {
    "indent": 2
  },
  "MD012": {
    "maximum": 1
  }
}
```

## 2. 项目配置与最佳实践

### 2.1 配置文件管理

#### 配置文件优先级

1. **命令行参数** - 最高优先级
2. **配置文件** - `.markdownlint.json`、`.markdownlint.yaml`、`.markdownlint.yml`
3. **默认规则** - 内置规则集

#### 配置文件格式

```json
// .markdownlint.json - JSON 格式（推荐）
{
  "default": true,
  "MD013": {
    "line_length": 200,
    "code_blocks": false,
    "tables": false
  },
  "MD033": {
    "allowed_elements": ["details", "summary", "br", "hr"]
  },
  "MD029": { "style": "ordered" },
  "MD024": { "siblings_only": true },
  "MD007": { "indent": 2 },
  "MD012": { "maximum": 1 }
}
```

### 2.2 规则配置策略

#### 核心规则配置

```json
{
  "default": true,
  "MD013": {
    "line_length": 200,
    "code_blocks": false,
    "tables": false
  },
  "MD033": {
    "allowed_elements": ["details", "summary", "br", "hr"]
  },
  "MD041": false,
  "MD036": false,
  "MD040": false,
  "MD051": false,
  "MD029": {
    "style": "ordered"
  },
  "MD024": {
    "siblings_only": true
  },
  "MD007": {
    "indent": 2
  },
  "MD012": {
    "maximum": 1
  }
}
```

### 2.3 文件级配置

#### 文件内忽略规则

```markdown
<!-- markdownlint-disable MD013 -->

这是一行很长的文本，超过了默认的行长度限制，但在这个特定文件中我们允许这种情况

<!-- markdownlint-enable MD013 -->
```

#### 行级忽略

```markdown
<!-- markdownlint-disable-next-line MD013 -->

这是一行很长的文本，超过了默认的行长度限制

这行正常文本 <!-- markdownlint-disable-line MD013 -->
```

## 3. 工作流程集成

### 3.1 IDE 集成

#### VS Code 集成

```json
// .vscode/settings.json
{
  "markdownlint.config": {
    "default": true,
    "MD013": {
      "line_length": 200,
      "code_blocks": false,
      "tables": false
    },
    "MD033": {
      "allowed_elements": ["details", "summary", "br", "hr"]
    },
    "MD029": { "style": "ordered" },
    "MD024": { "siblings_only": true },
    "MD007": { "indent": 2 },
    "MD012": { "maximum": 1 }
  },
  "markdownlint.ignore": [
    "**/node_modules/**",
    "**/dist/**",
    "**/build/**",
    "**/venv/**",
    "**/.venv/**"
  ]
}
```

#### 扩展配置

```json
// .vscode/extensions.json
{
  "recommendations": ["davidanson.vscode-markdownlint"]
}
```

### 3.2 CI/CD 集成

#### GitHub Actions 配置

```yaml
# .github/workflows/markdownlint.yml
name: Markdownlint

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  markdownlint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'
      - name: Install markdownlint
        run: pnpm add -g markdownlint-cli
      - name: Run markdownlint
        run: markdownlint "**/*.md" --config .markdownlint.json --ignore node_modules --ignore venv --ignore .venv --ignore .git
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

#### 规则冲突问题

```bash
# 检查规则配置
markdownlint --config .markdownlint.json --verbose "**/*.md"

# 输出详细信息
markdownlint --format json "**/*.md" > markdownlint-results.json
```

#### 配置文件问题

```bash
# 验证配置文件语法
node -e "console.log(JSON.parse(require('fs').readFileSync('.markdownlint.json', 'utf8')))"

# 检查配置文件路径
markdownlint --config .markdownlint.json --help
```

### 4.2 性能优化

#### 排除大文件

```bash
# 排除特定文件
markdownlint "**/*.md" --ignore "**/node_modules/**" --ignore "**/dist/**" --ignore "**/venv/**" --ignore "**/.venv/**"
```

#### 增量检查

```bash
# 只检查修改的文件
git diff --name-only HEAD~1 | grep '\.md$' | xargs markdownlint
```

## 5. 技术原理深度解析

### 5.1 规则引擎架构

#### 规则解析机制

```javascript
// 规则解析流程
const rules = {
  MD013: {
    line_length: 200,
    code_blocks: false,
    tables: false,
  },
}

// 规则应用逻辑
function applyRule(ruleName, config, content) {
  const rule = rules[ruleName]
  if (!rule) return []

  return rule.check(content, config)
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

### 5.2 性能优化技术

#### 文件解析优化

```javascript
// 增量解析
function parseIncremental(files, lastCheck) {
  return files.filter((file) => file.mtime > lastCheck || file.size !== lastCheck.size)
}
```

#### 规则缓存机制

```javascript
// 规则缓存
const ruleCache = new Map()

function getCachedRule(ruleName, config) {
  const key = `${ruleName}-${JSON.stringify(config)}`
  if (ruleCache.has(key)) {
    return ruleCache.get(key)
  }

  const rule = loadRule(ruleName, config)
  ruleCache.set(key, rule)
  return rule
}
```

### 5.3 扩展机制

#### 规则扩展原理

```javascript
// 规则解析流程
const rules = {
  MD013: {
    line_length: 200,
    code_blocks: false,
    tables: false,
  },
}

// 规则应用逻辑
function applyRule(ruleName, config, content) {
  const rule = rules[ruleName]
  if (!rule) return []

  return rule.check(content, config)
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

**总结**: Markdownlint 通过规则引擎确保 Markdown 文档质量，支持灵活的配置管理和团队协作，是现代文档项目的重要工具。
