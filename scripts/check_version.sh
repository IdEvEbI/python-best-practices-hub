#!/bin/bash
# 查询包的最新版本并生成 requirements.in 格式
# 使用方法：./scripts/check_version.sh package-name
#
# 功能：
# - 查询指定包的所有可用版本
# - 显示最新版本信息
# - 生成建议的 requirements.in 格式
# - 支持错误处理和用户友好的输出

set -euo pipefail

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 显示帮助信息
show_help() {
    echo "用法: $0 <package-name>"
    echo ""
    echo "查询 Python 包的最新版本并生成 requirements.in 格式"
    echo ""
    echo "参数:"
    echo "  package-name    要查询的包名"
    echo ""
    echo "示例:"
    echo "  $0 ruff"
    echo "  $0 pytest"
    echo "  $0 django"
    echo ""
    echo "输出:"
    echo "  - 显示包的所有可用版本"
    echo "  - 高亮显示最新版本"
    echo "  - 生成建议的 requirements.in 格式"
}

# 检查参数
if [ $# -eq 0 ]; then
    echo -e "${RED}错误: 缺少包名参数${NC}"
    echo ""
    show_help
    exit 1
fi

if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    show_help
    exit 0
fi

PACKAGE_NAME="$1"

# 检查是否在虚拟环境中
if [ -z "${VIRTUAL_ENV:-}" ]; then
    echo -e "${YELLOW}警告: 建议在虚拟环境中运行此脚本${NC}"
    echo ""
fi

echo -e "${BLUE}查询 $PACKAGE_NAME 的版本信息...${NC}"
echo ""

# 查询包版本信息
if ! pip index versions "$PACKAGE_NAME" > /dev/null 2>&1; then
    echo -e "${RED}错误: 包 '$PACKAGE_NAME' 不存在或无法访问${NC}"
    echo ""
    echo "可能的原因:"
    echo "  - 包名拼写错误"
    echo "  - 网络连接问题"
    echo "  - PyPI 服务不可用"
    echo ""
    echo "请检查包名或网络连接后重试"
    exit 1
fi

# 获取版本信息
VERSION_INFO=$(pip index versions "$PACKAGE_NAME")
# 使用兼容 ERE 的正则表达式匹配版本格式
LATEST_VERSION=$(echo "$VERSION_INFO" | head -1 | grep -oE '[0-9]+(\.[0-9]+)*([a-zA-Z][a-zA-Z0-9\-\.]*)?' | head -1)

if [ -z "$LATEST_VERSION" ]; then
    echo -e "${RED}错误: 无法解析最新版本号${NC}"
    exit 1
fi

# 显示版本信息
echo -e "${GREEN}最新版本: $PACKAGE_NAME ($LATEST_VERSION)${NC}"
echo ""

# 显示所有可用版本（限制显示数量）
echo "可用版本 (最近 20 个):"
echo "$VERSION_INFO" | head -20 | sed 's/^/  /'
echo ""

# 生成建议的 requirements.in 格式
echo -e "${BLUE}建议的 requirements.in 格式:${NC}"
echo -e "${GREEN}$PACKAGE_NAME>=$LATEST_VERSION${NC}"
echo ""

# 提供其他版本约束选项
echo "其他版本约束选项:"
echo "  $PACKAGE_NAME~=$LATEST_VERSION  # 兼容版本 (推荐用于生产环境)"
echo "  $PACKAGE_NAME==$LATEST_VERSION  # 精确版本 (不推荐)"
echo "  $PACKAGE_NAME                   # 最新版本 (开发环境)"
echo ""

# 显示使用建议
echo -e "${YELLOW}使用建议:${NC}"
echo "  1. 将建议的格式添加到 requirements.in 或 requirements-dev.in"
echo "  2. 运行 'pip-compile requirements.in' 生成 requirements.txt"
echo "  3. 运行 'pip-sync requirements.txt' 安装依赖"
