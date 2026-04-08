# 路径与距离 API

本文档记录正式版 Screeps Arena binding 中，与距离、最近目标查询和路径搜索相关的 API 设计结论。

## 总体结论

- `findClosestByPath / findClosestByRange` 在正式 API 中统一为一个接口
- 正式引入 `ClosestMetric`
- 高层主推荐方法式接口
- 同时保留函数式通用版本
- `findPath / searchPath` 这类路径搜索工具仍以函数式为主
- `ClosestMetric` 采用 `pub(all)` 导出构造子，下游包可直接使用 `Path` / `Range`

## `findClosestByPath / findClosestByRange` 的统一

当前结论：

- 不再把 `findClosestByPath`
- 和 `findClosestByRange`

作为两个并列的正式高层 API 名字

而是统一成：

```moonbit
find_closest(candidates, by~ : ClosestMetric = Path)
```

原因：

- 这本质上是同一个查询
- 差异只在于“最近”的度量方式不同
- 用参数表达度量方式，比保留两个平行函数更符合 MoonBit 风格

## `ClosestMetric`

当前建议正式引入：

```moonbit
pub(all) enum ClosestMetric {
  Path
  Range
}
```

### 作用

- 让“最近”的定义显式化
- 支持默认参数
- 提高可读性
- 为后续扩展保留空间

同时提供：

```moonbit
fn closest_metrics() -> Array[ClosestMetric]
```

用于获取当前支持的距离度量方式列表。

## 方法式与函数式的取舍

### 高层主推荐：方法式

正式版主推荐：

```moonbit
creep.find_closest(flags)
creep.find_closest(enemy_creeps, by=Range)
creep.find_in_range(enemy_creeps, 3)
creep.range_to(target)
```

当前实现说明：

- 由于 MoonBit 当前不支持多态 trait 方法
- 方法式接口通过各个 wrapper 上的同名方法提供
- 同时仍保留函数式版本作为通用入口

原因：

- 这类查询天然有“从谁出发”的中心对象
- 方法式更符合阅读直觉
- 更适合直播展示“对象 + 能力”风格

### 同时保留：函数式通用接口

仍建议提供函数式版本，例如：

```moonbit
find_closest(from, candidates, by~=Path)
find_in_range(from, candidates, range)
range_between(a, b)
```

适用场景：

- 起点不是具体 `GameObject`
- 起点只是一个位置对象
- 需要更通用的工具函数风格

## `GameObject` 方法与 `utils` 风格函数的边界

当前边界建议如下：

### 适合方法式的能力

如果语义明显是“从一个对象出发做空间查询”，优先放方法式：

- `find_closest`
- `find_in_range`
- `range_to`

### 适合函数式的能力

如果语义更通用，或者起点不一定是 `GameObject`，保留函数式：

- `find_closest(from, ...)`
- `find_in_range(from, ...)`
- `range_between(a, b)`

换句话说：

- 不按官方 JS 模块位置机械划分
- 按 MoonBit 高层语义划分

## 路径搜索工具的定位

对于以下接口：

- `findPath`
- `searchPath`

当前建议：

- 继续以函数式为主
- 不强行把它们提升成方法式主接口

原因：

- 它们更像通用路径工具
- 不一定从某个具体对象出发
- 更接近算法接口，而不是对象能力接口

## 当前结论

- 正式 API 中：
  - `findClosestByPath / findClosestByRange` 统一成 `find_closest(..., by~=Path)`
- 正式引入：
  - `ClosestMetric { Path, Range }`
- 高层主推荐方法式接口
- 同时保留函数式通用接口
- 路径搜索工具保持函数式主导
