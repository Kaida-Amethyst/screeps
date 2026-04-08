# 总体分层

本文档记录正式版 Screeps Arena binding 的总体分层与各层职责。

## 当前结论

正式版 binding 在**物理目录结构**上采用三层：

- `raw`
- `screeps` 高层包
- `wrapper`

其中：

- `raw` 仍然独立成 package
- `wrapper` 仍然由根目录 `main.mjs` 承担
- 原先讨论中的 `model / api`，现在保留为**高层包内部的逻辑分工**
- 不再把 `model` 和 `api` 拆成两个独立 package

## 各层职责

### `raw`

职责：

- 只做忠实 FFI
- 尽量贴近 JS / Arena 原始 API
- 暴露原始 extern type、原始方法、原始错误码、原始常量

不负责：

- MoonBit 风格抽象
- 业务策略
- 过度包装

关键原则：

- `raw` 的目标是“正确映射”，不是“好用”

### 高层包中的 `model` 关注点

职责：

- 把 JS live object 包装成 MoonBit wrapper
- 承载对象语义
- 提供 live getter、轻量构造、typed view 转换

不负责：

- bot 策略
- 复杂便捷 helper

关键原则：

- `model` 的目标是“对象是什么”

### 高层包中的 `api` 关注点

职责：

- 提供更 MoonBit 风格的接口
- 放 trait、ADT、结果类型、统一命名、便捷查询
- 尽量让 bot 层不直接碰 raw 风格接口

不负责：

- JS 宿主 glue
- 直播专用脚本逻辑

关键原则：

- `api` 的目标是“怎么好用地用”

### `wrapper`

职责：

- 保留 `main.mjs`
- 负责 MoonBit 暂时不擅长的 host glue
- 处理 class token、特殊 JS glue、运行时桥接

不负责：

- bot 业务逻辑
- MoonBit 内部对象建模

关键原则：

- `wrapper` 是正式架构的一部分，不视为临时脏补丁

## 为什么不再把 `model / api` 拆成两个 package

新的结论来自实际编码时遇到的约束：

- MoonBit 不能在一个 package 中为另一个 package 里的类型追加方法
- 如果 `model` 和 `api` 拆成两个独立 package，高层 API 很容易被迫退化成顶层函数
- 这会直接损害正式版最关心的体验：
  - 对象方法的自然写法
  - API 可读性
  - 直播演示效果

因此当前项目改为：

- package 层面合并 `model + api`
- 文件层面继续区分“对象建模”和“高层接口”职责

## 各层关系

- `raw` 负责“怎么连上”
- 高层包内部的 `model` 关注点负责“对象是什么”
- 高层包内部的 `api` 关注点负责“怎么好用地用”
- `wrapper` 负责宿主适配
- `main/`、tutorial 代码、bot 代码属于 binding 的使用方，不属于 binding 本体

## 目录方向

当前建议目录方向：

- `raw/`
- 根目录高层 `.mbt` 文件
- 根目录 `main.mjs`

高层文件在逻辑上继续分工，例如：

- `game_object.mbt`
- `creep.mbt`
- `spawn.mbt`
- `store.mbt`
- `traits.mbt`
- `queries.mbt`
- `errors.mbt`

## 当前原则

- `raw` 独立
- `wrapper` 独立
- 高层 MoonBit API 合并在同一个 package 中
- 仍然保留 `model / api` 的逻辑边界，但不再为此承受额外 package 边界成本
