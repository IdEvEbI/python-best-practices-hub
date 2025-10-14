# Python 工具链文档索引

> 基于 Python 高级开发工程师+架构师+高级文档工程师的专业视角，为企业级 Python 项目提供完整的工具链解决方案。

## 1. 工具链概览

本项目提供了 **5 个完整的工具链**，涵盖从开发环境到生产部署的全流程：

| 工具链类别      | 文档数量      | 状态        |
| --------------- | ------------- | ----------- |
| **Git DevOps**  | 4 个文档      | ✅ 完成     |
| **Python 工具** | 10 个文档     | ✅ 完成     |
| **文档工具**    | 3 个文档      | ✅ 完成     |
| **集成工具**    | 1 个文档      | ✅ 完成     |
| **构建工具**    | 1 个文档      | ✅ 完成     |
| **总计**        | **19 个文档** | ✅ **完成** |

## 2. 工具链目录结构

### 2.1 Git DevOps 工具链

**路径**: `docs/00-toolchain/01-git-devops/`

基于 Git Flow 分支模型，通过严格的分支保护、规范的提交消息和自动化 CI/CD，确保代码质量和团队协作的高效性。

| 文档                                                  | 内容                                   | 适用场景           |
| ----------------------------------------------------- | -------------------------------------- | ------------------ |
| [分支策略](./01-git-devops/001-branch-strategy.md)    | Git Flow 模型、分支保护机制            | 了解分支管理策略   |
| [工作流程指南](./01-git-devops/002-workflow-guide.md) | 功能开发、版本发布、紧急修复流程       | 日常开发操作       |
| [GitHub 配置](./01-git-devops/003-github-config.md)   | 分支保护、模板、Actions、Dependabot    | 平台配置和集成     |
| [最佳实践](./01-git-devops/004-best-practices.md)     | 提交规范、命名规范、代码审查、故障排除 | 团队规范和问题解决 |

### 2.2 Python 工具链

**路径**: `docs/00-toolchain/02-python-tools/`

现代 Python 开发的核心工具集，从环境管理到代码质量的全方位保障。

#### 2.2.1 基础环境（必须掌握）

| 文档                                                      | 核心功能           |
| --------------------------------------------------------- | ------------------ |
| [虚拟环境](./02-python-tools/001-virtual-environment.md)  | 环境隔离、依赖管理 |
| [pip-tools](./02-python-tools/002-pip-tools.md)           | 依赖锁定、环境同步 |
| [pyproject.toml](./02-python-tools/003-pyproject-toml.md) | 统一配置中心       |

#### 2.2.2 代码质量（核心工具）

| 文档                                         | 核心功能         |
| -------------------------------------------- | ---------------- |
| [Ruff](./02-python-tools/004-ruff-config.md) | 代码检查、格式化 |
| [MyPy](./02-python-tools/005-mypy-config.md) | 静态类型检查     |
| [Pytest](./02-python-tools/006-pytest.md)    | 测试框架         |

#### 2.2.3 安全与质量（重要工具）

| 文档                                      | 核心功能     |
| ----------------------------------------- | ------------ |
| [Bandit](./02-python-tools/007-bandit.md) | 安全漏洞检查 |
| [Safety](./02-python-tools/008-safety.md) | 依赖安全扫描 |

#### 2.2.4 代码分析（高级工具）

| 文档                                        | 核心功能       |
| ------------------------------------------- | -------------- |
| [Radon](./02-python-tools/009-radon.md)     | 代码复杂度分析 |
| [Vulture](./02-python-tools/010-vulture.md) | 死代码检测     |

### 2.3 文档工具链

**路径**: `docs/00-toolchain/03-document-tools/`

确保项目文档质量和格式一致性的工具集。

| 文档                                                    | 核心功能              |
| ------------------------------------------------------- | --------------------- |
| [Markdownlint](./03-document-tools/001-markdownlint.md) | Markdown 文档质量检查 |
| [Yamllint](./03-document-tools/002-yamllint.md)         | YAML 配置文件检查     |
| [Prettier](./03-document-tools/003-prettier.md)         | 文档格式化工具        |

### 2.4 集成工具

**路径**: `docs/00-toolchain/04-integration-tools/`

将各个工具链整合到开发工作流程中的关键工具。

| 文档                                                   | 核心功能       |
| ------------------------------------------------------ | -------------- |
| [Pre-commit](./04-integration-tools/001-pre-commit.md) | 提交前检查集成 |

### 2.5 构建工具

**路径**: `docs/00-toolchain/05-build-tools/`

提供跨语言构建管理和自动化任务执行。

| 文档                                         | 核心功能       |
| -------------------------------------------- | -------------- |
| [Makefile](./05-build-tools/001-makefile.md) | 跨语言构建管理 |

## 3. 快速开始

### 3.1 新团队成员学习路径

1. **环境搭建** → [虚拟环境](./02-python-tools/001-virtual-environment.md) + [pip-tools](./02-python-tools/002-pip-tools.md)
2. **项目配置** → [pyproject.toml](./02-python-tools/003-pyproject-toml.md)
3. **代码质量** → [Ruff](./02-python-tools/004-ruff-config.md) + [MyPy](./02-python-tools/005-mypy-config.md)
4. **测试开发** → [Pytest](./02-python-tools/006-pytest.md)
5. **安全检查** → [Bandit](./02-python-tools/007-bandit.md) + [Safety](./02-python-tools/008-safety.md)
6. **工作流集成** → [Pre-commit](./04-integration-tools/001-pre-commit.md)
7. **构建自动化** → [Makefile](./05-build-tools/001-makefile.md)

### 3.2 常用命令

```bash
# 环境管理
make setup          # 初始化项目环境
make install        # 安装依赖

# 代码质量
make check          # 运行代码检查
make format         # 格式化代码
make test           # 运行测试

# 安全检查
make security       # 运行安全检查
make quality        # 运行代码质量分析

# 文档处理
make markdown       # 格式化 Markdown 文件

# 完整检查
make all            # 运行所有检查
make ci             # CI/CD 检查
make dev            # 开发环境检查
```

---

> **一句话总结**：通过 5 个工具链类别、19 个专业文档，为企业级 Python 项目提供从环境管理到生产部署的完整工具链解决方案，确保代码质量、团队协作和项目维护的高效性。
