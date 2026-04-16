# Screeps Arena 的 MoonBit Binding

这个项目提供了一套面向 Screeps Arena 的 MoonBit binding，目标是让你用 MoonBit 编写 bot 逻辑，再编译成 JavaScript，接入 Screeps Arena 运行。

目前项目包含：

- 面向 Screeps Arena 的正式 MoonBit API
- 一个固定的 `main.mjs` wrapper，用来补宿主环境 glue
- 可直接用于 Screeps Arena 的 `moonbit-main.mjs + main.mjs` 运行流程

## 如何使用

### 1. 安装包

在你的 MoonBit 项目里执行：

```bash
moon add Kaida-Amethyst/screeps
```

然后确保你的 `moon.mod.json` 里启用了 JS 目标：

```json
{
  ...
  "preferred-target": "js"
}
```

### 2. 添加 `main.mjs`

把下面这段代码保存成 `main.mjs`：

```javascript
import { getObjectsByPrototype, createConstructionSite } from "game/utils";
import {
  ConstructionSite,
  Creep,
  Flag,
  Source,
  StructureContainer,
  StructureExtension,
  StructureRampart,
  StructureRoad,
  StructureSpawn,
  Structure,
  StructureTower,
  StructureWall,
} from "game/prototypes";
import { loop as moonbitLoop } from "./moonbit-main.mjs";

const prototypeTable = {
  ConstructionSite,
  Creep,
  Flag,
  Source,
  StructureContainer,
  StructureExtension,
  StructureRampart,
  StructureRoad,
  Structure,
  StructureSpawn,
  StructureTower,
  StructureWall,
};

globalThis.__moonbit_screeps_host = globalThis.__moonbit_screeps_host ?? {};

globalThis.__moonbit_screeps_host.getObjectsByPrototypeName = (name) => {
  const prototype = prototypeTable[name];
  if (!prototype) {
    throw new Error(`Unknown Screeps prototype: ${name}`);
  }
  return getObjectsByPrototype(prototype);
};

globalThis.__moonbit_screeps_host.createConstructionSiteByPrototypeName = (
  pos,
  name,
) => {
  const prototype = prototypeTable[name];
  if (!prototype) {
    throw new Error(`Unknown Screeps prototype: ${name}`);
  }
  return createConstructionSite(pos, prototype);
};

export function loop() {
  moonbitLoop();
}
```

### 3. 编写 MoonBit 逻辑并构建

完成你的 MoonBit bot 逻辑后，执行：

```bash
moon build
```

构建完成后，把生成出来的 JS 和 `main.mjs` 一起拷贝到 Screeps Arena 实际运行脚本的目录。

例如：

```bash
cp _build/js/debug/build/main/main.js /path/to/ScreepsArena/moonbit-main.mjs
cp main.mjs /path/to/ScreepsArena/main.mjs
```

请把上面的 `/path/to/ScreepsArena/` 替换成你自己实际运行 `main.mjs` 的目录。

### 4. 在 Screeps Arena 中运行

完成拷贝后，就可以在 Screeps Arena 中加载这两个文件并尝试运行你的 bot。

当前推荐的约定是：

- `moonbit-main.mjs`：MoonBit 编译生成的主逻辑
- `main.mjs`：宿主环境 wrapper，并对外导出最终 `loop`

## Tutorial

### 1. Loop and import

第一关的目标很简单：调用 `get_ticks()`，然后用 MoonBit 的 `println` 打印当前 tick。

这一关需要注意两件事：

- `main` 包需要通过 `moon.pkg` 把 MoonBit 函数导出成 Screeps 需要的 `loop`
- `main/main.mbt` 里的 `fn main` 需要保持空实现，真正的逻辑放在导出的函数里

#### `main/moon.pkg`

`main/moon.pkg` 需要像这样配置：

```moonbit nocheck
import {
  "Kaida-Amethyst/screeps",
}

options(
  "is-main": true,
  link: { "js": { "exports": [ "main_loop:loop" ] } },
)
```

这里的意思是：

- 这个包是一个 `is-main` 包
- MoonBit 里的 `main_loop` 会被导出成 JavaScript 侧的 `loop`

#### `main/main.mbt`

