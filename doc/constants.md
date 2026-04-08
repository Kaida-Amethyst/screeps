# 常量、资源与 Body Part 抽象

本文档记录正式版 Screeps Arena binding 中，常量、资源类型、Body Part 类型与 `Store` 接口的设计结论。

## 总体结论

- 正式版采用“两层常量模型”
  - `raw`：保留官方原始常量形状
  - `api`：引入 MoonBit 风格的 enum 和高层 helper
- `raw` 可以继续保留字符串常量和数字常量
- `api` 不再鼓励用户直接使用字符串常量
- 对需要在下游包直接使用的高层 enum，正式版使用 `pub(all)` 导出构造子
- 正常业务代码应直接使用 `Work`、`Energy`、`Tower` 这类 ADT 值，而不是先写字符串再解析

## 结构原型抽象

第一阶段正式引入：

```moonbit
pub(all) enum StructureKind {
  Spawn
  Extension
  Road
  Rampart
  Wall
  Tower
  Container
}
```

并提供：

```moonbit
fn StructureKind::to_prototype_name(self) -> String
fn structure_kinds() -> Array[StructureKind]
```

### 当前定位

- 这层抽象主要服务于 `create_construction_site`
- `raw` 层仍然只处理原始 prototype name
- 高层 API 不再要求用户直接传 `"StructureTower"` 这类字符串

## Body Part 抽象

第一阶段建议正式引入：

```moonbit
pub(all) enum BodyPartKind {
  Move
  Work
  Carry
  Attack
  RangedAttack
  Heal
  Tough
}
```

并提供转换：

```moonbit
fn BodyPartKind::to_raw(self) -> String
```

其中：

- `to_raw` 主要服务于 binding 内部和 `raw` 交互
- 正常下游代码直接使用 `Work`、`Carry`、`Move` 等 ADT 值

### 高层收益

这样高层代码可以自然写成：

```moonbit
creep.has_body_part(Attack)
spawn.spawn([Work, Carry, Move])
```

而不需要直接暴露字符串常量。

### 后续扩展

如果后续需要更完整的 body part 建模，可以继续增加：

```moonbit
pub struct BodyPart {
  kind : BodyPartKind
  hits : Int
}
```

## Resource 抽象

第一阶段也建议引入：

```moonbit
pub(all) enum ResourceKind {
  Energy
}
```

并提供转换：

```moonbit
fn ResourceKind::to_raw(self) -> String
```

### 当前策略

- 第一阶段先只覆盖 `Energy`
- 但结构上从一开始就采用 enum
- 不继续把 `RESOURCE_ENERGY` 字符串常量作为正式高层 API 主入口
- 下游包应可以直接使用 `Energy`

## `raw` 层策略

`raw` 继续保留：

- 原始字符串常量
- 原始数字常量
- 原始 `ERR_*`

理由：

- `raw` 的职责是贴近 JS
- `raw` 的目标是“正确映射”，不是“高层友好”

## `api` 层策略

`api` 优先暴露：

- `BodyPartKind`
- `ResourceKind`

高层动作签名尽量使用这些类型，而不是 string。

例如：

```moonbit
pub fn MySpawn::spawn(
  self,
  body : Array[BodyPartKind]
) -> SpawnResult
```

```moonbit
pub fn MyCreep::transfer(
  self,
  target : TransferTarget,
  resource : ResourceKind,
  amount? : Int
) -> ActionResult
```

同时允许提供更顺手的常用 helper，例如：

- `transfer_energy(...)`
- `withdraw_energy(...)`

## `Store` 的高层接口

当前建议分成两层：

### 基础层

```moonbit
pub fn Store::used(self, resource : ResourceKind) -> Int
pub fn Store::free(self, resource : ResourceKind) -> Int
```

### 便捷层

```moonbit
pub fn Store::energy(self) -> Int
pub fn Store::free_energy(self) -> Int
```

这样既保留了通用性，也兼顾了直播与 bot 开发时的易用性。

## 错误码常量的定位

- `raw` 保留原始数字常量
- `api` 不鼓励用户直接处理 `ERR_*` 数字常量
- 高层动作结果以 `ActionResult` 为主

因此：

- 错误码常量仍然有实现价值
- 但不再是正式高层 API 的主交互方式

## 当前结论

- 第一阶段正式引入：
  - `BodyPartKind`
  - `ResourceKind`
- 第一阶段同时引入：
  - `StructureKind`
- 可通过 `structure_kinds()` 获取当前支持的结构原型种类列表
- `raw` 保留原始字符串 / 数字常量
- `api` 优先暴露 enum，并允许下游直接构造这些 enum 的值
- `Store` 同时提供通用资源接口与 `energy` 便捷接口
- 错误码常量留在底层，不作为高层主接口
