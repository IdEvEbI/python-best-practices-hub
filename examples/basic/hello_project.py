"""
Python 企业级开发者养成计划 - 基础示例

这个文件展示了项目的基本 Python 代码结构，用于 CI/CD 测试。
"""


def hello_world() -> str:
    """返回欢迎信息"""
    return "欢迎来到 Python 企业级开发者养成计划！"


def get_project_info() -> dict:
    """获取项目基本信息"""
    return {
        "name": "python-best-practices-hub",
        "version": "1.0.0",
        "description": "Python 企业级开发者养成计划",
        "python_version": "3.12+",
    }


if __name__ == "__main__":
    print(hello_world())
    info = get_project_info()
    print(f"项目：{info['name']} v{info['version']}")
    print(f"描述：{info['description']}")
    print(f"Python 版本要求：{info['python_version']}")
