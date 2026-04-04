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
