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
  - `melees`
  - `ranged`
  - `healers`

这样会比“单个大循环里套很多 `if`”更清楚，也更适合后面继续扩展 bot 行为。 
