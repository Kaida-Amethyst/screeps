# Screeps Arena + MoonBit 探索记录

日期：2026-04-04
Moon 版本：`0.1.20260330 (c527f57 2026-03-30)`

## 本地已验证事项

1. MoonBit 可以直接生成导入 Screeps Arena 模块的 JS 模块。

   MoonBit 写法：

   ```moonbit
   #module("game/utils")
   extern "js" fn getTicks() -> Int = "getTicks"
   ```

   生成的 JS 开头为：

   ```js
   import { getTicks as getTicks$73 } from "game/utils";
   ```

2. `js` 目标下的导出重命名是可用的。

   在 `moon.pkg` 中写：

   ```moonbit
   options(
     "is-main": true,
     link: {
       "js": {
         "exports": [ "main_loop:loop" ],
       },
     },
   )
   ```

   生成的 JS 结尾为：

   ```js
   export { _...main__loop as loop }
   ```

   同时生成的 `.d.ts` 中会出现：

   ```ts
   export function loop(): MoonBit.Unit;
   ```

3. `loop` 这个名字不适合直接作为这里的 MoonBit 函数名。

   直接写 `pub fn loop()` 会触发解析错误。实践上可行的模式是：

   ```moonbit
   pub fn main_loop() -> Unit { ... }
   ```

   再通过下面的配置把它导出成 JS 的 `loop`：

   ```moonbit
   "exports": [ "main_loop:loop" ]
   ```

4. 反向写法在当前工具链下不可用。

   下面这种写法没有得到预期结果：

   ```moonbit
   "exports": [ "loop:main_loop" ]
   ```

   实际效果是它会被直接裁掉。因此当前观察到的语义是：

   ```text
   MoonBit名称:Js名称
   ```

5. `mizchi/js` 已经足够支撑渐进式 binding 开发。

   本地现成可用的关键能力包括：

   - `@core.Any`
   - `obj["key"]`
   - `obj._get("key")`
   - `obj._set("key", value)`
   - `obj._call("method", args)`
   - `@core.array_from(...)`
   - `@core.from_entries(...)`
   - `#external pub type T`

6. Screeps Arena 的 typings 已经在本机磁盘上。

   `~/ScreepsArena/tutorial/typings/game` 下目前可直接参考的模块包括：

   - `game/utils`
   - `game/constants`
   - `game/prototypes`
   - `game/prototypes/creep`
   - `game/prototypes/source`
   - `game/prototypes/spawn`
   - `game/prototypes/store`

## 由此得到的判断

这条最简单的路线已经成立：

1. 用 MoonBit 的 `#module("game/...") extern "js"` 导入 Screeps API。
2. 用一个 MoonBit 的 main package 生成最终的 JS 模块。
3. 用 `main_loop:loop` 的方式导出 Screeps 需要的 `loop`。
4. 从很小的一组 typed wrapper 起步，而不是一开始就绑定完整 Screeps API。

这意味着直播可以基于一条真实可运行的 MoonBit -> Screeps 路线，而不是演示一个假的中转适配层。

## 建议的包结构

1. `username/screeps/raw`

   只放最薄的一层 extern 声明，不做太多策略封装。必要时可以积极使用 `@core.Any`。

2. `username/screeps/api`

   只放直播演示需要的小量 typed helper，例如：

   - `creeps() -> Array[Creep]`
   - `sources() -> Array[Source]`
   - `my_spawns() -> Array[StructureSpawn]`
   - `harvest_loop() -> Unit`

3. `main`

   作为最终导出入口：

   ```moonbit
   pub fn main_loop() -> Unit {
     @api.harvest_loop()
   }
   ```

## 第一场直播所需的最小 binding 面

如果目标是先做一场稳定的直播，第一版只需要覆盖这些能力：

- `getTicks`
- `getObjectsByPrototype`
- `findClosestByRange` 或 `findClosestByPath`
- 常量：`WORK`、`CARRY`、`MOVE`、`RESOURCE_ENERGY`、`OK`、`ERR_NOT_IN_RANGE`
- 类型：`GameObject`、`Creep`、`Source`、`StructureSpawn`、`Store`
- 方法：
  - `Creep::moveTo`
  - `Creep::harvest`
  - `Creep::transfer`
  - `StructureSpawn::spawnCreep`
  - `Store::getUsedCapacity`
  - 对 `x`、`y`、`my`、`store`、`spawning` 等属性的访问

