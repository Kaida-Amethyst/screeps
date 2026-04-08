# 对象建模

本文档记录正式版 binding 的对象建模结论。

注意：

- 当前只先固化 `Creep` 的建模结论
- 其它对象后续逐个讨论，不在这里提前拍板

## `Creep` 的建模结论

### 总结

- 不把 `Creep` 本身设计成主要的一等 `trait object`
- `Creep` 保留为 concrete wrapper
- 另外定义共享能力 trait
- 再按需要提供更强约束的 typed view

### 推荐结构

`raw` 层：

```moonbit
pub extern type JsCreep
```

`model` 层：

```moonbit
pub enum Relation {
  Mine
  Enemy
  Neutral
}

pub struct Creep {
  raw : JsCreep
  relation : Relation
}

pub struct OwnedCreep {
  raw : JsCreep
}

pub struct EnemyCreep {
  raw : JsCreep
}
```

`api` 层：

```moonbit
pub trait CreepLike : GameObjectLike {
  as_creep(Self) -> Creep
}
```

说明：

- `Creep` 是通用观察视图
- `OwnedCreep` 是可行动的己方 creep 视图
- `EnemyCreep` 是敌方 creep 视图
- `CreepLike` 用来表达共享能力，而不是把 `Creep` 本身做成 trait object

### 为什么不把 `Creep` 直接做成 trait object

原因有三点：

- Screeps 的 creep 本身是具体运行时对象，更适合先有 concrete wrapper
- 大多数常见接口处理的是同类集合，不需要 `Array[&Trait]` 这类异构容器
- trait object 更适合表达“能力多态”，不适合作为整个对象体系的主骨架

换句话说：

- `MoveTarget`、`AttackTarget`、`HasStore` 这类更适合 trait
- `Creep` 这种对象类别本身，更适合 concrete wrapper + typed view

### `trait`、typed view 与 ADT 的分工

当前建议的分工是：

- concrete wrapper：表达“这是一个 creep 对象”
- typed view：表达“这是己方 creep / 敌方 creep”
- trait：表达“它具备哪些能力”
- ADT：在需要穷尽分类与模式匹配时再引入

因此：

- 平时查询 `creeps()` 可以返回 `Array[Creep]`
- `my_creeps()` 更适合返回 `Array[OwnedCreep]`
- `enemy_creeps()` 更适合返回 `Array[EnemyCreep]`
- 如果未来需要统一处理不同 creep 视图，可以再讨论是否增加 `enum CreepView`

### 命名结论

- 不采用 `MyCreep`
- 当前更推荐：
  - `OwnedCreep`
  - `EnemyCreep`

理由：

- `OwnedCreep` 比 `MyCreep` 更正式
- `OwnedCreep` 与 Screeps 的 `OwnedStructure` 语义更接近

### 字段缓存结论

`Creep` wrapper 中只建议缓存稳定语义字段，例如：

- `relation`

不建议缓存动态字段，例如：

- `hits`
- `store`
- `spawning`
- `fatigue`

这些都更适合通过 live getter 读取。

### 当前状态

以上结论目前只对 `Creep` 生效。

## `Source` 的建模结论

### 总结

- `Source` 采用 `JsSource + Source wrapper`
- 不做 `OwnedSource` / `EnemySource`
- 不把 `Source` 本身做成 trait object
- 只在需要时实现若干能力 trait

### 推荐结构

`raw` 层：

```moonbit
pub extern type JsSource
```

`model` 层：

```moonbit
pub struct Source {
  raw : JsSource
}
```

`api` 层：

```moonbit
pub fn sources() -> Array[Source]
pub fn active_sources() -> Array[Source]
```

### 为什么 `Source` 不需要 typed view

`Source` 不存在像 `Creep` 那样的所有权分化。

它的主要语义只是：

- 一个能量来源
- 有位置
- 有当前能量值
- 可以作为 harvest 目标

因此它更适合作为“中性资源对象”的简单模型，而不是做复杂分层。

### 字段设计

`Source` 不建议缓存额外语义字段。

推荐直接保持：

```moonbit
pub struct Source {
  raw : JsSource
}
```

动态信息都通过 getter 获取，例如：

- `energy`
- `x`
- `y`
- `exists`

### 动作边界

`Source` 应主要暴露观察型接口，不在 `Source` 上挂动作。

更合理的动作边界是：

```moonbit
pub fn OwnedCreep::harvest(target : Source) -> ActionResult
```

