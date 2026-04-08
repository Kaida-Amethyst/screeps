# 查询接口设计

本文档记录正式版 Screeps Arena binding 的查询接口设计方向。

## 总体原则

- 不把 JS 的 `getObjectsByPrototype` 直接作为正式 MoonBit API 的中心
- 正式版对外优先暴露：
  - typed query
  - typed view
  - 统一命名
- `constructor.name`、class token、wrapper glue 都属于实现细节，不应泄漏到正式 API

## 分层建议

### `raw`

`raw` 保留最底层查询能力。

允许：

- 保留 workaround
- 保留偏 JS 风格的实现细节

目标是：

- “查得到”

而不是：

- “对外好用”

### `api`

`api` 负责提供正式可用的 typed query：

- 不要求用户传 prototype token
- 不暴露 `constructor.name`
- 不暴露 `@core.Any`

最终用户应写：

```moonbit
let creeps = owned_creeps()
let towers = enemy_towers()
let sources = sources()
```

而不是显式传 prototype。

## 正式 API 的查询命名规则

### 1. 全量同类对象

建议提供：

- `creeps() -> Array[Creep]`
- `sources() -> Array[Source]`
- `spawns() -> Array[StructureSpawn]`
- `towers() -> Array[StructureTower]`
- `containers() -> Array[StructureContainer]`
- `construction_sites() -> Array[ConstructionSite]`

### 2. 敌我细分查询

只对已经有 typed view 的对象提供：

- `owned_creeps() -> Array[OwnedCreep]`
- `enemy_creeps() -> Array[EnemyCreep]`
- `owned_spawns() -> Array[OwnedSpawn]`
- `enemy_spawns() -> Array[EnemySpawn]`
- `owned_towers() -> Array[OwnedTower]`
- `enemy_towers() -> Array[EnemyTower]`

正式 API 统一优先使用：

- `owned_*`
- `enemy_*`

不再把 `my_*` 作为正式命名主线。

### 3. 特定语义筛选

只保留稳定、价值高的语义筛选：

- `active_sources()`
- `owned_construction_sites()`

不鼓励把大量 tutorial / bot 语义 helper 提升为 binding 核心 API。

## `getObjectsByPrototype` 的正式定位

当前结论：

- 正式对外 API 不直接提供 `get_objects_by_prototype`
- 它可以保留在底层实现里
- 如有必要，可以保留 `raw` 版本，但不鼓励上层直接使用

原因：

- 太偏 JS 风格
- 强依赖 class token
- 对 MoonBit 用户不够自然
- typed query 更适合作为正式 API

## 单对象查询

第一阶段建议保留：

- `ticks()`
- `object_by_id(id) -> GameObject?`

当前结论：

- `object_by_id` 的正式高层接口先返回 `GameObject?`
- 不在第一阶段引入过重的统一对象 ADT
- 通过 `GameObject` 上的安全下转方法进入具体对象视图

例如：

- `as_creep()`
- `as_source()`
- `as_structure_spawn()`
- `as_structure_tower()`
- `as_structure_container()`
- `as_construction_site()`

这样可以兼顾：

- 高层接口的正式性
- API 复杂度的可控性
- 后续扩展为更强统一视图的空间

## 距离与最近目标查询

当前结论：

- 不直接把 `findClosestByPath / findClosestByRange` 作为正式 MoonBit API 名字
- `raw` 可以保留原始命名
- `api` 应整理为统一接口

建议引入：

```moonbit
pub enum ClosestMetric {
  Path
  Range
}
```

高层建议形式：

```moonbit
find_closest(candidates, by~ : ClosestMetric = Path)
find_in_range(candidates, range : Int)
range_to(target)
```

更推荐方法式调用：

```moonbit
creep.find_closest(flags)
creep.find_closest(enemy_creeps, by=Range)
creep.find_in_range(enemy_creeps, 3)
creep.range_to(target)
```

## 不进入正式 binding 核心层的查询

以下更适合作为 tutorial / bot helper，而不是 binding 正式查询层：

- `first_creep()`
- `first_flag()`
- `melee_creeps()`
- `healers()`
- 其它明显带策略语义的 helper

## 当前结论

- `raw` 允许保留 workaround
- `api` 只暴露 typed query
- `object_by_id` 的第一阶段正式接口返回 `GameObject?`
- 正式命名统一走：
  - `creeps() / owned_creeps() / enemy_creeps()`
  - `spawns() / owned_spawns() / enemy_spawns()`
  - `towers() / owned_towers() / enemy_towers()`
- 距离查询统一走：
  - `find_closest(..., by~=Path)`
  - `find_in_range(...)`
  - `range_to(...)`
- bot 语义 helper 不进入 binding 核心层