然后在 `main/main.mbt` 里实现：

```moonbit nocheck
///|
pub fn main_loop() -> Unit {
  println(@screeps.get_ticks())
}

///|
fn main {

}
```

这里有一个关键点：

- `fn main` 保持空实现
- Screeps 实际调用的是 `main_loop`

这样可以避免模块加载时就执行额外副作用，把真正的每 tick 逻辑放到导出的 `loop` 里。

#### 构建与拷贝

写完之后执行：

```bash
moon build
```

然后把生成的主逻辑和 `main.mjs` wrapper 一起拷贝到 Screeps Arena 的运行目录：

```bash
cp _build/js/debug/build/main/main.js /path/to/ScreepsArena/moonbit-main.mjs
cp main.mjs /path/to/ScreepsArena/main.mjs
```

把 `/path/to/ScreepsArena/` 替换成你自己的实际目录。

完成后，就可以在 Screeps Arena 中加载并运行，效果等价于：

```javascript
import { getTicks } from "game/utils";

export function loop() {
  console.log("Current tick:", getTicks());
}
```

只是这里我们用的是 MoonBit 的：

- `@screeps.get_ticks()`
- `println(...)`

### 2. Simple Move

第二关的目标是：

- 取出场上的 creep
- 取出场上的 flag
- 让第一只 creep 朝第一个 flag 移动

Screeps 的 sample code 是：

```javascript
import { getObjectsByPrototype } from "game/utils";
import { Creep, Flag } from "game/prototypes";

export function loop() {
  var creeps = getObjectsByPrototype(Creep);
  var flags = getObjectsByPrototype(Flag);
  creeps[0].moveTo(flags[0]);
}
```

用现在这套 MoonBit binding，可以写成：

```moonbit nocheck
///|
pub fn main_loop() -> Unit {
  guard @screeps.my_creeps() is [creep, ..] else { return }
  guard @screeps.flags() is [flag, ..] else { return }
  creep.move_to(flag) |> ignore
}

///|
fn main {

}
```

代码的意思是：

- `@screeps.my_creeps()`：拿到己方 creep 列表，注意这里与sample code的区别是，sample code这里实际上得到的全部的creep，而我们这里是得到的所有己方的creep。
- `@screeps.flags()`：拿到 flag 列表
- `creep.move_to(flag)`：让 creep 朝 flag 移动

这段 MoonBit 代码里多出来的部分主要是两点：

- `guard ... else { return }`
  这用来处理“当前没有 creep”或者“当前没有 flag”的情况，避免直接访问空数组。
- `|> ignore`
  `move_to` 会返回一个动作结果，但这一关我们只关心“发出移动指令”，所以把返回值忽略掉即可。

### 3. First Attack

第三关的目标是：

- 找到一只己方 creep
- 找到一只敌方 creep
- 尝试攻击敌方 creep
- 如果敌人不在攻击范围内，就朝它移动

Screeps 的 sample code 是：

```javascript
import { getObjectsByPrototype } from "game/utils";
import { Creep } from "game/prototypes";
import { ERR_NOT_IN_RANGE } from "game/constants";

export function loop() {
  var myCreep = getObjectsByPrototype(Creep).find((creep) => creep.my);
  var enemyCreep = getObjectsByPrototype(Creep).find((creep) => !creep.my);
  if (myCreep.attack(enemyCreep) == ERR_NOT_IN_RANGE) {
    myCreep.moveTo(enemyCreep);
  }
}
```

用现在这套 MoonBit binding，可以写成：

```moonbit nocheck
///|
pub fn main_loop() -> Unit {
  guard @screeps.my_creeps() is [my_creep, ..] else { return }
  guard @screeps.enemy_creeps() is [enemy_creep, ..] else { return }
  my_creep.attack_or_move(enemy_creep)
}

///|
fn main {

}
```

这里和原始 JS sample 的对应关系是：

- `@screeps.my_creeps()`：拿到己方 creep 列表
- `@screeps.enemy_creeps()`：拿到敌方 creep 列表
- `my_creep.attack_or_move(enemy_creep)`：先尝试攻击；如果不在范围内，就自动移动过去

和第二关相比，这一关的重点是：

