# 社区贡献指南

[English](guideline.md) | [日本語](guideline.ja.md)

## 帮助我们扩展 npm_typed

就像 [DefinitelyTyped](https://github.com/DefinitelyTyped/DefinitelyTyped) 为 npm 包提供 TypeScript 类型定义一样，本项目旨在为 npm 生态系统提供 MoonBit FFI 绑定。

我们欢迎社区贡献！无论您是想为喜爱的 npm 包添加绑定，还是改进现有绑定，本指南都能帮助您入门。

## 谁可以贡献？

**不需要深入的 MoonBit 专业知识！** 只要您具备：

- 基本的 JavaScript/TypeScript 知识
- 能够参考代码库中的现有模式
- 愿意阅读 [MoonBit JS FFI 指南](https://www.moonbitlang.com/pearls/moonbit-jsffi)

...您就可以贡献！

## 开始使用

使用模板生成器创建新库：

```bash
./_scripts/new-library.sh <package_name> [npm_package_name]

# 示例
./_scripts/new-library.sh react
./_scripts/new-library.sh client_s3 @aws-sdk/client-s3
```

这将创建基本的文件结构。详细的设置说明请参阅 [CONTRIBUTING.md](../CONTRIBUTING.md)。

## 使用 AI 辅助

我们**鼓励使用 AI 工具**（Claude、GPT、Copilot 等）作为创建绑定的结对程序员。本仓库中的大多数绑定都是在 AI 辅助下生成的。

**AI 辅助开发技巧：**

1. 向 AI 提供 npm 包的文档
2. 分享本仓库中的现有绑定示例作为模式（例如：[react/react.mbt](../react/react.mbt)）
3. 让 AI 生成 `.mbt` 文件、测试和 README
4. 使用 [MoonBit 速查表](../_examples/moonbit_cheatsheet.mbt.md)作为语法参考

**示例提示词：**

```
我想为 npm 包"react"创建 MoonBit FFI 绑定。
这是现有绑定的模式：[从仓库粘贴示例]
请生成：
1. react.mbt - createElement、useState、useEffect 的 FFI 绑定
2. react_test.mbt - 测试
3. README.mbt.md - 包含可执行示例的文档
```

## 必须人工审查

AI 生成的代码在合并前必须经过人工审查和验证：

- 运行所有测试（`moon test --target js`）
- 验证绑定按预期工作
- 检查类型安全性和边缘情况
- 确保 README 示例准确无误

**所有 PR 都将由维护者审查以确保质量。**

## 如何请求新库

1. **检查现有 Issue** 是否有重复请求
2. 使用 `library-request` 标签**创建 Issue**
3. 包含以下内容：
   - npm 包名称
   - 文档链接
   - 您最需要的 API
   - （可选）TypeScript 使用示例

## 如何贡献新库

1. 在现有 Issue 上评论或创建新 Issue 以避免重复工作
2. 运行 `./_scripts/new-library.sh <package_name>` 生成模板文件
3. 按照现有模式实现绑定
4. 提交包含绑定的 PR
5. 回应审查反馈

## 质量指南

**好的绑定应该：**

- 覆盖最常用的 API
- 在 README.mbt.md 中有清晰、可运行的示例
- 测试验证绑定正常工作
- 类型签名尽可能具体（能定义适当类型时避免使用 `@core.Any`）

**可接受的范围：**

- 不需要覆盖 npm 包 100% 的 API
- 从最有用的 20% 函数开始
- 如果未完全测试，标记为"AI Generated"
- 其他人可以在后续 PR 中扩展覆盖范围

## PR 检查清单

提交 PR 前请确认：

- [ ] `moon test --target js` 通过
- [ ] 已运行 `moon fmt`
- [ ] README.mbt.md 包含可工作的示例
- [ ] 测试覆盖主要用例
- [ ] 没有硬编码的密钥或凭证

## 获取帮助

- **有问题？** 发起 [Discussion](https://github.com/mizchi/npm_typed/discussions)
- **发现 bug？** 创建 [Issue](https://github.com/mizchi/npm_typed/issues)
- **MoonBit 语法？** 参阅[速查表](../_examples/moonbit_cheatsheet.mbt.md)

## 资源

- [MoonBit JS FFI 最佳实践](https://www.moonbitlang.com/pearls/moonbit-jsffi)
- [MoonBit 文档](https://www.moonbitlang.com/docs/)
