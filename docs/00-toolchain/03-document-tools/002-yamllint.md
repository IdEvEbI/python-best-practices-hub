# Yamllint YAML 文件格式检查配置指南

> 基于 Python 高级开发工程师+架构师+高级文档工程师的专业视角制定的 Yamllint 配置指南

## 1. 快速开始与基础应用

### 1.1 5 分钟快速上手

Yamllint 是 Python 生态中的 YAML 文件格式检查工具，通过规则引擎确保 YAML 文件的一致性和可读性。在 Python 项目中，主要用于 CI/CD 配置文件、Docker 配置等 YAML 文件的质量控制。

#### 安装与基础使用

```bash
# 项目本地安装（推荐）
pip install yamllint

# 检查单个文件
yamllint .pre-commit-config.yaml

# 检查整个项目
yamllint .

# 检查特定目录
yamllint .github/
```

#### 核心命令速查

```bash
# 基础检查
yamllint file.yaml                    # 检查单个文件
yamllint .                           # 检查当前目录
yamllint --config .yamllint .        # 使用配置文件

# 输出控制
yamllint --format parsable .         # 机器可读格式
yamllint --strict .                  # 严格模式
```

### 1.2 项目集成配置

#### 基础项目配置

```yaml
# .yamllint
extends: default

rules:
  line-length:
    max: 200
    level: warning
  indentation:
    spaces: 2
  comments:
    min-spaces-from-content: 1
  document-start:
    present: false
  truthy:
    allowed-values: ['true', 'false', 'on', 'off']
  key-duplicates: enable
  braces:
    min-spaces-inside: 0
    max-spaces-inside: 0

ignore: |
  .github/
  node_modules/
  venv/
  .venv/
  *.lock
  pnpm-lock.yaml
```

## 2. 项目配置与最佳实践

### 2.1 配置文件管理

#### 配置文件优先级

1. **命令行参数** - 最高优先级
2. **配置文件** - `.yamllint`、`.yamllint.yaml`、`.yamllint.yml`
3. **默认规则** - 内置规则集

#### 配置文件格式

```yaml
# .yamllint - YAML 格式（推荐）
extends: default

rules:
  line-length:
    max: 200
    level: warning
  indentation:
    spaces: 2
```

### 2.2 规则配置策略

#### 核心规则配置

```yaml
# .yamllint
extends: default

rules:
  # 行长度限制
  line-length:
    max: 200
    level: warning

  # 缩进设置
  indentation:
    spaces: 2
    indent-sequences: true
    check-multi-line-strings: false

  # 注释规范
  comments:
    min-spaces-from-content: 1

  # 文档开始标记
  document-start:
    present: false

  # 布尔值规范
  truthy:
    allowed-values: ['true', 'false', 'on', 'off']

  # 空行规范
  empty-lines:
    max: 2
    max-start: 0
    max-end: 1

  # 键值对规范
  key-duplicates: enable

  # 括号内空格规范
  braces:
    min-spaces-inside: 0
    max-spaces-inside: 0

ignore: |
  .github/
  node_modules/
  venv/
  .venv/
  *.lock
  pnpm-lock.yaml
```

### 2.3 文件级配置

#### 文件内忽略规则

```yaml
# yamllint disable-line rule:key
apiVersion: v1
kind: ConfigMap
metadata:
  name: my-config
  # yamllint disable-line rule:indentation
  namespace: default
```

#### 目录级配置

```yaml
# .yamllint
extends: default

rules:
  line-length:
    max: 200
    level: warning

ignore: |
  .github/
  node_modules/
  venv/
  .venv/
  *.lock
  pnpm-lock.yaml
```

## 3. 工作流程集成

### 3.1 IDE 集成

#### VS Code 集成

```json
// .vscode/settings.json
{
  "yamllint.config": ".yamllint",
  "yamllint.ignore": [".github/**", "node_modules/**", "venv/**", ".venv/**", "*.lock"]
}
```

