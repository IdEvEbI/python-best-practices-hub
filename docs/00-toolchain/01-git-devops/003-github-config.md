# GitHub 配置指南

> 本文档详细介绍项目的 GitHub 平台配置，包括分支保护、PR 模板、Issue 模板、Actions 工作流和 Dependabot 配置。

## 1. 为什么需要 GitHub 配置？

**设计目标**：通过 GitHub 平台的高级功能，实现企业级的代码管理和团队协作，确保项目的安全性和可维护性。

**核心问题**：

- ⚠️ **权限控制**：如何防止未授权的代码修改？
- ⚠️ **质量保证**：如何确保合并的代码符合质量标准？
- ⚠️ **团队协作**：如何规范团队的协作流程？
- ⚠️ **历史保护**：如何防止 Git 历史被破坏？

**技术原理**：

- 🔒 **分支保护**：通过 GitHub 分支保护规则强制执行质量门禁
- 📋 **PR 模板**：标准化 Pull Request（拉取请求）内容，提高审查效率
- 🔍 **状态检查**：集成 CI/CD（持续集成/持续部署）检查，确保代码质量
- 📝 **签名验证**：通过 GPG（GNU Privacy Guard）签名确保提交的真实性

## 2. 分支保护设置

**目的**：通过 GitHub 分支保护规则，强制执行代码质量标准和协作流程，防止低质量代码进入主分支。

**技术原理**：

- 🛡️ **访问控制**：限制谁可以推送和合并代码
- 🔍 **质量门禁**：要求通过 PR 和审查才能合并
- 📋 **流程强制**：强制执行代码审查和测试流程
- 🔒 **历史保护**：防止强制推送和分支删除

### 2.1 Main 分支保护规则

| 规则                                      | 技术原理     | 解决的问题       | 预期效果       |
| ----------------------------------------- | ------------ | ---------------- | -------------- |
| **Require a pull request before merging** | 强制 PR 流程 | 防止直接推送     | 确保代码审查   |
| **Require approvals**                     | 人工审查机制 | 防止单人决策错误 | 提高代码质量   |
| **Require conversation resolution**       | 讨论解决机制 | 防止未解决问题   | 确保问题解决   |
| **Require signed commits**                | GPG 签名验证 | 防止身份伪造     | 确保提交真实性 |
| **Require linear history**                | 线性历史要求 | 防止复杂合并     | 简化历史追踪   |
| **Do not allow bypassing**                | 权限限制     | 防止绕过保护     | 强制执行规则   |

### 2.2 Develop 分支保护规则

| 规则                                      | 技术原理     | 解决的问题     | 预期效果       |
| ----------------------------------------- | ------------ | -------------- | -------------- |
| **Require a pull request before merging** | 强制 PR 流程 | 防止直接推送   | 确保代码审查   |
| **Require approvals**                     | 人工审查机制 | 防止明显错误   | 提高代码质量   |
| **Require conversation resolution**       | 讨论解决机制 | 防止未解决问题 | 确保问题解决   |
| **Require signed commits**                | GPG 签名验证 | 防止身份伪造   | 确保提交真实性 |
| **Require linear history**                | 线性历史要求 | 防止复杂合并   | 简化历史追踪   |
| **Do not allow bypassing**                | 权限限制     | 防止绕过保护   | 强制执行规则   |

## 3. Pull Request 模板

**目的**：通过标准化的 PR 模板，确保代码审查的完整性和一致性，提高团队协作效率。

**技术原理**：

- 📋 **结构化内容**：提供预定义的结构，引导开发者填写必要信息
- ✅ **检查清单**：确保关键项目（测试、文档）已完成
- 🔍 **审查引导**：为审查者提供清晰的审查要点
- 📊 **质量保证**：通过模板确保所有 PR 都经过充分准备

**解决的问题**：