而不是把动词反向挂在 `Source` 上。

### trait 关系

`Source` 适合实现这类 trait：

- `GameObjectLike`
- 未来如果有位置能力 trait，则实现 `HasPosition`
- 作为目标时，可实现 `HarvestTarget`

当前不建议为了 `Source` 额外引入 `SourceLike` 抽象。

### 命名结论

- 保持官方命名 `Source`
- 不额外改成 `EnergySource`

理由是：

- Arena 文档和 typings 中就是 `Source`
- 这一命名已经足够明确

## 当前已固化对象

- `Creep`
- `Source`

## `StructureSpawn` 的建模结论

### 总结

- `raw` 层只需要 `JsStructureSpawn`
- MoonBit API 层需要：
  - `StructureSpawn`
  - `OwnedSpawn`
  - `EnemySpawn`
- `EnemySpawn` 是 MoonBit API 视图，不是官方原始类型

### 推荐结构

`raw` 层：

```moonbit
pub extern type JsStructureSpawn
```

`model` 层：

```moonbit
pub struct StructureSpawn {
  raw : JsStructureSpawn
  relation : Relation
}

pub struct OwnedSpawn {
  raw : JsStructureSpawn
}

pub struct EnemySpawn {
  raw : JsStructureSpawn
}
```

### 构造与转换

建议提供：

```moonbit
fn wrap_spawn(raw : JsStructureSpawn) -> StructureSpawn

pub fn StructureSpawn::is_owned(self) -> Bool
pub fn StructureSpawn::is_enemy(self) -> Bool

pub fn StructureSpawn::as_owned(self) -> OwnedSpawn?
pub fn StructureSpawn::as_enemy(self) -> EnemySpawn?
```

### 查询接口

建议提供：

```moonbit
pub fn spawns() -> Array[StructureSpawn]
pub fn owned_spawns() -> Array[OwnedSpawn]
pub fn enemy_spawns() -> Array[EnemySpawn]
```

当前更推荐：

- `owned_spawns()`
- `enemy_spawns()`

而不是 `my_spawns()`，因为与 `EnemySpawn` 配套时，`OwnedSpawn` 这组命名更统一。

### 能力分工

`StructureSpawn`：

- 通用观察视图
- 只放 read-only / 观察型接口
- 例如：
  - `store`
  - `spawning`
  - `directions`
  - `hits`
  - `x / y`

`OwnedSpawn`：

- 可行动视图
- 放主动动作
- 例如：
  - `spawn(...)`
  - `spawn_result(...)`
  - `set_directions(...)`

`EnemySpawn`：

- 敌方观察视图
- 不放主动动作
- 主要用于：
  - 查询
  - 距离判断
  - bot 决策目标
  - 更清晰的类型表达

### 为什么需要 `EnemySpawn`

虽然官方文档和 typings 中没有单独的 `EnemySpawn` 类型，但在 MoonBit API 层引入它是合理的，因为：

- bot 代码可以避免反复 `filter(i => !i.my)`
- 类型语义更强
- 它与 `OwnedSpawn` 配套
- 它与 `OwnedCreep / EnemyCreep` 的方向一致

### 当前结论

- `StructureSpawn` 是通用视图
- `OwnedSpawn` 是可行动视图
- `EnemySpawn` 是敌方观察视图
- `EnemySpawn` 属于 MoonBit API 的高层抽象，不属于官方 raw 类型层级

## `StructureTower` 的建模结论

### 总结

- `raw` 层只需要 `JsStructureTower`
- MoonBit API 层建议提供：
  - `StructureTower`
  - `OwnedTower`
  - `EnemyTower`

### 推荐结构

`raw` 层：

```moonbit
pub extern type JsStructureTower
```

`model` 层：

```moonbit
pub struct StructureTower {
  raw : JsStructureTower
  relation : Relation
}

pub struct OwnedTower {
  raw : JsStructureTower
}

pub struct EnemyTower {
  raw : JsStructureTower
}
```

### 查询接口

建议提供：

```moonbit
pub fn towers() -> Array[StructureTower]
pub fn owned_towers() -> Array[OwnedTower]
pub fn enemy_towers() -> Array[EnemyTower]
```

### 能力分工

`StructureTower`：

- 通用观察视图
- 例如：
  - `store`
  - `cooldown`
  - `hits`
  - `x / y`

`OwnedTower`：

