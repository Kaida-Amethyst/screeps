# wrapper 与 FFI 边界

本文档记录 Screeps Arena 正式版 binding 中，`main.mjs` wrapper 与 MoonBit 各层之间的职责边界。

## 总体结论

- wrapper 只负责“MoonBit 目前不擅长稳定表达的宿主问题”
- wrapper 不负责游戏语义
- wrapper 是正式架构的一部分，不是临时脏补丁

## wrapper 负责什么

当前结论：

- 作为最终 Screeps 入口，导出 `loop`
- 静态导入 Screeps 的 ESM 模块
- 处理 MoonBit 目前不稳定的值形态
  - class token
  - prototype token
  - 必要的 host glue
- 向 `globalThis` 注入一小组稳定 helper
- 做极少量一次性初始化

## wrapper 不负责什么

以下内容不应放进 wrapper：

- bot 策略
- world 语义查询
  - 例如 `my_creeps()`、`enemy_towers()`
- 错误码到 `ActionResult` 的映射
- typed view 转换
- tutorial helper
- 每 tick 的游戏状态缓存

一句话：

- wrapper 不解释游戏世界
- wrapper 只桥接宿主能力

## MoonBit 负责什么

MoonBit 侧继续负责：

- `raw`：对接 host helper 和官方 JS API
- `model`：对象 wrapper、typed view、`Relation`
- `api`：trait、错误映射、枚举、MoonBit 风格接口
- bot 逻辑、决策逻辑、状态机

这些都不应迁移到 wrapper：

- `my_creeps()`
- `enemy_spawns()`
- `BodyPartKind`
- `ActionResult`
- `MyCreep::harvest`
- `find_closest(..., by~=Path)`

## wrapper 中应统一解决的问题类型

wrapper 应尽量解决“一类问题”，而不是不断堆积零散补丁。

不推荐持续增加这类单点 helper：

- `__moonbit_create_tower_site`
- `__moonbit_get_creeps`
- `__moonbit_get_flags`

更推荐统一成一个宿主命名空间，例如：

```javascript
globalThis.__moonbit_screeps_host = {
  getObjectsByPrototypeName(name) { ... },
  createConstructionSiteByPrototypeName(pos, name) { ... },
}
```

这样 wrapper 处理的是：

- 如何通过 prototype name 找到 class token
- 如何通过 prototype name 调用需要 class token 的 API

而不是为每个 tutorial 场景单独打洞。

## 边界上传什么，不传什么

### 尽量跨边界传递

- `Int`
- `Bool`
- `String`
- 普通数组
- 简单位置对象 `{ x, y }`
- JS 实例对象句柄（extern type）

### 尽量不要跨边界传递

- class constructor 本身
- prototype token 本身
- 回调函数
- 高层语义对象
- 已经 MoonBit 化的错误模型

换句话说：

- `JsCreep` 可以跨边界
- `StructureTower` class token 尽量不要直接跨边界
- `ActionResult` 绝不在 wrapper 中构造

## 当前项目的正式约定

当前建议将 wrapper 的职责收敛为：

- `main.mjs` 负责最终 `loop`
- `globalThis.__moonbit_screeps_host` 负责少量通用宿主 helper

第一批 helper 建议优先只做两类：

- `getObjectsByPrototypeName(name)`
- `createConstructionSiteByPrototypeName(pos, name)`

后续如有新问题，按“问题类别”补 helper，而不是按 tutorial 补 helper。

## 当前结论

- `wrapper`：宿主适配层
- `raw`：JS 互操作层
- `model`：对象语义层
- `api`：MoonBit 风格公共接口层

最终边界应保持：

- wrapper 解决“能不能连上”
- MoonBit 解决“接口怎么设计得像 MoonBit”