- 我们不再直接自己匹配 `ERR_NOT_IN_RANGE`
- 而是使用库里已经提供好的 convenience helper：`attack_or_move`

它把这段常见逻辑收起来了：

- 先调用 `attack`
- 如果结果是 `NotInRange`
- 再补一个 `move_to`

所以主循环里看到的代码会更短，也更接近“我要做什么”这层意图。 

### 4. Creep Bodies

第四关的目标是：

- 找到所有己方 creep
- 找到一只敌方 creep
- 根据 creep 身上的 body part，不同职责地执行动作
  - 有 `ATTACK` 的 creep 负责近战攻击
  - 有 `RANGED_ATTACK` 的 creep 负责远程攻击
  - 有 `HEAL` 的 creep 负责治疗己方伤员

Screeps 的 sample code 是：

```javascript
import { getObjectsByPrototype } from "game/utils";
import { Creep } from "game/prototypes";
import { ERR_NOT_IN_RANGE, ATTACK, RANGED_ATTACK, HEAL } from "game/constants";

export function loop() {
  var myCreeps = getObjectsByPrototype(Creep).filter((creep) => creep.my);
  var enemyCreep = getObjectsByPrototype(Creep).find((creep) => !creep.my);

  for (var creep of myCreeps) {
    if (creep.body.some((bodyPart) => bodyPart.type == ATTACK)) {
      if (creep.attack(enemyCreep) == ERR_NOT_IN_RANGE) {
        creep.moveTo(enemyCreep);
      }
    }
    if (creep.body.some((bodyPart) => bodyPart.type == RANGED_ATTACK)) {
      if (creep.rangedAttack(enemyCreep) == ERR_NOT_IN_RANGE) {
        creep.moveTo(enemyCreep);
      }
    }
    if (creep.body.some((bodyPart) => bodyPart.type == HEAL)) {
      var myDamagedCreeps = myCreeps.filter((i) => i.hits < i.hitsMax);
      if (myDamagedCreeps.length > 0) {
        if (creep.heal(myDamagedCreeps[0]) == ERR_NOT_IN_RANGE) {
          creep.moveTo(myDamagedCreeps[0]);
        }
      }
    }
  }
}
```

用现在这套 MoonBit binding，可以写成：

```moonbit nocheck
///|
pub fn main_loop() -> Unit {
  let my_creeps = @screeps.my_creeps()
  guard @screeps.enemy_creeps() is [enemy_creep, ..] else { return }
  let damaged_creeps = my_creeps.filter(creep => creep.hp() < creep.max_hp())
  let melee_creeps = my_creeps.filter(creep => {
    creep.has_body_part(@screeps.Attack)
  })
  let healers = my_creeps.filter(creep => creep.has_body_part(@screeps.Heal))
  let ranged_creeps = my_creeps.filter(creep => {
    creep.has_body_part(@screeps.RangedAttack)
  })

  for creep in melee_creeps {
    creep.attack_or_move(enemy_creep)
  }

  for creep in ranged_creeps {
    creep.ranged_attack_or_move(enemy_creep)
  }

  if damaged_creeps is [damaged_creep, ..] {
    for creep in healers {
      creep.heal_or_move(damaged_creep)
    }
  }
}

///|
fn main {

}
```

这段 MoonBit 代码的结构和 sample code 是一致的，只是写法更偏 MoonBit 风格：

- `my_creeps.filter(creep => creep.has_body_part(@screeps.Attack))`
  对应 JS 里的 `creep.body.some(bodyPart => bodyPart.type == ATTACK)`
- `creep.attack_or_move(enemy_creep)`
  对应 “先攻击，不在范围内就移动”
- `creep.ranged_attack_or_move(enemy_creep)`
  对应 “先远程攻击，不在范围内就移动”
- `creep.heal_or_move(damaged_creep)`
  对应 “先治疗，不在范围内就移动”

这一关有两个比较关键的点：

- body part 在正式 binding 里已经被收成了 `BodyPartKind`，所以这里直接用 `@screeps.Attack / Heal / RangedAttack`
- 代码结构上按职责拆成了三段循环：
  - `melee_creeps`
  - `ranged_creeps`
  - `healers`

