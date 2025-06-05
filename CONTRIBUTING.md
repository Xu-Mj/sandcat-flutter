# 贡献指南

感谢你考虑为IM Flutter项目做出贡献！以下是一些指南，帮助你顺利地参与到项目开发中。

## 开发环境设置

1. 确保你已安装以下工具:
   - Flutter SDK (最新稳定版)
   - Dart SDK (与Flutter SDK捆绑)
   - VS Code, Android Studio或IntelliJ IDEA
   - Git

2. 安装推荐的IDE插件:
   - Flutter扩展
   - Dart扩展
   - Flutter Intl (用于国际化)
   - Bloc (用于BLoC模式开发)

3. 克隆项目并安装依赖:
```bash
git clone https://github.com/yourusername/im-flutter.git
cd im-flutter
flutter pub get
```

## 分支策略

- `main`: 主分支，包含稳定版本的代码
- `develop`: 开发分支，包含最新的开发代码
- `feature/*`: 功能分支，用于开发新功能
- `bugfix/*`: 修复分支，用于修复bug
- `release/*`: 发布分支，用于准备新版本

开发新功能或修复bug时，请从`develop`分支创建新的分支。

## 代码风格

我们使用Flutter/Dart官方推荐的代码风格:

- 使用`flutter analyze`检查代码风格
- 遵循[Effective Dart](https://dart.dev/guides/language/effective-dart)指南
- 使用两个空格缩进
- 每行最大长度80字符
- 使用尾逗号改善格式化

## 提交规范

提交信息应遵循以下格式:

```
<类型>(<范围>): <描述>

[可选正文]

[可选页脚]
```

类型可以是:

- **feat**: 新功能
- **fix**: Bug修复
- **docs**: 文档更改
- **style**: 不影响代码含义的更改(空格、格式化等)
- **refactor**: 既不修复bug也不添加功能的代码更改
- **perf**: 改进性能的代码更改
- **test**: 添加测试
- **chore**: 对构建过程或辅助工具的更改

例如:
```
feat(auth): 添加第三方登录功能

添加Google和GitHub OAuth登录选项。

Closes #123
```

## 提交PR的步骤

1. 确保你的分支是最新的:
```bash
git checkout develop
git pull
git checkout -b feature/your-feature
```

2. 进行更改并提交

3. 推送到你的分叉仓库:
```bash
git push origin feature/your-feature
```

4. 在GitHub上创建Pull Request，填写模板中的信息

5. 等待代码审查和CI检查

## 代码审查

所有代码都需要经过审查。审查者将关注:

- 代码质量和风格
- 测试覆盖率
- 文档完整性
- 性能影响
- 新增依赖的必要性

## 测试指南

- 为所有新功能编写测试
- 确保所有测试通过(`flutter test`)
- 尽可能实现高测试覆盖率

## 文档

- 更新相关文档以反映你的更改
- 为公共API添加文档注释
- 考虑是否需要更新README或用户文档

## 问题和讨论

- 使用GitHub Issues报告bug或提出功能请求
- 使用Discussions进行一般讨论和问题

再次感谢你的贡献！ 