- 可行动视图
- 例如：
  - `attack(...)`
  - `heal(...)`
  - 未来如果补 `repair(...)`，也挂在这里

`EnemyTower`：

- 敌方观察视图
- 不放主动动作
- 用于：
  - 作为攻击目标
  - 参与范围判断
  - 表达“危险建筑”语义

### 为什么需要 `EnemyTower`

- 与 `OwnedTower` 配套
- 与 `OwnedSpawn / EnemySpawn` 保持一致
- 在 bot 决策中，敌方 tower 是很自然的重要目标

### 当前结论

- `StructureTower` 可以沿用 `StructureSpawn` 那套三层视图模式
- 它是“有所有权，且敌我语义都重要的结构”的第二个模板

## `StructureContainer` 的建模结论

### 总结

- `raw` 层只需要 `JsStructureContainer`
- 第一阶段 MoonBit API 层只提供：
  - `StructureContainer`
- 不提供：
  - `OwnedContainer`
  - `EnemyContainer`
- 但 `StructureContainer` 内部仍然保留 `Relation`

### 推荐结构

`raw` 层：

```moonbit
pub extern type JsStructureContainer
```

`model` 层：

```moonbit
pub struct StructureContainer {
  raw : JsStructureContainer
  relation : Relation
}
```

### 为什么当前不拆 `EnemyContainer`

虽然官方文档和 typings 明确说明了 container 的敌我区分具有语义：

- `StructureContainer` 继承 `OwnedStructure`
- `OwnedStructure.my` 能区分己方 / 敌方 / 中立
- `Creep.withdraw` 文档明确提到可以从 hostile structure 中取资源

但当前判断是：

- `Container` 的主要价值仍然是资源与存储目标
- 它不像 `Spawn` / `Tower` 那样有明显的主动动作面
- 在第一阶段，单一 `StructureContainer` wrapper 已足够支撑主要使用场景

因此：

- 保留 `relation`
- 暂不拆 typed view
- 如果后续确实出现大量“敌方 container”策略逻辑，再重新讨论

### 观察接口与能力

`StructureContainer` 主要承担观察型角色。

典型接口包括：

- `store`
- `hits`
- `x / y`
- `relation`

在能力层面，它更适合实现：

- `GameObjectLike`
- `HasStore`
- `WithdrawTarget`
- `TransferTarget`

### 当前结论

- `StructureContainer` 是“有所有权，但主动动作弱”的结构模板
- 第一阶段保留 `relation`
- 第一阶段不拆 `OwnedContainer / EnemyContainer`

## `ConstructionSite` 的建模结论

### 总结

- `raw` 层只需要 `JsConstructionSite`
- 第一阶段 MoonBit API 层只提供：
  - `ConstructionSite`
- 不急着提供：
  - `OwnedConstructionSite`
  - `EnemyConstructionSite`

### 推荐结构

`raw` 层：

```moonbit
pub extern type JsConstructionSite
```

`model` 层：

```moonbit
pub struct ConstructionSite {
  raw : JsConstructionSite
  relation : Relation
}
```

### 为什么当前不拆 typed view

`ConstructionSite` 的主要用途比较集中：

- 查询工地
- 判断是不是自己的工地
- 作为 `build` 目标

它不像 `Creep`、`StructureSpawn`、`StructureTower` 那样存在强烈的敌我行为分化。

因此在第一阶段：

- 保留 `relation`
- 不拆 typed view
- 用单一 wrapper 支撑主要场景

### 查询接口

建议提供：

```moonbit
pub fn construction_sites() -> Array[ConstructionSite]
pub fn my_construction_sites() -> Array[ConstructionSite]
```

当前不建议让 `my_construction_sites()` 返回单独的专用视图类型。

### 动作边界

`ConstructionSite` 自身不挂主动动作。

更合理的边界是：

```moonbit
pub fn OwnedCreep::build(target : ConstructionSite) -> ActionResult
```

### 与 `createConstructionSite` 的关系

高层 `createConstructionSite(...)` 接口返回：

- `ConstructionSite?`
- 或专门的结果类型

当前不需要返回 `OwnedConstructionSite` 一类更强视图。

### 当前结论

- `ConstructionSite` 是“有 `my` 语义，但主要作为目标对象存在”的模板
- 第一阶段保留 `relation`
- 第一阶段不拆 typed view

## 待后续讨论对象

- `ConstructionSite`
