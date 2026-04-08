# 项目 AGENTS.md 指南

这是一个 [MoonBit](https://docs.moonbitlang.com) 项目。

额外技能可以在这里浏览和安装：
<https://github.com/moonbitlang/skills>

## 语言约定

- 本目录下的文档、注释、开发说明统一使用中文。
- 代码中的标识符、模块名、第三方 API 名称保持原始技术命名，不强行翻译。

## 正式版 Binding 开发约定

- 正式版 Screeps Arena binding 开发时，先遵守 `doc/` 中已定设计，再生成代码；如果设计未定，不要擅自发明 API。

- 信息源优先级固定为：
  1. `~/ScreepsArena/tutorial/typings`
  2. `refs/arena-docs/*.md`
  3. `doc/*.md`
  4. `EXPLORATION.md`

- 如果 `doc/*.md` 与 `EXPLORATION.md` 冲突，以 `doc/*.md` 为准。

- 正式版 binding 在物理结构上采用 `raw / 高层包 / wrapper` 三层：
  - `raw`：只做忠实 FFI，不放高层语义。
  - 高层包：承载 wrapper、typed view、trait、enum、错误映射、查询接口和高层方法。
  - `wrapper`：只做宿主 glue，不放 bot 逻辑和游戏语义。
  - 其中 `model / api` 仍然保留为高层包内部的逻辑分工，不再拆成独立 package。

- AI 可以大量生成 `raw` 层代码，但不能自由设计 public API。

- `model` 和 `api` 的改动必须遵守 `doc/` 中已定结论，不要自行扩张抽象边界。

- 不要把 tutorial helper、bot helper 放进 binding 核心层。

- 不要为了省事绕过 enum、typed view 或 trait 设计，直接把 `String` 或低层语义暴露到 `api`。

- 查询正式命名优先使用 `my_* / enemy_*`，与 Screeps 原始 API 保持一致。

- 查询类“不存在”使用 `Option`。

- 普通动作失败统一使用 `ActionResult`，不再把原始错误码直接暴露为高层主接口。

- `api` 层优先使用 `BodyPartKind`、`ResourceKind` 等高层类型，不继续以原始字符串常量作为正式接口。

- 距离查询正式接口统一走 MoonBit 风格命名，例如 `find_closest(..., by~=Path)`，不要继续直接扩张 JS 风格平行命名。

- 任何影响 public API、命名、trait、分层的改动，先更新对应 `doc/*.md`，再改代码。

- 如果只是按既有设计补实现，可以直接改代码；如果实现过程中发现设计不够，需要先回写设计文档再继续。

- 不要在未更新设计文档的情况下擅自扩张 `main.mjs` wrapper 的职责。

- 当前测试能力有限，必须接受 naive 验证方式，不要假装拥有完整的 Screeps runtime 自动化测试体系。

- 改动 MoonBit 代码后，至少运行：
  - `moon check`
  - `moon info`
  - `moon fmt`
  - `moon test`
  - `moon build`

- 涉及 wrapper 或集成链路的改动，需要额外说明是否需要手工 smoke test。

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
