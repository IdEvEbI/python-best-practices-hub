# Pre-commit 提交前检查集成配置指南

> 基于 Python 高级开发工程师+架构师+高级文档工程师的专业视角制定的 Pre-commit 配置指南

## 1. 快速开始与基础应用

### 1.1 5 分钟快速上手

Pre-commit 是 Git 提交前检查工具，通过钩子机制在代码提交前自动运行质量检查，确保代码质量和团队协作的一致性。在 Python 项目中，主要用于集成各种代码质量工具。

#### 安装与基础使用

```bash
# 项目本地安装（推荐）
pip install pre-commit

# 安装 Git 钩子
pre-commit install

# 手动运行所有检查
pre-commit run --all-files

# 运行特定钩子
pre-commit run ruff
```

#### 核心命令速查

```bash
# 钩子管理
pre-commit install                    # 安装 Git 钩子
pre-commit uninstall                   # 卸载 Git 钩子
pre-commit install --hook-type pre-push # 安装推送前钩子

# 检查运行
pre-commit run                        # 运行所有钩子
pre-commit run --all-files            # 检查所有文件
pre-commit run ruff                   # 运行特定钩子

# 配置管理
pre-commit clean                      # 清理缓存
pre-commit autoupdate                 # 更新钩子版本
```

### 1.2 项目集成配置

#### 基础项目配置

```yaml
# .pre-commit-config.yaml
repos:
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v4.4.0
    hooks:
      - id: trailing-whitespace
      - id: end-of-file-fixer
      - id: check-yaml
      - id: check-added-large-files
      - id: check-merge-conflict

  - repo: https://github.com/adrienverge/yamllint.git
    rev: v1.37.1
    hooks:
      - id: yamllint
        args: [--config-file=.yamllint]

  - repo: https://github.com/astral-sh/ruff-pre-commit
    rev: v0.1.0
    hooks:
      - id: ruff
        args: [--fix]
      - id: ruff-format

  - repo: https://github.com/pre-commit/mirrors-mypy
    rev: v1.7.0
    hooks:
      - id: mypy
        args: [--config-file=pyproject.toml]

  - repo: https://github.com/PyCQA/bandit
    rev: 1.8.6
    hooks:
      - id: bandit
        args: [--configfile=pyproject.toml]

  - repo: https://github.com/igorshubovych/markdownlint-cli
    rev: v0.37.0
    hooks:
      - id: markdownlint
        args: [--config=.markdownlint.json]

  - repo: local
    hooks:
      - id: format-markdown
        name: Format Markdown
        entry: pnpm run format
        language: system
        files: \.md$
        pass_filenames: true
```

## 2. 项目配置与最佳实践

### 2.1 配置文件管理

#### 配置文件优先级

1. **命令行参数** - 最高优先级
2. **配置文件** - `.pre-commit-config.yaml`
3. **默认配置** - 内置默认值

#### 配置文件格式

```yaml
# .pre-commit-config.yaml - YAML 格式（推荐）
repos:
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v4.4.0
    hooks:
      - id: trailing-whitespace
      - id: end-of-file-fixer
```

### 2.2 钩子配置策略

#### 核心钩子配置

```yaml
repos:
  # 基础检查钩子
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v4.4.0
    hooks:
      - id: trailing-whitespace
      - id: end-of-file-fixer
      - id: check-yaml
      - id: check-added-large-files
      - id: check-merge-conflict

  # YAML 格式检查
  - repo: https://github.com/adrienverge/yamllint.git
    rev: v1.37.1
    hooks:
      - id: yamllint
        args: [--config-file=.yamllint]

  # Python 代码检查
  - repo: https://github.com/astral-sh/ruff-pre-commit
    rev: v0.1.0
    hooks:
      - id: ruff
        args: [--fix]
      - id: ruff-format

  # Python 类型检查
  - repo: https://github.com/pre-commit/mirrors-mypy
    rev: v1.7.0
    hooks:
      - id: mypy
        args: [--config-file=pyproject.toml]

  # Python 安全检查
  - repo: https://github.com/PyCQA/bandit
    rev: 1.8.6
    hooks:
      - id: bandit
        args: [--configfile=pyproject.toml]

  # Markdown 文档检查
  - repo: https://github.com/igorshubovych/markdownlint-cli
    rev: v0.37.0
    hooks:
      - id: markdownlint
        args: [--config=.markdownlint.json]

  # 本地脚本钩子
  - repo: local
    hooks:
      - id: format-markdown
        name: Format Markdown
        entry: pnpm run format
        language: system
        files: \.md$
        pass_filenames: true
```

