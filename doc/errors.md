# 动作返回值与错误建模

本文档记录正式版 Screeps Arena binding 的动作结果设计。

## 总体结论

- 不再保留 `ActionError`
- 不再把普通动作失败建模成 `raise`
- 第一阶段普通动作统一返回 `ActionResult`
- `raw` 继续保留原始 `Int` 错误码
- `api` 负责把原始错误码转换成 MoonBit 风格 ADT

## 分层职责

### `raw`

`raw` 忠实保留 JS 返回值：

- 原始 `Int` 错误码
- 原始 `{ object?, error? }` 结果对象

`raw` 不负责高层语义整理。

### `api`

`api` 负责：

- 把普通动作的原始错误码映射成 `ActionResult`
- 为对象创建类动作设计更合适的高层结果类型

## 核心结果类型

第一阶段正式采用：

```moonbit
pub enum ActionFailure {
  NotOwner
  Busy
  NotEnoughEnergy
  InvalidTarget
  Full
  NotInRange
  InvalidArgs
  Tired
  NoBodyPart
  UnknownRawError(Int)
}

pub enum ActionResult {
  Success
  Failed(ActionFailure)
}
```

设计意图是：

- 让 Screeps 中“本 tick 动作结果”直接成为一等值
- 让 `NotInRange` 这类高频结果自然参与模式匹配
- 避免把正常控制流伪装成异常处理

## 正式 API 风格

普通动作方法默认采用：

- 返回 `ActionResult`
- 不使用 `raise`

例如：

```moonbit
pub fn MyCreep::harvest(self, target : Source) -> ActionResult
pub fn MyCreep::attack(self, target : EnemyCreep) -> ActionResult
pub fn MyCreep::move_to[T : MoveTarget](self, target : T) -> ActionResult
pub fn MyCreep::transfer(
  self,
  target : TransferTarget,
  resource : ResourceKind,
) -> ActionResult
```

这样调用侧可以直接写：

```moonbit
match creep.harvest(source) {
  Success => ()
  Failed(NotInRange) => ignore(creep.move_to(source))
  _ => ()
}
```

## 为什么不用 `raise`

在 Screeps 里，很多动作失败并不代表异常，而是代表：

- 目标不在范围内
- 本 tick 能量不足
- 当前对象状态不满足执行条件

这些都更像“动作结果”，不是“程序异常”。

因此：

- `NotInRange`
- `NotEnoughEnergy`
- `Tired`
- `InvalidTarget`

都应优先被看作正常控制流分支。

## 查询类接口的处理原则

“没找到对象”仍然使用 `Option`，例如：

- `find_closest(...) -> T?`
- `object_by_id(...) -> GameObject?`

也就是说：

- 查询不到：`Option`
- 普通动作结果：`ActionResult`

## 对象创建类动作

当前结论主要覆盖普通动作：

- `move_to`
- `harvest`
- `attack`
- `ranged_attack`
- `heal`
- `transfer`
- `withdraw`
- `build`

对于以下动作：

- `spawn_creep`
- `create_construction_site`

仍建议保留专门结果类型，而不是硬塞进 `ActionResult`。因为它们成功时往往需要返回对象。

正式版当前建议为对象创建类动作提供更窄的失败类型，例如：

```moonbit
pub(all) enum SpawnFailure {
  SpawnNotOwner
  SpawnBusy
  SpawnNotEnoughEnergy
  SpawnInvalidArgs
  SpawnUnknownRawError(Int)
}

pub(all) enum SpawnResult {
  Spawned(MyCreep)
  SpawnFailed(SpawnFailure)
}

pub(all) enum CreateConstructionSiteFailure {
  CreateInvalidArgs
  CreateInvalidTarget
  CreateFull
  CreateUnknownRawError(Int)
}

pub(all) enum CreateConstructionSiteResult {
  Created(ConstructionSite)
  CreateFailed(CreateConstructionSiteFailure)
}
```

## wrapper / FFI 异常

wrapper、FFI 或宿主环境异常，不应混入 `ActionResult`。

例如：

- wrapper 没注入所需 helper
- host glue 失效
- FFI 返回值形状与约定不一致

这些仍然属于更一般的运行时异常，而不是游戏动作结果。

## 当前结论

- 正式版第一阶段移除 `ActionError`
- 普通动作统一返回 `ActionResult`
- 普通动作使用 `ActionFailure + ActionResult` 两层建模
- 查询类“不存在”继续使用 `Option`
- 对象创建类动作使用更窄的专门结果类型