这样会比“单个大循环里套很多 `if`”更清楚，也更适合后面继续扩展 bot 行为。 

### 5. Store and transfer

第五关的目标是：

- 先检查塔里的能量够不够
- 如果塔的能量不足，就让己方 creep 去补能量
- 如果 creep 自己没有能量，就先去 container 取能量
- 如果塔的能量已经够了，就让塔攻击敌方 creep

Screeps 的 sample code 是：

```javascript
import { prototypes, utils, constants } from "game";

export function loop() {
  const tower = utils.getObjectsByPrototype(prototypes.StructureTower)[0];
  if (tower.store[constants.RESOURCE_ENERGY] < 10) {
    var myCreep = utils
      .getObjectsByPrototype(prototypes.Creep)
      .find((creep) => creep.my);
    if (myCreep.store[constants.RESOURCE_ENERGY] == 0) {
      var container = utils.getObjectsByPrototype(prototypes.StructureContainer)[0];
      myCreep.withdraw(container, constants.RESOURCE_ENERGY);
    } else {
      myCreep.transfer(tower, constants.RESOURCE_ENERGY);
    }
  } else {
    var target = utils
      .getObjectsByPrototype(prototypes.Creep)
      .find((creep) => !creep.my);
    tower.attack(target);
  }
}
```

用现在这套 MoonBit binding，可以写成：

```moonbit nocheck
///|
pub fn main_loop() -> Unit {
  guard @screeps.my_towers() is [tower, ..] else { return }
  guard @screeps.my_creeps() is [my_creep, ..] else { return }
  guard @screeps.containers() is [container, ..] else { return }
  guard @screeps.enemy_creeps() is [target, ..] else { return }

  if tower.store().energy() >= 10 {
    tower.attack(target) |> ignore
    return
  }

  match my_creep.store().energy() {
    0 => my_creep.withdraw_energy_or_move(container)
    _ => my_creep.transfer_energy_or_move(tower)
  }
}

///|
fn main {

}
```

这段 MoonBit 代码对应的逻辑是：

- `@screeps.my_towers()`：拿到己方 tower
- `tower.store().energy()`：读取 tower 当前储存的能量
- `@screeps.my_creeps()`：拿到己方 creep
- `@screeps.containers()`：拿到 container
- `@screeps.enemy_creeps()`：拿到敌方 creep，作为 tower 的攻击目标

主循环的判断顺序是：

- 如果 `tower.store().energy() >= 10`
  说明塔的能量已经够了，这时直接让塔攻击敌人，然后 `return`
- 否则说明塔还缺能量，需要让 creep 参与补给
- 如果 `my_creep.store().energy()` 是 `0`
  就说明 creep 身上没能量，需要先去 container 取能量
- 如果不为 `0`
  就说明 creep 身上已经带着能量，可以直接把能量送给 tower

这里有两个地方和原始 JS sample 相比更偏 MoonBit 风格：

- `store[RESOURCE_ENERGY]` 被整理成了 `store().energy()`
- `withdraw(...)` / `transfer(...)` 再加上“如果不在范围内就移动”的逻辑，被整理成了：
  - `withdraw_energy_or_move(container)`
  - `transfer_energy_or_move(tower)`

这样主循环里保留的是“这一 tick 打算做什么”，而不是把每个动作的细节都展开写一遍。 

### 6. Terrain

第六关的目标是：

- 取出所有己方 creep
- 取出所有 flag
- 对每一只 creep，都找到一面按路径距离最近的 flag
- 然后让 creep 朝那面 flag 移动

Screeps 的 sample code 是：

```javascript
import { getObjectsByPrototype } from "game/utils";
import { Creep, Flag } from "game/prototypes";

export function loop() {
  var creeps = getObjectsByPrototype(Creep).filter((i) => i.my);
  var flags = getObjectsByPrototype(Flag);
  for (var creep of creeps) {
    var flag = creep.findClosestByPath(flags);
    creep.moveTo(flag);
  }
}
```

用现在这套 MoonBit binding，可以写成：

```moonbit nocheck
///|
pub fn main_loop() -> Unit {
  let flags = @screeps.flags()
  for creep in @screeps.my_creeps() {
    guard creep.find_closest(flags) is Some(flag) else { continue }
    creep.move_to(flag) |> ignore
  }
}

///|
fn main {

}
```

