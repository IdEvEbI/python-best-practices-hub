"""
Python 企业级开发者养成计划 - 基础测试

这个文件包含项目的基础测试用例，用于 CI/CD 验证。
"""

import pytest

from examples.basic.hello_project import get_project_info, hello_world


class TestHelloProject:
    """测试 hello_project.py 模块的基本功能"""

    def test_hello_world(self) -> None:
        """测试 hello_world 函数"""
        result = hello_world()
        assert isinstance(result, str)
        assert "Python 企业级开发者养成计划" in result
        assert len(result) > 0

    def test_get_project_info(self) -> None:
        """测试 get_project_info 函数"""
        info = get_project_info()
        assert isinstance(info, dict)
        assert "name" in info
        assert "version" in info
        assert "description" in info
        assert "python_version" in info
        assert info["name"] == "python-best-practices-hub"
        assert info["version"] == "1.0.0"

    def test_project_info_structure(self) -> None:
        """测试项目信息结构完整性"""
        info = get_project_info()
        required_keys = ["name", "version", "description", "python_version"]
        for key in required_keys:
            assert key in info, f"Missing required key: {key}"
            assert info[key] is not None, f"Key {key} should not be None"
            assert len(str(info[key])) > 0, f"Key {key} should not be empty"


class TestProjectStructure:
    """测试项目结构完整性"""

    def test_hello_world_return_type(self) -> None:
        """测试 hello_world 返回类型"""
        result = hello_world()
        assert isinstance(result, str)

    def test_project_info_return_type(self) -> None:
        """测试 get_project_info 返回类型"""
        result = get_project_info()
        assert isinstance(result, dict)

    def test_python_version_format(self) -> None:
        """测试 Python 版本格式"""
        info = get_project_info()
        python_version = info["python_version"]
        assert isinstance(python_version, str)
        assert "3.12" in python_version


if __name__ == "__main__":
    # 运行测试
    pytest.main([__file__, "-v"])
