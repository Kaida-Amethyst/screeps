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
