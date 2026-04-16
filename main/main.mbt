///|
using @screeps {
  type BodyPartKind,
  type ConstructionSite,
  type MyCreep,
  type MySpawn,
  type Source,
}

///|
let worker_body : Array[BodyPartKind] = [Work, Carry, Move, Move]

///|
fn creep_action(
  creep : MyCreep,
  construction_site : ConstructionSite,
  sources : Array[Source],
) -> Unit {
  if creep.store().used(@screeps.Energy) > 0 {
    creep.build_or_move(construction_site)
  } else {
    guard creep.find_closest(sources) is Some(source) else { return }
    creep.harvest_or_move(source)
  }
}

///|
fn spawn_action(spawn : MySpawn) -> Unit {
  match spawn.spawning() {
    None => ignore(spawn.spawn_creep(worker_body))
    Some(_) => ()
  }
}

///|
pub fn main_loop() -> Unit {
  guard @screeps.my_spawns() is [spawn, ..] else { return }
  spawn_action(spawn)
  guard @screeps.my_construction_sites() is [construction_site, ..] else {
    return
  }
  let sources = @screeps.sources()
  let my_creeps = @screeps.my_creeps()
  my_creeps.each(creep => creep_action(creep, construction_site, sources))
}

///|
fn main {

}