这段 MoonBit 代码和 sample code 的对应关系是：

- `@screeps.my_creeps()`：拿到所有己方 creep
- `@screeps.flags()`：拿到所有 flag
- `creep.find_closest(flags)`：从这组 flag 里，找出对当前 creep 来说最近的目标
- `creep.move_to(flag) |> ignore`：让 creep 朝找到的 flag 移动

这一关最关键的点是 `find_closest`：

- 它对应 JS 里的 `findClosestByPath`
- 默认使用的是 `Path` 这套距离度量
- 所以这里不用额外写 `by=Path`

如果以后你想按直线距离来找最近目标，也可以显式写成：

```moonbit nocheck
creep.find_closest(flags, by=Range)
```

但这一关和原始 sample code 对应的，就是默认的按路径寻找最近目标。

另外，这里用了：

- `guard creep.find_closest(flags) is Some(flag) else { continue }`

意思是：

- 如果这一只 creep 能找到最近的 flag，就继续执行移动
- 如果当前没有可用的 flag，就跳过这一只 creep，处理下一只

这样可以避免直接对空结果调用 `move_to`。 

### 7. Spawn creeps

第七关的目标是：

- 先拿到己方的 spawn
- 拿到场上的 flags
- 如果当前 creep 数量还不够，就继续 spawn 新 creep
- 已经出生的 creep 按顺序走向对应的 flag

Screeps 的 sample code 是：

```javascript
import { getObjectsByPrototype } from "game/utils";
import { Creep, Flag, StructureSpawn } from "game/prototypes";
import { MOVE } from "game/constants";

var creep1, creep2;

export function loop() {
  var mySpawn = getObjectsByPrototype(StructureSpawn)[0];
  var flags = getObjectsByPrototype(Flag);

  if (!creep1) {
    creep1 = mySpawn.spawnCreep([MOVE]).object;
  } else {
    creep1.moveTo(flags[0]);

    if (!creep2) {
      creep2 = mySpawn.spawnCreep([MOVE]).object;
    } else {
      creep2.moveTo(flags[1]);
    }
  }
}
```

用现在这套 MoonBit binding，可以写成：

```moonbit nocheck
///|
pub fn main_loop() -> Unit {
  guard @screeps.my_spawns() is [my_spawn, ..] else { return }

  let flags = @screeps.flags()
  let creeps = @screeps.my_creeps()

  let num_of_flags = flags.length()
  let num_of_creeps = creeps.length()

  if num_of_creeps < num_of_flags {
    my_spawn.spawn_creep([Move]) |> ignore
  }

  for i in 0..<min(num_of_creeps, num_of_flags) {
    creeps[i].move_to(flags[i]) |> ignore
  }
}

///|
fn min(a : Int, b : Int) -> Int {
  match a < b {
    true => a
    false => b
  }
}

///|
fn main {

}
```

这段 MoonBit 代码和 sample code 的核心逻辑是一致的，只是写法更通用：

- `@screeps.my_spawns()`：拿到己方 spawn
- `@screeps.flags()`：拿到所有 flag
- `@screeps.my_creeps()`：拿到已经出生的所有己方 creep
- `my_spawn.spawn_creep([Move]) |> ignore`：生成一个只带 `MOVE` body part 的 creep

这版代码没有像 sample code 那样显式维护 `creep1` 和 `creep2` 两个变量，而是换成了更通用的写法：

- 如果 `num_of_creeps < num_of_flags`
  就说明当前 creep 数量还不够，需要继续 spawn
- 然后用
  `for i in 0..<min(num_of_creeps, num_of_flags)`
  把已经存在的 creep 和 flags 按顺序配对

所以这里的含义就是：

- 第 `0` 个 creep 去第 `0` 个 flag
- 第 `1` 个 creep 去第 `1` 个 flag
- 以此类推

这种写法比直接写死 `creep1 / creep2` 更适合后面继续扩展，也更接近真正 bot 代码里常见的“按集合和索引分配目标”的写法。 

### 8. Harvest energy

第八关的目标是：

