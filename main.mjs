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
