# Python 项目工具链 Makefile

.PHONY: help install check format test clean setup security quality docs ci dev frontend-setup frontend-check markdown fix update all

help: ## 显示帮助信息
	@echo "可用的命令："
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'

setup: ## 初始化项目环境
	python -m venv venv
	@echo "请运行: source venv/bin/activate && make install"

install: ## 安装依赖
	pip install --upgrade pip
	pip install pip-tools
	pip-compile requirements.in
	pip-compile requirements-dev.in
	pip-sync requirements.txt requirements-dev.txt
	pre-commit install

check: ## 运行代码检查
	ruff check .
	mypy .

format: ## 格式化代码
	ruff format .

fix: ## 自动修复代码问题
	ruff check --fix .

test: ## 运行测试
	pytest

security: ## 运行安全检查
	bandit -r . --exclude ./venv --exclude ./.venv --exclude ./node_modules --exclude ./.pytest_cache
	safety scan

quality: ## 运行代码质量分析
	radon cc . --exclude ./venv --exclude ./.venv --exclude ./node_modules --exclude ./.pytest_cache
	radon mi . --exclude ./venv --exclude ./.venv --exclude ./node_modules --exclude ./.pytest_cache
	vulture . --exclude ./venv --exclude ./.venv --exclude ./node_modules --exclude ./.pytest_cache

markdown: ## 格式化 Markdown 文件
	pnpm run format
	pnpm run lint:md:fix

clean: ## 清理临时文件
	find . -type f -name "*.pyc" -delete
	find . -type d -name "__pycache__" -delete
	find . -type d -name ".pytest_cache" -delete

all: check format test security quality ## 运行所有检查

update: ## 更新依赖
	pip-compile --upgrade requirements.in
	pip-compile --upgrade requirements-dev.in
	pip-sync requirements.txt requirements-dev.txt
	pnpm update

frontend-setup: ## 安装前端工具
	pnpm install

frontend-check: ## 检查前端工具
	pnpm run format:check
	pnpm run lint:md

docs: ## 生成文档
	@echo "文档已生成在 docs/ 目录"

ci: ## CI/CD 检查
	ruff check .
	mypy .
	pytest
	bandit -r . --exclude ./venv --exclude ./.venv --exclude ./node_modules --exclude ./.pytest_cache
	safety scan
	pnpm run format:check
	pnpm run lint:md

dev: ## 开发环境检查
	ruff check .
	mypy .
	pytest
	pnpm run format:check
