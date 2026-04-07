import { createConstructionSite } from "game/utils";
import { StructureTower } from "game/prototypes";
import { loop as moonbitLoop } from "./moonbit-main.mjs";

// 当前这层 wrapper 只负责把 `StructureTower` 这个 class token 注入给 MoonBit。
globalThis.__moonbit_create_tower_site = (x, y) =>
  createConstructionSite({ x, y }, StructureTower).object;

export function loop() {
  moonbitLoop();
}