- 找到一只己方 creep
- 找到一个 source
- 找到己方 spawn
- 如果 creep 还有空余容量，就去采集能量
- 如果 creep 已经装满了，就把能量送回 spawn

Screeps 的 sample code 是：

```javascript
import { prototypes, utils, constants } from "game";

export function loop() {
  var creep = utils.getObjectsByPrototype(prototypes.Creep).find((i) => i.my);
  var source = utils.getObjectsByPrototype(prototypes.Source)[0];
  var spawn = utils
    .getObjectsByPrototype(prototypes.StructureSpawn)
    .find((i) => i.my);

  if (creep.store.getFreeCapacity(constants.RESOURCE_ENERGY)) {
    if (creep.harvest(source) == constants.ERR_NOT_IN_RANGE) {
      creep.moveTo(source);
    }
  } else {
    if (creep.transfer(spawn, constants.RESOURCE_ENERGY) == constants.ERR_NOT_IN_RANGE) {
      creep.moveTo(spawn);
    }
  }
}
```

用现在这套 MoonBit binding，可以写成：

```moonbit nocheck
///|
pub fn main_loop() -> Unit {
  guard @screeps.my_creeps() is [creep, ..] else { return }
  guard @screeps.sources() is [source, ..] else { return }
  guard @screeps.my_spawns() is [spawn, ..] else { return }

  match creep.store().free_energy() {
    0 => creep.transfer_energy_or_move(spawn)
    _ => creep.harvest_or_move(source)
  }
}

///|
fn main {

}
```

这段 MoonBit 代码和 sample code 的对应关系是：

- `@screeps.my_creeps()`：拿到己方 creep
- `@screeps.sources()`：拿到 source
- `@screeps.my_spawns()`：拿到己方 spawn
- `creep.store().free_energy()`：读取 creep 还剩多少能量容量

这里的 `match` 逻辑可以直接理解成：

- `0`
  表示 creep 已经没有空余容量了，这时应该把能量送回 spawn
- `_`
  表示 creep 还有空位，这时继续去 source 采集能量

对应的动作分别是：

- `creep.transfer_energy_or_move(spawn)`
- `creep.harvest_or_move(source)`

这两个 helper 做的事情和前几关是一致的：

- 先尝试执行动作
- 如果目标不在范围内，就自动移动过去

所以这一关的主循环写出来会非常短，重点只剩下“当前该采集，还是该回送”这个判断。 

### 9. Construction

第九关的目标是：

- 找到一只己方 creep
- 如果 creep 身上没有能量，就去最近的 container 取能量
- 如果 creep 身上有能量，就寻找己方 construction site
- 如果还没有 construction site，就先创建一个 tower 的工地
- 如果已经有工地，就去建造它

Screeps 的 sample code 是：

```javascript
import { prototypes, utils } from "game";
import { RESOURCE_ENERGY, ERR_NOT_IN_RANGE } from "game/constants";

export function loop() {
  const creep = utils.getObjectsByPrototype(prototypes.Creep).find((i) => i.my);
  if (!creep.store[RESOURCE_ENERGY]) {
    const container = utils.findClosestByPath(
      creep,
      utils.getObjectsByPrototype(prototypes.StructureContainer),
    );
    if (creep.withdraw(container, RESOURCE_ENERGY) == ERR_NOT_IN_RANGE) {
      creep.moveTo(container);
    }
  } else {
    const constructionSite = utils
      .getObjectsByPrototype(prototypes.ConstructionSite)
      .find((i) => i.my);
    if (!constructionSite) {
      utils.createConstructionSite(50, 55, prototypes.StructureTower);
    } else {
      if (creep.build(constructionSite) == ERR_NOT_IN_RANGE) {
        creep.moveTo(constructionSite);
      }
    }
  }
}
```

用现在这套 MoonBit binding，可以写成：

```moonbit nocheck
///|
pub fn main_loop() -> Unit {
  guard @screeps.my_creeps() is [creep, ..] else { return }
  let containers = @screeps.containers()

  if creep.store().energy() == 0 {
    if creep.find_closest(containers) is Some(container) {
      creep.withdraw_energy_or_move(container) |> ignore
    }
    return
  }

  match @screeps.my_construction_sites() {
    [construction_site, ..] => creep.build_or_move(construction_site)
    _ => @screeps.create_construction_site(50, 55, Tower) |> ignore
  }
}

///|
fn main {

}
```

