# Git DevOps 工具链

> 本目录包含 Git DevOps 相关文档，基于 Git Flow 分支模型，通过严格的分支保护、规范的提交消息和自动化 CI/CD，确保代码质量和团队协作的高效性。

## 1. 文档导航

| 文档                                    | 内容                                   | 适用场景           |
| --------------------------------------- | -------------------------------------- | ------------------ |
| [分支策略](./001-branch-strategy.md)    | Git Flow 模型、分支保护机制            | 了解分支管理策略   |
| [工作流程指南](./002-workflow-guide.md) | 功能开发、版本发布、紧急修复流程       | 日常开发操作       |
| [GitHub 配置](./003-github-config.md)   | 分支保护、模板、Actions、Dependabot    | 平台配置和集成     |
| [最佳实践](./004-best-practices.md)     | 提交规范、命名规范、代码审查、故障排除 | 团队规范和问题解决 |

## 2. 快速开始

### 2.1 新团队成员学习路径

1. **理论学习** → [分支策略](./001-branch-strategy.md)
2. **实践操作** → [工作流程指南](./002-workflow-guide.md)
3. **平台配置** → [GitHub 配置](./003-github-config.md)
4. **规范遵循** → [最佳实践](./004-best-practices.md)

### 2.2 常用操作

**功能开发**：

```bash
git checkout develop && git pull origin develop
git checkout -b feature/your-feature-name
# 开发完成后创建 PR
```

**版本发布**：

```bash
git checkout -b release/v1.0.0
# 发布准备后创建 PR 到 main
```

## 3. 当前状态

| 分支        | 保护级别    | 状态      |
| ----------- | ----------- | --------- |
| `main`      | 🔒 完全保护 | ✅ 已配置 |
| `develop`   | 🔒 完全保护 | ✅ 已配置 |
| `feature/*` | ⚠️ 临时分支 | ✅ 正常   |

---

> **一句话总结**：标准化的 Git DevOps 流程，确保代码质量和团队协作效率。建议按顺序阅读文档，从理论到实践。
