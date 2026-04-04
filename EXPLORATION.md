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

3. `cmd/main`

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
- `cmd/main`：保留为最终导出桥接层

做到这一步，就足够把整条工具链在直播前验证通了。