这段 MoonBit 代码和 sample code 的对应关系是：

- `@screeps.my_creeps()`：拿到己方 creep
- `@screeps.containers()`：拿到所有 container
- `creep.find_closest(containers)`：找到对当前 creep 来说最近的 container
- `creep.withdraw_energy_or_move(container)`：先尝试取能量，不在范围内就移动过去
- `@screeps.my_construction_sites()`：拿到己方 construction site
- `creep.build_or_move(construction_site)`：先尝试建造，不在范围内就移动过去
- `@screeps.create_construction_site(50, 55, Tower)`：在指定坐标创建一个 tower 工地

这关的主流程可以拆成两段：

- 第一段先判断 creep 身上有没有能量
- 第二段再决定是“创建工地”还是“建造已有工地”

具体来说：

- 如果 `creep.store().energy() == 0`
  就说明现在要先补充能量
- 这时通过 `creep.find_closest(containers)` 找到最近的 container
- 找到之后调用 `withdraw_energy_or_move(container)`，把“取能量或移动过去”这层逻辑收起来

如果 creep 身上已经有能量，那么就进入建造阶段：

- 如果 `@screeps.my_construction_sites()` 里已经有工地
  就直接 `build_or_move`
- 如果还没有工地
  就调用 `create_construction_site(50, 55, Tower)` 先放下一个 tower 工地

这一关和前面几关相比，多了两个关键点：

- 最近目标查询不只是能用于找 flag，也可以直接用来找最近的 container
- `create_construction_site(...)` 这类创建型操作，也已经被正式 binding 收成了高层接口

所以这关本质上是在把“找资源 -> 建工地 -> 施工”这条基础建造链路串起来。 

### 10. Final test

最后一关没有单独的 sample code，更像是把前面几关的能力拼起来，写出一个能真正活下来的小 bot。

这一关当前直接使用 `main/main.mbt` 里的实现：

```moonbit nocheck
///|
using @screeps {
  type BodyPartKind,
  type MyCreep,
  type EnemyCreep,
  type Source,
  type MySpawn,
}

///|
let worker_body : Array[BodyPartKind] = [Work, Carry, Move]

///|
let light_fighter_body : Array[BodyPartKind] = [Attack, Move]

///|
let heavy_fighter_body : Array[BodyPartKind] = [Attack, Attack, Move, Move]

///|
fn is_worker(creep : MyCreep) -> Bool {
  creep.store().capacity(@screeps.Energy) > 0
}

///|
fn workers(creeps : Array[MyCreep]) -> Array[MyCreep] {
  creeps.filter(is_worker)
}

///|
fn fighters(creeps : Array[MyCreep]) -> Array[MyCreep] {
  creeps.filter(creep => !is_worker(creep))
}

///|
fn worker_action(
  creep : MyCreep,
  sources : Array[Source],
  spawn : MySpawn,
) -> Unit {
  if creep.store().free_energy() > 0 {
    guard creep.find_closest(sources, by=Range) is Some(source) else { return }
    creep.harvest_or_move(source)
  } else {
    creep.transfer_energy_or_move(spawn)
  }
}

///|
fn fighter_action(creep : MyCreep, enemies : Array[EnemyCreep]) -> Unit {
  guard creep.find_closest(enemies, by=Range) is Some(enemy) else { return }
  creep.attack_or_move(enemy)
}

///|
fn spawn_worker_if_possible(spawn : MySpawn) -> Unit {
  ignore(spawn.spawn_creep(worker_body))
}

///|
fn spawn_fighter_if_possible(spawn : MySpawn) -> Unit {
  let heavy_result = spawn.spawn_creep(heavy_fighter_body)
  match heavy_result {
    Spawned(_) => ()
    SpawnFailed(SpawnNotEnoughEnergy) =>
      spawn.spawn_creep(light_fighter_body) |> ignore
    SpawnFailed(_) => ()
  }
}

///|
enum SpawnRole {
  Worker
  Fighter
}

///|
fn next_spawn_role(my_creeps : Array[MyCreep]) -> SpawnRole {
  let worker_count = workers(my_creeps).length()
  let fighter_count = fighters(my_creeps).length()
  if worker_count == 0 {
    Worker
  } else if fighter_count == 0 {
    Fighter
  } else if worker_count < 2 {
    Worker
  } else {
    Fighter
  }
}

///|
fn spawn_action(spawn : MySpawn, my_creeps : Array[MyCreep]) -> Unit {
  match next_spawn_role(my_creeps) {
    Worker => spawn_worker_if_possible(spawn)
    Fighter => spawn_fighter_if_possible(spawn)
  }
}

///|
fn fallback_sources() -> Array[Source] {
  let live_sources = @screeps.active_sources()

  match live_sources.is_empty() {
    true => @screeps.sources()
    false => live_sources
  }
}

///|
pub fn main_loop() -> Unit {
  guard @screeps.my_spawns() is [spawn, ..] else { return }
  let my_creeps = @screeps.my_creeps()
  let enemies = @screeps.enemy_creeps()
  let sources = fallback_sources()
  spawn_action(spawn, my_creeps)
  workers(my_creeps).each(creep => worker_action(creep, sources, spawn))
  fighters(my_creeps).each(creep => fighter_action(creep, enemies))
}

///|
fn main {

}
```