- ⚠️ **信息不完整**：开发者提交 PR 时信息不完整
- ⚠️ **审查效率低**：审查者需要花费时间理解变更
- ⚠️ **标准不一致**：不同 PR 的审查标准不统一
- ⚠️ **遗漏检查**：容易遗漏重要的检查项目

**当前项目 PR 模板**：

```ini
.github/
└── PULL_REQUEST_TEMPLATE/
    ├── feature.md              # 新功能开发模板
    ├── bugfix.md               # Bug 修复模板
    ├── docs.md                 # 文档更新模板
    └── toolchain.md            # 工具链配置模板
```

**功能开发 PR 模板**：

```markdown
## 📋 功能描述

简要描述此 PR 的功能和目的。

## 🔧 变更内容

- [ ] 新增功能
- [ ] 修改现有功能
- [ ] 删除功能
- [ ] 文档更新

## 🧪 测试

- [ ] 单元测试已通过
- [ ] 集成测试已通过
- [ ] 手动测试已完成

## 📸 截图/演示

如有 UI 变更，请提供截图或演示链接。

## 🔗 相关 Issue

关联的 Issue: #123

## 📝 检查清单

- [ ] 代码符合项目规范
- [ ] 已添加必要的测试
- [ ] 文档已更新
- [ ] 提交消息符合规范
```

**预期效果**：

- ✅ 提高 PR 质量和审查效率
- ✅ 确保所有变更都经过充分测试和文档化
- ✅ 促进团队协作和知识共享

## 4. Issue 模板

**目的**：通过标准化的 Issue 模板，确保问题报告的完整性和一致性，提高问题解决效率。

**技术原理**：

- 📋 **结构化报告**：提供预定义的问题报告结构
- 🔍 **信息收集**：引导用户提供必要的问题信息
- 🏷️ **分类管理**：通过不同模板支持不同类型的问题
- 📊 **统计分析**：支持问题统计和趋势分析

**解决的问题**：

- ⚠️ **信息不完整**：用户报告问题时信息不完整
- ⚠️ **分类混乱**：不同类型的问题混在一起
- ⚠️ **处理效率低**：需要反复询问才能获得完整信息
- ⚠️ **优先级不清**：无法快速判断问题的严重程度

**当前项目 Issue 模板**：

```ini
.github/
└── ISSUE_TEMPLATE/
    ├── bug_report.md           # Bug 报告模板
    └── feature_request.md      # 功能请求模板
```

**预期效果**：

- ✅ 提高问题报告的质量和完整性
- ✅ 加速问题分类和处理流程
- ✅ 支持问题统计和优先级管理

## 5. GitHub Actions 工作流

**目的**：通过 GitHub Actions 实现自动化 CI/CD 流水线，确保代码质量、自动化测试和部署。

**技术原理**：

- 🤖 **自动化流水线**：在代码推送和 PR 创建时自动触发
- 🔄 **持续集成**：自动运行测试、检查、构建等操作
- 📊 **状态反馈**：通过状态检查提供实时的质量反馈
- 🚀 **持续部署**：支持自动化部署到不同环境

**解决的问题**：

- ⚠️ **手动操作耗时**：每次集成、测试、部署都需要人工干预
- ⚠️ **容易出错**：人工操作容易引入错误
- ⚠️ **反馈滞后**：问题在后期才发现，修复成本高
- ⚠️ **环境不一致**：不同开发者的环境配置差异

**当前项目工作流配置**：

```ini
.github/
└── workflows/
    └── ci.yml                  # CI/CD 工作流
```

**CI/CD 工作流**：`.github/workflows/ci.yml`

