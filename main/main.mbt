///|
/// Screeps 的导出入口。
/// 当前切到第五个 tutorial：Tower 补能与攻击。
using @screeps {type Creep, type StructureContainer, type StructureTower}

///|
fn towers_needing_energy(
  towers : Array[StructureTower],
) -> Array[StructureTower] {
  towers.filter(tower => tower.store().energy() < 10)
}

///|
fn empty_creeps(creeps : Array[Creep]) -> Array[Creep] {
  creeps.filter(creep => creep.store().energy() == 0)
}

///|
fn loaded_creeps(creeps : Array[Creep]) -> Array[Creep] {
  creeps.filter(creep => creep.store().energy() > 0)
}

///|
fn energy_containers(
  containers : Array[StructureContainer],
) -> Array[StructureContainer] {
  containers.filter(container => container.store().energy() > 0)
}

///|
fn refill_tower(
  tower : StructureTower,
  my_creeps : Array[Creep],
  containers : Array[StructureContainer],
) -> Unit {
  if loaded_creeps(my_creeps) is [carrier, ..] {
    ignore(carrier.transfer_energy_result(tower))
    return
  }
  guard empty_creeps(my_creeps) is [worker, ..] else { return }
  guard energy_containers(containers) is [container, ..] else { return }
  ignore(worker.withdraw_energy_result(container))
}

///|
fn defend_with_tower(
  tower : StructureTower,
  enemy_creeps : Array[Creep],
) -> Unit {
  guard enemy_creeps is [target, ..] else { return }
  tower.attack(target)
}

///|
pub fn main_loop() -> Unit {
  let towers = @screeps.towers()
  let my_creeps = @screeps.my_creeps()
  let containers = @screeps.containers()
  let enemy_creeps = @screeps.enemy_creeps()

  if towers_needing_energy(towers) is [tower, ..] {
    refill_tower(tower, my_creeps, containers)
    return
  }

  guard towers is [tower, ..] else { return }
  defend_with_tower(tower, enemy_creeps)
}

///|
fn main {

}
