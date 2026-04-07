///|
/// Screeps 的导出入口。
/// 当前切到第八个 tutorial：Harvest energy。
using @screeps {type Creep, type Source, type StructureSpawn}

///|
fn run_harvester(
  creep : Creep,
  source : Source,
  spawn : StructureSpawn,
) -> Unit {
  if creep.store().free_energy() > 0 {
    if creep.harvest_result(source) is @screeps.NotInRange {
      creep.move_to(source)
    }
    return
  }
  if creep.transfer_energy_result(spawn) is @screeps.NotInRange {
    creep.move_to(spawn)
  }
}

///|
pub fn main_loop() -> Unit {
  guard @screeps.my_creeps() is [creep, ..] else { return }
  guard @screeps.sources() is [source, ..] else { return }
  guard @screeps.my_spawns() is [spawn, ..] else { return }
  run_harvester(creep, source, spawn)
}

///|
fn main {

}