这一套已经足够演示：

1. MoonBit 如何导入 Screeps API。
2. MoonBit 如何导出 `loop`。
3. 一个 creep 如何找到 source、采集能量、再把能量送回去。

## binding 风格建议

建议按这个顺序推进：

1. 先把 prototype 包成 external type。

   ```moonbit
   #external
   pub type Creep
   ```

2. 再从 Screeps 模块里导入构造器或模块级函数。

   ```moonbit
   #module("game/prototypes")
   extern "js" fn creep_ctor() -> @core.Any = "Creep"
   ```

3. 对签名稳定、语义清晰的方法，直接写成绑定。

4. 对 `SpawnCreepResult` 这类不规则返回对象，第一版先用 `@core.Any`，后面再补更强的类型。

这样做的好处是第一版足够小，也更抗变化。

## 风险与约束

1. `is-main` 包在模块加载时仍然会执行一次 `main()`。

   在 Screeps 场景里，这个 `main` 必须保持为空，或者至少不能有副作用。

2. Screeps 有些返回值是对象联合类型，例如 `SpawnCreepResult`。

   这类对象第一版更适合先按原始 JS 对象处理。

3. `Store` 本身带有一部分动态属性访问，例如 `store[resource]`。

   这类位置更适合使用 `@core.Any` 或一层很薄的 wrapper，而不是过早追求完全静态化。

4. 在直播前试图一次性做完整 binding 是陷阱。

   直播真正需要的只是一个窄而完整的 gameplay 闭环。

## 建议的直播推进顺序

1. 先展示 MoonBit 如何从 `game/utils` 导入 `getTicks`。
2. 再展示 MoonBit 如何把 `main_loop` 导出成 JS 的 `loop`。
3. 接着补 `getObjectsByPrototype(Creep)` 和 `getObjectsByPrototype(Source)`。
4. 再让一个 creep 实现走向 source 并 harvest。
5. 如果时间允许，再往上加 spawn 逻辑。

## 当前最值得做的下一步

直接实现一个很小的第一版包结构：

- `raw.mbt`：extern 声明
- `api.mbt`：20 到 30 行左右的游戏逻辑
- `main/`：保留为最终导出桥接层

做到这一步，就足够把整条工具链在直播前验证通了。

## 当前项目结构调整（2026-04-04）

这一轮调整后，项目结构改为：

- `raw.mbt`
  只保留当前 tutorial 和 harvest bot 立刻需要的最小原始绑定。
- `api.mbt`
  在 raw 之上提供更接近 MoonBit 使用方式的封装。
- `main/`
  作为最终导出入口，不再使用原来的 `cmd/main` 结构。
- `EXPLORATION.md`
  持续追加探索记录、坑点和阶段性结论。

后续策略改为：

1. 不提前做完整 binding。
2. 一边过 tutorial，一边按需扩展 `raw.mbt`。
3. 尽量把直播真正要展示的逻辑放在 `api.mbt` 这一层。

## tutorial 实测补充（2026-04-04）

### 1. Loop and import

这一关已经本地验证通过。

有两个实践结论：

1. 生成的 `main.js` 可以直接拷贝成 Screeps Arena tutorial 目录下的 `main.mjs` 使用。
2. 不一定要手写 `console.log`，直接使用 MoonBit 的 `println("Current tick: \\{get_ticks()}")` 也可以在游戏里正常运行。

这说明：

- MoonBit 生成出来的 JS 模块形式，已经满足 Screeps Arena tutorial 对入口文件的要求。
- 第一关直播时可以把重点放在 `#module("game/utils")` 和 `loop` 导出上，不必纠结输出方式一定要和教程原文逐字一致。

### 2. Simple move

这一关目前采用的分层约定是：

