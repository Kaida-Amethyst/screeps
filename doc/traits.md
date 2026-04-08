# 能力 Trait 体系

本文档记录正式版 Screeps Arena binding 的 trait 设计方向。

## 总体结论

- 正式版采用“小 trait 组合”
- 不采用“大一统基类 trait”
- trait 主要分成两类：
  - 观察能力 trait
  - 动作目标 trait

这套设计的目标不是复刻 Screeps 的继承树，而是让对象组合、动作签名与高层 API 更清楚。

## 观察能力 trait

观察能力 trait 用来表达“这个对象具备什么属性”。

当前建议保留：

- `GameObjectLike`
- `HasStore`
- `HasHits`
- `OwnedLike`

### `GameObjectLike`

最基础的一层。

建议至少覆盖：

- `x`
- `y`
- `exists`
- `id`

如果后续发现有必要，也可以再讨论是否拆出单独的 `HasPosition`。

### `HasStore`

用于表达对象拥有 `Store`。

适用对象例如：

- `OwnedCreep`
- `StructureSpawn`
- `StructureTower`
- `StructureContainer`

### `HasHits`

用于表达对象有生命值 / 耐久度语义。

建议覆盖：

- `hits`
- `hits_max`

### `OwnedLike`

用于表达对象带有所有权语义。

建议覆盖：

- `relation`
- `is_owned()`
- `is_enemy()`

## 动作目标 trait

动作目标 trait 用来表达“这个对象能当某个动作的目标”。

当前建议保留：

- `MoveTarget`
- `AttackTarget`
- `RangedAttackTarget`
- `HealTarget`
- `HarvestTarget`
- `TransferTarget`
- `WithdrawTarget`
- `BuildTarget`

这组 trait 直接决定高层 API 能不能写得自然。

例如希望最终支持：

```moonbit
creep.move_to(flag)
creep.attack(enemy)
creep.harvest(source)
creep.transfer_energy(spawn)
creep.withdraw_energy(container)
creep.build(site)
```

这类自然写法依赖的就是目标能力 trait。

## trait 粒度结论

- 宁可多个小 trait
- 不做少量含混的大 trait

当前不建议过早引入：

- `SourceLike`
- `ContainerLike`
- `StructureLike`
- `OwnedStructureLike`
- `CombatUnitLike`

原因是这些抽象在第一阶段很容易变成“为了抽象而抽象”。

## trait 与 typed view 的边界

typed view 用来表达“它是什么”：

- `OwnedCreep`
- `EnemyCreep`
- `OwnedSpawn`
- `EnemySpawn`
- `OwnedTower`
- `EnemyTower`

trait 用来表达“它能做什么 / 它能被做什么”。

因此：

- typed view 不替代 trait
- trait 也不替代 typed view

两者层次不同，应长期并存。

## 第一阶段推荐最小 trait 集

当前推荐先落地这一批：

- `GameObjectLike`
- `HasStore`
- `HasHits`
- `OwnedLike`
- `MoveTarget`
- `AttackTarget`
- `RangedAttackTarget`
- `HealTarget`
- `HarvestTarget`
- `TransferTarget`
- `WithdrawTarget`
- `BuildTarget`

## 当前结论

- trait 体系服务于对象组合与高层 API 设计
- 第一阶段优先落小 trait，不落大而泛的抽象
- 观察能力与动作目标应分开建模

## trait 应该放在哪一层

当前结论：

- trait 的**定义**应主要放在 `api`
- `model` 负责 concrete wrapper、typed view 与必要的实现
- `raw` 不定义这些高层 trait

## 为什么 trait 定义放在 `api`

原因如下：

### 1. trait 是对外语义契约

例如：

- `MoveTarget`
- `AttackTarget`
- `TransferTarget`

这些都不是 raw/runtime 层天然存在的东西，而是 MoonBit API 层对 Arena 能力的整理结果。

因此更适合放在 `api`。

### 2. `model` 应保持对象层稳定

`model` 的重点应是：

- 定义对象
- 定义 typed view
- 提供 live getter
- 提供 typed view 转换

如果把 trait 定义也塞进 `model`，容易让 `model` 逐渐承担过多高层语义，最终与 `api` 混在一起。

### 3. 分层更利于长期维护

采用以下分工会更清楚：

- `raw`：怎么连上
- `model`：对象是什么
- `api`：怎么好用地用

trait 明显更接近第三层。

## 各层建议承载内容

### `model`

建议承载：

- `Creep`、`OwnedCreep`、`EnemyCreep`
- `Source`
- `StructureSpawn`、`OwnedSpawn`、`EnemySpawn`
- `StructureTower`、`OwnedTower`、`EnemyTower`
- `StructureContainer`
- `ConstructionSite`
- `Relation`
- live getter
- `as_owned()` / `as_enemy()` 这类 typed view 转换

### `api`

建议承载：

- `GameObjectLike`
- `HasStore`
- `HasHits`
- `OwnedLike`
- `MoveTarget`
- `AttackTarget`
- `RangedAttackTarget`
- `HealTarget`
- `HarvestTarget`
- `TransferTarget`
- `WithdrawTarget`
- `BuildTarget`
- `ActionResult`
- `SpawnResult`
- `CreateConstructionSiteResult`
- 高层动作接口

## 当前原则

- `model`：定义对象和视图
- `api`：定义 trait 和高层语义契约
- 除非有很强的理由，否则不把 trait 定义提前放进 `model`
