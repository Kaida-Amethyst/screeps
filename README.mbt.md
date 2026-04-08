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

tutorial 示例和逐步使用方式后续会继续补充到这里。