1. `raw.mbt`

   只新增这关第一次出现的原始概念：

   - `Flag` external type
   - `flag_ctor()`
   - `flags() -> Array[Flag]`

   同时把原始 JS API 明确标成 `*_raw` 风格，例如：

   - `Creep::move_to_raw(self, target : GameObject) -> Int`
   - `Creep::harvest_raw(self, target : Source) -> Int`

   这样 raw 层只表达“JS 实际返回什么”，不负责美化接口。

2. `api.mbt`

   不再放 `first_creep()`、`first_flag()` 这种 tutorial 特定 helper，
   而是放更可复用的语义层：

   - `GameObjectLike` trait
   - `ActionResult`
   - `Creep::move_to(target) -> Unit`
   - `Creep::move_to_result(target) -> ActionResult`

   这样带来的好处是：

   - 主流程里不再出现 `as_any()`
   - 主流程里不再直接处理裸 `Int` 错误码
   - `Flag`、`Source`、`StructureSpawn` 都可以自然传给 `move_to`
   - 更适合后面用模式匹配写 bot 决策

3. `main/`

   只保留当前 tutorial 的实际演示逻辑，并直接使用数组模式匹配：

   ```moonbit
   pub fn main_loop() -> Unit {
     guard @screeps.creeps() is [creep, ..] else { return }
     guard @screeps.flags() is [flag, ..] else { return }
     creep.move_to(flag)
   }
   ```

这一层拆分比较适合后续继续推进 tutorial：

- 新的 Screeps 原始对象和方法先放 `raw`
- 更符合 MoonBit 直觉的 trait、enum、wrapper 放 `api`
- 当前关卡特定的流程放 `main`

### 3. 一个当前工具链坑：ES module 的 class 值导入

在 Screeps Arena 里，`getObjectsByPrototype` 需要传入类似 `Creep`、`Flag` 这样的 class 值。

直觉上最想写的是：

```moonbit
#module("game/prototypes")
extern "js" fn creep_ctor() -> @core.Any = "Creep"
```

但当前 MoonBit JS 后端会把它生成为“调用 `Creep()`”，从而在运行时报错：

```text
TypeError: Class constructor Creep cannot be invoked without 'new'
```

把它改成：

```moonbit
#module("game/prototypes")
extern "js" fn creep_ctor() -> @core.Any =
  #| () => Creep
```

在当前工具链下也不可用，生成结果会出现错误的 import 语法。

因此，当前项目里先采用一个稳定 workaround：

1. 绑定 `getObjects()`
2. 通过 `object.constructor.name` 过滤出 `Creep` / `Flag` / `Source` / `StructureSpawn`

也就是：

```moonbit
#module("game/utils")
extern "js" fn get_objects_ffi() -> Array[@core.Any] = "getObjects"

extern "js" fn object_type_name(object : @core.Any) -> String =
  #| (object) => object?.constructor?.name ?? ""
```

这条路的优点是：

- 当前可稳定运行
- 不再依赖 MoonBit 对“导入 class 值”的支持细节
- 足够支撑 tutorial 和直播前期的 binding

缺点是：

- 语义上不如直接调用 `getObjectsByPrototype(Creep)` 那么干净
- 依赖运行时 class name 稳定

后续如果找到 MoonBit 更正式的 ES module class-value 导入方式，再回头把这层换回去。

### 4. First attack 的分层

第三关 `First attack` 继续沿用“raw 忠实、api 语义化、main 只写流程”的结构。

1. `raw.mbt`

   只新增：

   - `Creep::attack_raw(self, target : GameObject) -> Int`

   也就是说 raw 层仍然只反映 JS 原始接口：接收目标，返回错误码。

2. `api.mbt`

   这一关没有直接把 `attack` 做成接受任意 `GameObjectLike`，
   而是单独引入了：

   - `AttackTarget` trait
   - `Creep::attack_result(target) -> ActionResult`
   - `Creep::attack(target) -> Unit`
   - `enemy_creeps() -> Array[Creep]`

   这样做的原因是：

   - `move_to` 的目标集合和 `attack` 的目标集合并不相同
   - 如果让 `attack` 直接接受任意 `GameObjectLike`，类型会过宽
   - 单独引入 `AttackTarget` 更符合“接口语义”

   当前先只给 `Creep` 实现 `AttackTarget`，等后面绑定 `Structure`、`ConstructionSite` 时再补上。

