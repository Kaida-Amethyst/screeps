# 正式版 Binding 的目标与边界

本文档记录正式版 Screeps Arena binding 第一阶段的目标范围与非目标。

注意：

- 本文档描述的是当前阶段的设计结论
- 后续如果实现过程中遇到新的事实约束，还可以调整
- 第一阶段的关键词是：稳定、清晰、可扩展、适合直播与 bot 开发

## 总体定位

- 正式版 binding 的目标定位：面向 **Screeps Arena** 的 MoonBit binding
- 第一阶段的主要服务对象：
  - live coding
  - tutorial 演示
  - bot 开发
  - 后续持续扩展
- 第一阶段的重点：
  - MoonBit 风格的类型接口
  - 稳定的 FFI 边界
  - 支撑直播与 bot 开发的高可读 API
- 第一阶段的重点不是：
  - 与 JS API 一字不差
  - 一次性做完整覆盖
  - 消灭 `main.mjs` wrapper

## 范围边界

- 第一阶段只覆盖 **Screeps Arena**
- 第一阶段不覆盖经典 Screeps MMO
- 第一阶段不以“全量 API 一次性完成”为目标
- 第一阶段以“先做出稳定核心 binding”为目标

## 阶段划分

- `P0`：直播与 bot 开发必需，必须优先稳定
- `P1`：Arena 常用但不是首场直播硬依赖
- `P2`：模式专属、进阶能力、低频 API

## P0 建议范围

### 常量

- 常用 body part 常量
- `RESOURCE_ENERGY`
- 常用 `ERR_*`

### 对象

- `GameObject`
- `Creep`
- `Source`
- `Store`
- `Flag`
- `Structure`
- `StructureSpawn`
- `StructureTower`
- `StructureContainer`
- `ConstructionSite`

### 常用查询

- `getTicks`
- `getObjects`
- `getObjectsByPrototype`
- `getObjectById`

### 常用动作

- `moveTo`
- `attack`
- `rangedAttack`
- `heal`
- `harvest`
- `transfer`
- `withdraw`
- `build`
- `spawnCreep`
- `tower.attack`

### 常用距离与查找

- `findClosestByPath`
- `findClosestByRange`
- `findInRange`
- `getRange`

### 工地相关

- `createConstructionSite`

### P0 完成标准

- 能用正式版 binding 重写 tutorial 主线
- 能支持 final test
- 能写出至少一个经济 + 战斗 bot
- bot 主逻辑里尽量不出现 `@core.Any`

## P1 建议范围

### path-finder

- `CostMatrix`
- `searchPath`
- `findPath`

### 更多对象

- `StructureExtension`
- `StructureRampart`
- `StructureRoad`
- `StructureWall`
- `Resource`
- `Spawning`

### 更多动作

- `move`
- `drop`
- `pickup`
- `pull`
- `rangedHeal`
- `rangedMassAttack`

### 更完整的高层抽象

- `BodyPartKind`
- `ResourceKind`
- 更细的结果类型
- typed view / trait 体系

## P2 建议范围

- 模式专属对象：
  - `BodyPart`
  - `BonusFlag`
  - `AreaEffect`
  - `ConstructionBoost`
  - `StructureGoal`
- `Visual`
- 低频工具函数与补全型 API
- 更强的辅助封装与示例库

## 明确非目标

- 第一阶段不做经典 Screeps MMO binding
- 第一阶段不追求 Arena 全量 API 全覆盖
- 第一阶段不做厚重的 bot framework
- 第一阶段不把所有 tutorial helper 都提升为正式库 API
- 第一阶段不强求去掉 `main.mjs` wrapper

## 当前结论

- 正式版第一阶段应定义为：
  面向 Screeps Arena、服务直播与 bot 开发的核心 binding
- 范围上采用 `P0 / P1 / P2`
- 开发顺序先打稳 `P0`
- `main.mjs` wrapper 视为正式架构的一部分，不视为临时脏补丁