这一版 final test 的思路很直接：把我方单位分成两类。

- `worker`
  负责采矿和回送能量
- `fighter`
  负责找最近的敌人并追上去攻击

对应的 body 也分成了三种：

- `worker_body = [Work, Carry, Move]`
- `light_fighter_body = [Attack, Move]`
- `heavy_fighter_body = [Attack, Attack, Move, Move]`

其中 `worker` 和 `fighter` 的区分方式也很简单：

- 如果一个 creep 的 `store().capacity(Energy) > 0`
  就把它当成 `worker`
- 否则就把它当成 `fighter`

也就是说，这里不是额外记录“职业标签”，而是直接根据 body 结构来判断单位职责。

`worker_action` 负责经济循环：

- 如果 creep 身上还有空余容量
  就找最近的 source，然后 `harvest_or_move`
- 如果已经装满
  就把能量送回 spawn，调用 `transfer_energy_or_move`

这里特意用了：

- `creep.find_closest(sources, by=Range)`

也就是按直线距离找最近的 source。  
这样写的原因很简单：这一关里 source 选择主要只是为了快速找到一个最近资源点，按 `Range` 就够了。

`fighter_action` 则更简单：

- 找最近的敌人
- `attack_or_move`

同样，这里也用了 `by=Range`，让 fighter 先锁定一个最近敌人，然后一路追过去。

spawn 的逻辑是这关最核心的策略部分。这里先定义了：

- `SpawnRole = Worker | Fighter`

然后通过 `next_spawn_role` 来决定下一个应该补什么单位。

规则是：

- 如果还没有 worker，先补 worker
- 如果还没有 fighter，先补 fighter
- 如果 worker 少于 `2`，继续补 worker
- 其余情况补 fighter

这背后的想法是：

- 先确保经济能运转
- 再确保有基本战斗力
- 然后维持一个比较朴素的“2 个 worker + 持续补 fighter”的节奏

`spawn_fighter_if_possible` 里还多了一层小策略：

- 先尝试生成 `heavy_fighter_body`
- 如果失败原因是 `SpawnNotEnoughEnergy`
  就退一步生成 `light_fighter_body`

这样做的好处是：

- 能量够的时候，尽量上更强的近战单位
- 能量暂时不够的时候，也不会什么都不做，而是先出一个轻量 fighter

最后的 `main_loop` 就比较清楚了：

- 先拿到 `spawn`
- 再拿到当前所有己方 creep、敌方 creep、可用 source
- 先执行一次 `spawn_action`
- 然后让所有 worker 跑经济逻辑
- 所有 fighter 跑战斗逻辑

也就是说，这个 final test 本质上是把前面几关学到的这些能力全部串起来：

- `spawn_creep`
- `harvest_or_move`
- `transfer_energy_or_move`
- `find_closest`
- `attack_or_move`

最后得到一个能自己出兵、自己采矿、自己打人的最小可用 bot。 