3. `main/`

   主流程保持很薄：

   ```moonbit
   pub fn main_loop() -> Unit {
     guard @screeps.my_creeps() is [my_creep, ..] else { return }
     guard @screeps.enemy_creeps() is [enemy_creep, ..] else { return }
     match my_creep.attack_result(enemy_creep) {
       NotInRange => my_creep.move_to(enemy_creep)
       Success => ()
       Error(_) => ()
     }
   }
   ```

这一层的代码风格已经比最开始那版更接近我们想要的方向：

- 不直接暴露裸错误码
- 不在主流程里出现 `as_any()`
- 用 trait 表达“什么对象可以拿来干什么”
- 用模式匹配表达 Screeps 行为分支

### 5. 正式 binding 设计草案

如果后面要把这个项目继续做成更正式的 Screeps Arena binding，
目前更推荐的方向不是“直接把 external type 暴露给用户”，而是：

```text
raw JS type
  -> MoonBit wrapper
  -> 更细化的 typed view
```

也就是：

1. `raw`

   只放最底层 JS FFI：

   - `JsGameObject`
   - `JsCreep`
   - `JsSource`
   - `JsFlag`
   - `JsStructureSpawn`

   以及这类原始方法：

   - `JsCreep::my() -> Bool`
   - `JsCreep::attack(target : JsGameObject) -> Int`
   - `JsCreep::move_to(target : JsGameObject) -> Int`

   raw 层只表达“JS 真实接口长什么样”，不负责语义包装。

2. `model`

   在 raw 之上提供 MoonBit wrapper，例如：

   ```moonbit
   pub struct Creep {
     raw : JsCreep
     relation : Relation
   }
   ```

   其中关系字段建议使用枚举，而不是直接存多个布尔值：

   ```moonbit
   pub enum Relation {
     Mine
     Enemy
     Neutral
   }
   ```

   对 `Creep` 来说当前 Arena 基本只有 `Mine` / `Enemy`，
   但统一用 `Relation` 更适合后面扩到 `Flag` 之类可中立的对象。

3. `api`

   在 wrapper 之上继续提供更高层的 typed view，例如：

   - `MyCreep`
   - `EnemyCreep`

   以及：

   - `my_creeps() -> Array[MyCreep]`
   - `enemy_creeps() -> Array[EnemyCreep]`
   - `MyCreep::attack(target : EnemyCreep) -> ActionResult`
   - `MyCreep::move_to(target : MoveTarget) -> ActionResult`

这样做的好处是：

- 普通业务代码不需要接触 `JsCreep`
- 很多“不是我的 creep 却拿去执行动作”的情况可以被类型系统提前挡掉
- 主流程 API 会更自然

例如最终用户代码更接近：

```moonbit
pub fn main_loop() -> Unit {
  guard @screeps.my_creeps() is [me, ..] else { return }
  guard @screeps.enemy_creeps() is [enemy, ..] else { return }
  match me.attack(enemy) {
    NotInRange => ignore(me.move_to(enemy))
    Success => ()
    Error(_) => ()
  }
}
```

#### 为什么不推荐直接存很多 `is_xxx`

像下面这种想法：

```moonbit
struct Creep {
  obj : JsCreep
  is_my : Bool
  is_enemy : Bool
}
```

方向是对的，因为它已经开始把 JS 原始对象包成 MoonBit wrapper 了。
但正式设计里更推荐：

1. 不存 `is_my` + `is_enemy` 这种冗余布尔组合
2. 改存单一的 `relation : Relation`

原因是：

- 更不容易出现无效状态
- 语义更集中
- 更容易扩展到 `Neutral`

同时，也不建议把太多动态状态都缓存到 wrapper 里，例如：

- `hits`
- `store`
- `fatigue`
- `spawning`

这些值变化很快，更适合作为 getter 从 `raw` 里实时读取。

也就是说，wrapper 更适合作为“带语义的 live view”，
而不是“一次性拍下来的静态快照”。

#### 当前推荐的正式分层结论

如果后面真的进入正式 binding 阶段，推荐采用：

```text
JsCreep
  -> Creep
  -> MyCreep / EnemyCreep
```

