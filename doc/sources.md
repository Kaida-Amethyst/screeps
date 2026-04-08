# 文档与信息源优先级

本文档记录正式版 Screeps Arena binding 的主信息源、优先级与使用约定。

## 主信息源优先级

### 1. `~/ScreepsArena/tutorial/typings`

这是签名真相。

用于确认：

- 函数参数
- 返回值形状
- 类与对象关系
- 可选字段
- 模块路径

### 2. `refs/arena-docs/*.md`

这是语义真相。

用于确认：

- API 的真实含义
- 行为描述
- 错误码语义
- 示例代码
- arena 模式差异

### 3. 本地运行时实测

这是行为兜底。

用于确认：

- 文档和 typings 没写清的地方
- MoonBit FFI 是否真的可行
- Screeps runtime 的实际限制
- wrapper 是否需要补 host glue

### 4. 项目内设计文档

包括：

- [EXPLORATION.md](../EXPLORATION.md)
- `doc/*.md`

这是项目内约束与设计结论来源。

用于统一：

- 命名
- 分层
- trait 设计
- wrapper 边界
- 阶段范围

## 低优先级信息源

- 经典 Screeps 中文文档
- `screeps/docs`

这些材料可以作为背景资料阅读，但不作为 Screeps Arena binding 的主依据。

## 给 AI 工程师的使用约定

- 生成 `raw` 时，优先读取 `typings`
- 理解语义、补文档、补注释时，优先读取 `refs/arena-docs/*.md`
- 设计 `api`、trait、typed view 时，必须同时参考：
  - `typings`
  - `doc/*.md`
  - [EXPLORATION.md](../EXPLORATION.md)
- 不要把原始 `index.html` 当主输入
- 不要直接使用未整理的原始大文档作为主要提示材料
- 不要用经典 Screeps MMO 文档去推断 Arena API

## 当前结论

正式版 binding 的主规范顺序固定为：

1. `typings`
2. `refs/arena-docs/*.md`
3. 本地实测
4. 项目内设计文档

这套顺序同时适用于人工开发和 AI 协作开发。