### 2.3 文件级配置

#### 文件内忽略规则

```python
# ruff: noqa: E501
def long_function_name_with_many_parameters(param1, param2, param3):
    pass
```

#### 目录级配置

```yaml
# .pre-commit-config.yaml
repos:
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v4.4.0
    hooks:
      - id: trailing-whitespace
      - id: end-of-file-fixer
      - id: check-yaml
      - id: check-added-large-files
      - id: check-merge-conflict
```

#### 扩展配置示例

```yaml
# 带排除规则的配置示例
repos:
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v4.4.0
    hooks:
      - id: trailing-whitespace
        exclude: ^(docs/|tests/) # 排除特定目录
      - id: end-of-file-fixer
        types: [text] # 只检查文本文件
```

## 3. 工作流程集成

### 3.1 IDE 集成

#### VS Code 集成

```json
// .vscode/settings.json
{
  "python.defaultInterpreterPath": "./venv/bin/python",
  "python.terminal.activateEnvironment": true,
  "git.enableCommitSigning": true,
  "git.confirmSync": false
}
```

#### 扩展配置

```json
// .vscode/extensions.json
{
  "recommendations": ["ms-python.python", "ms-python.vscode-pylance"]
}
```

### 3.2 CI/CD 集成

#### GitHub Actions 配置

```yaml
# .github/workflows/pre-commit.yml
name: Pre-commit

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  pre-commit:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Setup Python
        uses: actions/setup-python@v4
        with:
          python-version: '3.12'
      - name: Install pre-commit
        run: pip install pre-commit
      - name: Run pre-commit
        run: pre-commit run --all-files
```

#### 本地开发集成

```bash
# 开发环境设置
pre-commit install
pre-commit run --all-files

# 提交前自动检查
git add .
git commit -m "feat: add new feature"
```

## 4. 故障排除与问题解决

### 4.1 常见问题诊断

#### 钩子执行失败

```bash
# 检查钩子状态
pre-commit run --all-files --verbose

# 跳过特定钩子
SKIP=ruff git commit -m "feat: add feature"

# 强制运行钩子
pre-commit run --all-files --hook-stage manual
```

#### 配置文件问题

```bash
# 验证配置文件语法
pre-commit validate-config

# 检查钩子版本
pre-commit autoupdate --dry-run
```

### 4.2 性能优化

#### 缓存管理

```bash
# 清理缓存
pre-commit clean

# 清理特定钩子缓存
pre-commit clean ruff
```

#### 增量检查

```bash
# 只检查修改的文件
pre-commit run

# 检查特定文件类型
pre-commit run --files *.py

# 检查特定目录
pre-commit run --files docs/
```

## 5. 技术原理深度解析

### 5.1 钩子机制架构

#### Git 钩子集成

```python
# Git 钩子安装逻辑
def install_hooks():
    hook_dir = Path('.git/hooks')
    hook_file = hook_dir / 'pre-commit'

    with open(hook_file, 'w') as f:
        f.write(hook_content)

    hook_file.chmod(0o755)
```

#### 钩子执行流程

```python
# 钩子执行逻辑
def run_hooks(files):
    config = load_config('.pre-commit-config.yaml')

    for repo in config['repos']:
        for hook in repo['hooks']:
            if should_run_hook(hook, files):
                result = execute_hook(hook, files)
                if result.returncode != 0:
                    return result
```

### 5.2 性能优化技术

#### 并行执行

```python
# 并行钩子执行
import concurrent.futures

def run_hooks_parallel(hooks, files):
    with concurrent.futures.ThreadPoolExecutor() as executor:
        futures = [executor.submit(run_hook, hook, files) for hook in hooks]
        results = [future.result() for future in futures]
    return results
```

#### 缓存机制

```python
# 钩子结果缓存
import hashlib

def get_cache_key(hook, files):
    content = f"{hook['id']}:{sorted(files)}"
    return hashlib.md5(content.encode()).hexdigest()
```

### 5.3 扩展机制

#### 钩子配置策略

```yaml
# 钩子配置优先级
repos:
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v4.4.0
    hooks:
      - id: trailing-whitespace
        exclude: ^(docs/|tests/) # 排除特定目录
      - id: end-of-file-fixer
        types: [text] # 只检查文本文件
```

#### 本地钩子集成

```yaml
# 本地脚本钩子
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

---

**总结**: Pre-commit 通过 Git 钩子机制确保代码质量，支持多种工具集成和灵活的配置管理，是现代项目质量管控的重要工具。