配合：

- `Relation`
- `ActionResult`
- `MoveTarget` / `AttackTarget` / `TransferTarget` 这类目标 trait

这是目前看下来最平衡的一条路线：

- 比直接暴露 external type 更安全
- 比只做单一 wrapper 更有表达力
- 比堆很多 `is_xxx` 布尔字段更容易长期维护

### 6. Creeps bodies 的分层

第四关 `Creeps bodies` 主要新增了三个点：

- 读取 `creep.body`
- 读取 `hits` / `hitsMax`
- 调用 `rangedAttack` 和 `heal`

这一关继续沿用“raw 忠实、api 语义化、main 只写流程”的结构。

1. `raw.mbt`

   只补原始形状，不提前做过强抽象：

   - `CreepBodyPart` external type
   - `Creep::body() -> Array[CreepBodyPart]`
   - `CreepBodyPart::part_type() -> String`
   - `Creep::hits() -> Int`
   - `Creep::hits_max() -> Int`
   - `Creep::ranged_attack_raw(...) -> Int`
   - `Creep::heal_raw(...) -> Int`

   同时把教程里会用到的 body part 常量补成字符串常量：

   - `ATTACK_PART`
   - `RANGED_ATTACK_PART`
   - `HEAL_PART`

2. `api.mbt`

   这一关没有直接把 `body` 暴露成 tutorial 逻辑里的裸数组判断，
   而是先补两个更顺手的 helper：

   - `Creep::has_body_part(part_type : String) -> Bool`
   - `Creep::is_damaged() -> Bool`

   再补对应动作结果封装：

   - `RangedAttackTarget` trait
   - `Creep::ranged_attack_result(...) -> ActionResult`
   - `Creep::heal_result(...) -> ActionResult`

   这里把 `rangedAttack` 单独拆成 `RangedAttackTarget`，
   而不是偷懒复用 `AttackTarget`，是因为它们未来允许的目标集合并不完全一致。

3. `main/`

   主流程只表达这一关真正想展示的 bot 决策：

   - 有 `ATTACK` 就近战攻击
   - 有 `RANGED_ATTACK` 就远程攻击
   - 有 `HEAL` 就优先治疗己方受伤 creep
   - 如果动作返回 `NotInRange`，就补一个 `move_to`

   这比直接在 `main` 里写一串裸 `Int` 错误码判断更适合直播展示，
   也更符合 MoonBit 侧想强调的模式匹配和清晰分层。

### 7. Body part 的正式抽象方向

当前 `body part` 仍然保留为字符串常量，例如：

- `ATTACK_PART`
- `RANGED_ATTACK_PART`
- `HEAL_PART`

这是因为目前 `raw.mbt` 还在刻意保持“贴近 JS 真实接口”的风格。
对 tutorial 推进来说，这种形式足够直接，也更方便快速验证。

但如果后面进入更正式的 binding 阶段，`body part` 很适合进一步抽象成 MoonBit enum。

推荐方向如下：

```moonbit
pub enum BodyPartKind {
  Move
  Carry
  Work
  Attack
  RangedAttack
  Heal
  Tough
}
```

并补两类转换：

```moonbit
fn BodyPartKind::to_raw(self) -> String
fn body_part_kind_of(raw : String) -> BodyPartKind?
```

这样之后，API 层就可以从：

```moonbit
pub fn Creep::has_body_part(self : Creep, part_type : String) -> Bool
```

收紧成：

```moonbit
pub fn Creep::has_body_part(self : Creep, kind : BodyPartKind) -> Bool
```

上层代码也会自然很多，例如：

```moonbit
fn melee_creeps(creeps : Array[Creep]) -> Array[Creep] {
  creeps.filter(creep => creep.has_body_part(Attack))
}
```

如果再往前走一步，还可以把原始 `body` 数组也包成更有语义的结构：

```moonbit
pub struct BodyPart {
  kind : BodyPartKind
  hits : Int
}

pub fn Creep::body_parts(self : Creep) -> Array[BodyPart]
```

这样做的好处是：

- 主流程里不再暴露字符串常量
- 更适合用模式匹配处理不同 body part
- 更符合 MoonBit 想展示的类型建模风格

