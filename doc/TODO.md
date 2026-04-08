# 正式版 Binding 讨论 TODO

本文档用于列出正式版 Screeps Arena binding 在编码前需要讨论清楚的话题。

注意：

- 这里记录的是议题、备选方案与待确认问题
- 不是最终定稿
- 某些想法目前只是探索中的阶段性判断，真正落代码时还需要继续推敲

## 目标与边界

- 明确正式版 binding 的目标范围是不是只覆盖 Screeps Arena
- 明确第一阶段是否只做 Arena 基础 API，不碰经典 Screeps MMO 文档体系
- 明确是否区分 `P0 / P1 / P2`
  - `P0`：直播和 bot 开发必需
  - `P1`：Arena 常用 API
  - `P2`：模式专属对象与进阶能力
- 明确哪些内容暂时不做
  - 例如季节模式专属 API、低频工具函数、过重的可视化封装

## 文档与信息源优先级

- 确认正式版 binding 的主规范来源
  - `~/ScreepsArena/tutorial/typings`
  - `refs/arena-docs/*.md`
  - 本地 Screeps Arena 实测
- 确认 AI 工程师协作时的信息源优先级和使用方法
- 决定哪些文档需要继续二次整理，变成更适合检索和生成代码的输入材料

## 总体分层

- 确认正式版是否采用以下分层
  - `raw`
  - `model` 或 `view`
  - `api`
  - `main.mjs` wrapper
- 明确每层职责
  - `raw` 是否只做忠实 FFI
  - `model` 是否负责包装 JS live object
  - `api` 是否只提供 MoonBit 风格接口
  - wrapper 是否只做 MoonBit 暂时不擅长的 host glue
- 决定现有项目结构是否需要从单文件 `raw.mbt` / `api.mbt` 进一步拆分

## 对象建模

- 确认是否采用 `JsXxx + MoonBit wrapper struct` 这条路线
- 讨论 `Creep`、`Source`、`StructureSpawn`、`StructureTower` 等对象的正式包装方式
- 确认 `Creep` 是否保留单一 wrapper，还是进一步拆成
  - `Creep`
  - `MyCreep`
  - `EnemyCreep`
- 确认 `relation / ownership` 的建模方式
  - 枚举
  - typed view
  - 两者结合
- 决定哪些字段可以缓存，哪些字段必须保持 live getter

## 能力 trait 体系

- 确认是否采用“能力组合”而不是“继承树翻译”
- 讨论哪些 trait 应当先定义
  - `HasPosition`
  - `HasStore`
  - `HasHits`
  - `Owned`
  - `MoveTarget`
  - `AttackTarget`
  - `RangedAttackTarget`
  - `TransferTarget`
  - `WithdrawTarget`
  - `BuildTarget`
- 决定 trait 的粒度
  - 少量大 trait
  - 多个小 trait
- 讨论 trait 和 typed view 的分工边界

## 查询接口设计

- 确认 `getObjectsByPrototype` 相关接口的正式路线
- 讨论当前 `getObjects() + constructor.name` workaround 是否只是过渡方案
- 讨论正式版是否要通过 wrapper 提供 class token 能力
- 决定查询接口命名风格
  - `creeps()`
  - `my_creeps()`
  - `enemy_creeps()`
  - 更通用的 `filter/view` 风格 helper 是否进入库层

## 动作返回值与错误建模

- 已决定普通动作统一使用 `ActionResult`
- 后续继续讨论是否需要更细的结果类型
  - `SpawnResult`
  - `CreateConstructionSiteResult`
  - `TransferResult`
- 决定原始错误码在哪一层暴露
  - `raw` 全暴露
  - `api` 转为 ADT
- 讨论对象创建类动作最终采用哪一种专门结果类型

## 常量、资源与 Body Part 抽象

- 确认 `BodyPartKind` 是否在正式版引入为 enum
- 确认 `ResourceKind` 是否也应当抽象成 enum
- 决定 `raw` 层是否继续保留字符串常量
- 讨论 `Store` 的高层接口形式
  - 只提供 `energy() / free_energy()`
  - 还是更通用地支持不同资源种类

## 路径与距离 API

- 确认 `findClosestByPath / findClosestByRange` 的正式命名
- 讨论是否采用统一接口
  - `find_closest(candidates, by~ = Path)`
- 确认 `ClosestMetric` 之类的枚举是否进入正式版
- 讨论 `GameObject` 方法形式和 `utils` 函数形式的边界

## wrapper 与 FFI 边界

- 固化 `main.mjs + moonbit-main.mjs` 的标准流程
- 讨论 wrapper 长期负责哪些能力
  - class token
  - 特殊 JS glue
  - 未来可能的 polyfill
- 决定 wrapper 中允许出现多少业务语义
  - 理想情况应为零
- 讨论哪些问题应优先在 MoonBit 内解决，哪些问题应接受由 wrapper 承担

## 模式专属 API

- 决定基础 API 与模式专属 API 的目录划分
- 讨论这些对象是否第一阶段进入正式版
  - `BodyPart`
  - `BonusFlag`
  - `AreaEffect`
  - `ConstructionBoost`
  - `StructureGoal`
- 讨论是否需要按 arena 模式拆子模块

## 测试与验证

- 制定正式版 binding 的验证策略
  - `moon check`
  - `moon info`
  - `moon fmt`
  - `moon test`
  - JS 构建验证
  - Screeps Arena 运行时 smoke test
- 决定是否保留 tutorial 作为回归样例
- 讨论是否为关键接口写最小黑盒测试
- 讨论如何验证 wrapper 与 MoonBit 产物的协作

## 代码生成与 AI 协作

- 讨论哪些层适合自动生成
  - `raw` 候选
  - 常量定义
  - 简单 wrapper
- 讨论哪些层必须手写
  - `api`
  - typed view
  - trait 设计
  - 命名与文档
- 讨论给 AI 工程师的输入格式
  - typings
  - 拆分后的官方文档
  - 设计约束文档

## 命名与代码风格

- 固化 MoonBit binding 的命名约定
  - `raw` 是否保留 JS 风格语义
  - `api` 是否统一走更 MoonBit 风格的命名
- 决定哪些 helper 属于库层，哪些只属于 bot / demo 层
- 讨论对外暴露 API 时更偏“贴近 JS”还是“贴近 MoonBit”

## 实施顺序

- 确认第一批正式落地的对象与模块
  - `Creep`
  - `Source`
  - `Store`
  - `StructureSpawn`
  - `StructureTower`
  - `StructureContainer`
  - `GameObject`
  - `utils`
  - `constants`
- 确认第一批必须稳定的动作
  - `moveTo`
  - `attack`
  - `rangedAttack`
  - `heal`
  - `harvest`
  - `transfer`
  - `withdraw`
  - `spawnCreep`
  - `build`
- 决定先做 `raw` 再做 `api`，还是按对象垂直切片推进

## 建议的讨论顺序

1. 目标与边界
2. 文档与信息源优先级
3. 总体分层
4. 对象建模
5. 能力 trait 体系
6. 查询接口设计
7. 动作返回值与错误建模
8. 常量、资源与 Body Part 抽象
9. 路径与距离 API
10. wrapper 与 FFI 边界
11. 模式专属 API
12. 测试与验证
13. 代码生成与 AI 协作
14. 命名与代码风格
15. 实施顺序
