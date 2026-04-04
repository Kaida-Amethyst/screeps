# 项目 AGENTS.md 指南

这是一个 [MoonBit](https://docs.moonbitlang.com) 项目。

额外技能可以在这里浏览和安装：
<https://github.com/moonbitlang/skills>

## 语言约定

- 本目录下的文档、注释、开发说明统一使用中文。
- 代码中的标识符、模块名、第三方 API 名称保持原始技术命名，不强行翻译。

## 项目结构

- MoonBit 包按目录组织；每个目录包含一个 `moon.pkg` 文件来声明依赖。
  每个包都有自己的源码文件、黑盒测试文件（以 `_test.mbt` 结尾）和白盒测试文件（以 `_wbtest.mbt` 结尾）。

- 顶层目录中有一个 `moon.mod.json` 文件，用于记录模块元数据。

## 编码约定

- MoonBit 代码采用 block 风格组织，每个 block 之间用 `///|` 分隔，各个 block 的先后顺序原则上无关。
  做重构时，可以优先按 block 为单位处理。

- 废弃逻辑尽量收拢到各目录下名为 `deprecated.mbt` 的文件中。

## 工具链

- 使用 `moon fmt` 进行格式化。

- `moon ide` 提供 `peek-def`、`outline`、`find-references` 等项目导航能力。
  详细说明可参考 `$moonbit-agent-guide`。

- `moon info` 用于更新包生成出来的接口文件 `.mbti`。
  `.mbti` 是对包公开接口的简明形式化描述。
  如果 `.mbti` 没有变化，通常说明这次修改没有影响外部可见接口，往往属于较安全的重构。

- 在最后一步，请运行 `moon info && moon fmt` 来更新接口并整理格式。
  同时检查 `.mbti` 的 diff，确认改动是否符合预期。

- 使用 `moon test` 运行测试。
  MoonBit 支持快照测试；如果改动影响输出结果，可以运行 `moon test --update` 更新快照。

- 对稳定或极不容易变化的结果，优先使用 `assert_eq` 或 `assert_true(pattern is Pattern(...))`。
  快照测试更适合记录当前行为。
  对定义明确、结果应当严格稳定的场景，例如科学计算，优先使用断言测试。
  如需检查覆盖率盲区，可以运行 `moon coverage analyze > uncovered.log`。