#### 扩展配置

```json
// .vscode/extensions.json
{
  "recommendations": ["redhat.vscode-yaml"]
}
```

### 3.2 CI/CD 集成

#### GitHub Actions 配置

```yaml
# .github/workflows/yamllint.yml
name: Yamllint

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  yamllint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Setup Python
        uses: actions/setup-python@v4
        with:
          python-version: '3.12'
      - name: Install yamllint
        run: pip install yamllint
      - name: Run yamllint
        run: yamllint --config-file .yamllint .
```

#### Pre-commit 集成

```yaml
# .pre-commit-config.yaml
repos:
  - repo: https://github.com/adrienverge/yamllint.git
    rev: v1.37.1
    hooks:
      - id: yamllint
        args: [--config-file=.yamllint]
```

## 4. 故障排除与问题解决

### 4.1 常见问题诊断

#### 规则冲突问题

```bash
# 检查规则配置
yamllint --config-file .yamllint --verbose .

# 输出详细信息
yamllint --format parsable . > yamllint-results.txt
```

#### 配置文件问题

```bash
# 验证配置文件语法
yamllint --config-file .yamllint --help

# 检查配置文件路径
yamllint --config-file .yamllint --list-files .
```

### 4.2 性能优化

#### 排除大文件

```yaml
# .yamllint
extends: default

rules:
  line-length:
    max: 200
    level: warning

ignore: |
  .github/
  node_modules/
  venv/
  .venv/
  *.lock
  pnpm-lock.yaml
```

#### 增量检查

```bash
# 只检查修改的文件
git diff --name-only HEAD~1 | grep '\.ya\?ml$' | xargs yamllint
```

## 5. 技术原理深度解析

### 5.1 规则引擎架构

#### 规则解析机制

```python
# 规则解析流程
import yaml
from yamllint import linter

def parse_yaml_rules(config_file):
    with open(config_file, 'r') as f:
        config = yaml.safe_load(f)

    rules = config.get('rules', {})
    return rules

# 规则应用逻辑
def apply_rules(content, rules):
    problems = []
    for rule_name, rule_config in rules.items():
        rule_problems = linter.check_rule(content, rule_name, rule_config)
        problems.extend(rule_problems)
    return problems
```

#### 配置合并策略

```python
# 配置合并逻辑
def merge_configs(default_config, file_config, cli_config):
    merged = default_config.copy()
    merged.update(file_config)
    merged.update(cli_config)
    return merged
```

### 5.2 性能优化技术

#### 文件解析优化

```python
# 增量解析
import os
from pathlib import Path

def parse_incremental(files, last_check):
    return [
        f for f in files
        if os.path.getmtime(f) > last_check or os.path.getsize(f) != last_check.get(f, 0)
    ]
```

#### 规则缓存机制

```python
# 规则缓存
from functools import lru_cache

@lru_cache(maxsize=128)
def get_cached_rule(rule_name, config_hash):
    return load_rule(rule_name, config_hash)
```

### 5.3 扩展机制

#### 规则扩展原理

```python
# 规则解析流程
import yaml
from yamllint import linter

def parse_yaml_rules(config_file):
    with open(config_file, 'r') as f:
        config = yaml.safe_load(f)

    rules = config.get('rules', {})
    return rules

# 规则应用逻辑
def apply_rules(content, rules):
    problems = []
    for rule_name, rule_config in rules.items():
        rule_problems = linter.check_rule(content, rule_name, rule_config)
        problems.extend(rule_problems)
    return problems
```

#### 配置合并策略

```python
# 配置合并逻辑
def merge_configs(default_config, file_config, cli_config):
    merged = default_config.copy()
    merged.update(file_config)
    merged.update(cli_config)
    return merged
```

---

**总结**: Yamllint 通过规则引擎确保 YAML 文件质量，支持灵活的配置管理和团队协作，是现代项目配置文件管理的重要工具。