当前推荐的落点是：

1. `raw` 继续保留字符串，不做过早包装
2. `api` 层新增 `BodyPartKind`
3. `main` 和 bot 逻辑只使用 enum，不直接碰字符串

也就是说，这个方向是可行的，而且很适合后续把教程代码进一步整理成更有 MoonBit 风格的版本；
只是现在还不急着改代码，先把设计记录下来。

### 8. Tower、Container 和资源搬运的分层

这一关主要新增四类能力：

- `StructureTower`
- `StructureContainer`
- `Creep::withdraw`
- `Tower::attack`

以及一个很实际的问题：

- tutorial 原文里通过 `store[RESOURCE_ENERGY]` 直接读取能量

当前实现里，这一关继续保持“raw 忠实、api 收束语义、main 只表达流程”的结构。

1. `raw.mbt`

   这一层新增：

   - `StructureTower`
   - `StructureContainer`
   - `towers()`
   - `containers()`
   - `Creep::withdraw_raw(...)`
   - `StructureTower::attack_raw(...)`
   - `StructureTower::store()`
   - `StructureContainer::store()`

   也就是说 raw 层仍然只关心“底层 JS 对象长什么样、方法怎么调”。

2. `api.mbt`

   这一关把目标类型进一步收紧了，而不是继续偷懒复用 `GameObjectLike`：

   - `TransferTarget`
   - `WithdrawTarget`
   - `TowerAttackTarget`

   对应高层方法为：

   - `Creep::transfer_energy_result(...)`
   - `Creep::withdraw_energy_result(...)`
   - `StructureTower::attack_result(...)`

   这样做的原因是：

   - `transfer`、`withdraw`、`tower.attack` 的合法目标集合并不相同
   - 如果都压成一个宽泛的 `GameObjectLike`，类型会越来越松
   - 后面继续补结构类型时，更容易沿着语义分层扩展

3. `Store` 的能量读取

   tutorial 原文使用：

   ```js
   store[RESOURCE_ENERGY]
   ```

   当前 MoonBit 实现里没有直接复刻这个动态索引写法，而是先收成：

   ```moonbit
   pub fn Store::energy(self : Store) -> Int
   ```

   底层仍然来自 `getUsedCapacity("energy")`，但上层代码会更整洁，
   也更符合当前 tutorial 的实际需求。

4. `main/`

   主流程继续沿用“命名视图 + 明确动作”的风格：

   - `towers_needing_energy`
   - `empty_creeps`
   - `loaded_creeps`
   - `energy_containers`
   - `refill_tower`
   - `defend_with_tower`

   这样一来，`main_loop` 读起来更像：

   - 如果塔缺能量，就做补能
   - 否则，让塔攻击敌方 creep

这一层的代码虽然和 tutorial 原文不逐字相同，但语义上是等价的，
而且更接近我们想要的 MoonBit 风格。

#### 一个更适合直播讲解的后续方向：把“模式”抽成 enum

这一关的 `main_loop` 本质上其实是在做一个很简单的二选一决策：

- 塔缺能量：补能
- 塔不缺能量：攻击

如果后面想把这段代码进一步整理成更适合展示 MoonBit 模式匹配的形式，
一个自然的方向是把这个“模式”显式抽成 enum，例如：

```moonbit
enum TowerMode {
  Refill(StructureTower)
  Defend(StructureTower)
}
```

然后把主流程拆成两步：

1. `decide_tower_mode(towers) -> TowerMode?`
2. `match` 这个结果执行对应动作

大致会长成：

```moonbit
match decide_tower_mode(towers) {
  Some(Refill(tower)) => refill_tower(tower, my_creeps, containers)
  Some(Defend(tower)) => defend_with_tower(tower, enemy_creeps)
  None => ()
}
```

这样做的价值不在于性能，而在于：

- 更容易把“先决策、后执行”的结构讲清楚
- 更适合直播里展示 MoonBit 的模式匹配
- 代码语义比简单的 `if/else` 更显式

当前先不改实现，只把这个方向记下来，后面如果要把 tutorial 代码再 MoonBit 化一层，可以优先考虑这条线。
