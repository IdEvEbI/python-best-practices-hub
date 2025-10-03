# Scripts 目录

本目录包含项目开发过程中使用的实用脚本。

## 脚本列表

### check_version.sh

**用途**：查询 Python 包的最新版本并生成 requirements.in 格式

**功能特性**：

- 🔍 查询指定包的所有可用版本
- 📊 显示最新版本信息
- 🎯 生成建议的 requirements.in 格式
- ⚠️ 支持错误处理和用户友好的输出
- 🎨 彩色输出和清晰的错误信息
- 📖 支持帮助功能 (`--help`)

**使用方法**：

```bash
# 查询包版本
./scripts/check_version.sh <package-name>

# 查看帮助
./scripts/check_version.sh --help

# 示例
./scripts/check_version.sh ruff
./scripts/check_version.sh pytest
```

**输出示例**：

```bash
$ ./scripts/check_version.sh ruff
查询 ruff 的版本信息...

最新版本: ruff (0.13.3)

建议的 requirements.in 格式:
ruff>=0.13.3

其他版本约束选项:
  ruff~=0.13.3  # 兼容版本 (推荐用于生产环境)
  ruff==0.13.3  # 精确版本 (不推荐)
  ruff          # 最新版本 (开发环境)
```

## 脚本开发规范

### 代码质量要求

- ✅ **错误处理**：使用 `set -euo pipefail` 确保脚本健壮性
- ✅ **参数验证**：检查必需参数和提供帮助信息
- ✅ **用户友好**：提供清晰的输出和错误信息
- ✅ **可维护性**：添加注释和文档说明
- ✅ **可移植性**：考虑不同操作系统的兼容性

### 质量检查工具

项目使用以下工具确保脚本质量：

- **ShellCheck**：静态分析工具，检查语法和最佳实践
- **Bash 语法检查**：`bash -n script.sh` 验证语法正确性

**检查命令**：

```bash
# ShellCheck 检查
shellcheck scripts/check_version.sh

# 语法检查
bash -n scripts/check_version.sh
```

### 命名规范

- 脚本文件使用 `.sh` 扩展名
- 文件名使用小写字母和连字符：`check-version.sh`
- 脚本内容使用下划线：`check_version.sh`

### 文档要求

- 每个脚本都需要在 README.md 中说明用途和用法
- 脚本内部包含详细注释
- 提供使用示例和输出示例

## 贡献指南

1. **新增脚本**：在 `scripts/` 目录下创建新脚本
2. **更新文档**：在 `scripts/README.md` 中添加脚本说明
3. **测试验证**：确保脚本在不同环境下正常工作
4. **代码审查**：遵循项目的代码质量标准

## 相关文档

- [pip-tools 配置文档](../docs/00-toolchain/02-python-tools/002-pip-tools.md)
- [虚拟环境配置文档](../docs/00-toolchain/02-python-tools/001-virtual-environment.md)