```yaml
name: CI/CD Pipeline

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main, develop]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Set up Python
        uses: actions/setup-python@v4
        with:
          python-version: '3.12'

      - name: Install dependencies
        run: |
          pip install pip-tools
          pip-sync requirements.txt requirements-dev.txt

      - name: Run code formatting check
        run: ruff format --check .

      - name: Run linting
        run: ruff check .

      - name: Run type checking
        run: mypy .

      - name: Run tests
        run: pytest tests/ -v

      - name: Run security check
        run: safety scan

      - name: Check commit message format
        run: cz check --rev-range HEAD~1..HEAD

  markdown:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Set up Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '18'
      - name: Install pnpm
        run: npm install -g pnpm
      - name: Install dependencies
        run: pnpm install
      - name: Run markdown linting
        run: pnpm run lint:md
      - name: Check markdown formatting
        run: pnpm run format:check
```

**预期效果**：

- ✅ 自动化代码质量检查和测试
- ✅ 确保代码集成和部署的可靠性
- ✅ 提高开发效率和交付速度
- ✅ 自动化安全漏洞扫描
- ✅ 确保提交消息符合规范
- ✅ 自动化文档格式检查

## 6. Dependabot 配置

**目的**：通过 Dependabot 自动监控和更新项目依赖，确保依赖的安全性和最新性。

**技术原理**：

- 🔍 **依赖扫描**：自动扫描项目中的依赖文件
- 🛡️ **安全监控**：监控已知的安全漏洞
- 🔄 **自动更新**：自动创建依赖更新 PR
- 📊 **版本管理**：跟踪依赖版本变化

**解决的问题**：

- ⚠️ **依赖过时**：项目依赖版本过时，存在安全风险
- ⚠️ **安全漏洞**：依赖包存在已知安全漏洞
- ⚠️ **手动维护**：需要手动检查和更新依赖
- ⚠️ **版本冲突**：依赖版本冲突导致构建失败

**Dependabot 配置**：`.github/dependabot.yml`

```yaml
version: 2
updates:
  # Python 依赖更新（基于 requirements.in）
  - package-ecosystem: 'pip'
    directory: '/'
    schedule:
      interval: 'weekly'
    open-pull-requests-limit: 10
    assignees:
      - 'itheima'
    commit-message:
      prefix: 'chore'
      include: 'scope'
    labels:
      - 'dependencies'
      - 'python'
    # 只更新 requirements.in，避免与 pip-tools 冲突
    ignore:
      - dependency-name: '*'
        update-types: ['version-update:semver-patch']

  # GitHub Actions 更新
  - package-ecosystem: 'github-actions'
    directory: '/'
    schedule:
      interval: 'weekly'
    open-pull-requests-limit: 5
    commit-message:
      prefix: 'chore'
      include: 'scope'
    labels:
      - 'dependencies'
      - 'github-actions'

  # npm 依赖更新（用于前端工具）
  - package-ecosystem: 'npm'
    directory: '/'
    schedule:
      interval: 'weekly'
    open-pull-requests-limit: 5
    commit-message:
      prefix: 'chore'
      include: 'scope'
    labels:
      - 'dependencies'
      - 'npm'
```

**依赖更新工作流程**：

**Python 依赖更新**：

1. Dependabot 创建 PR 更新 `requirements.in`
2. 合并 PR 后手动运行：

   ```bash
   pip-compile requirements.in
   pip-compile requirements-dev.in
   ```

3. 提交生成的 `requirements.txt` 文件

**前端依赖更新**：

1. Dependabot 创建 PR 更新 `package.json`
2. 合并 PR 后手动运行：

   ```bash
   pnpm install
   ```

3. 提交更新的 `pnpm-lock.yaml` 文件

**预期效果**：

- ✅ 自动保持依赖的最新性和安全性
- ✅ 减少手动维护依赖的工作量
- ✅ 及时发现和修复安全漏洞
- ✅ 支持依赖更新的自动化管理
- ✅ 避免与 `pip-tools` 和 `pnpm` 的冲突

---

> **一句话总结**：通过 GitHub 平台的高级功能配置，实现了企业级的代码管理、质量保证和团队协作机制。更多最佳实践请参考 [最佳实践指南](./004-best-practices.md)。
