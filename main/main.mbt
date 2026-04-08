
using @screeps { type BodyPartKind, trait MoveTarget, type OwnedCreep, type ActionError, type EnemyCreep, type Source, type OwnedSpawn }

///|
fn worker_body() -> Array[BodyPartKind] {
  [Work, Carry, Move]
}

///|
fn heavy_fighter_body() -> Array[BodyPartKind] {
  [Attack, Attack, Move, Move]
}

///|
fn light_fighter_body() -> Array[@screeps.BodyPartKind] {
  [Attack, Move]
}

///|
fn is_worker(creep : OwnedCreep) -> Bool {
  creep.store().capacity(@screeps.Energy) > 0
}

///|
fn workers(creeps : Array[OwnedCreep]) -> Array[OwnedCreep] {
  creeps.filter(is_worker)
}

///|
fn fighters(creeps : Array[OwnedCreep]) -> Array[OwnedCreep] {
  creeps.filter(creep => !is_worker(creep))
}

///|
fn[T : MoveTarget] move_if_needed(
  creep : OwnedCreep,
  target : T,
  result : Result[Unit, ActionError],
) -> Unit {
  match result {
    Ok(_) => ()
    Err(NotInRange) => ignore(try? creep.move_to(target))
    Err(_) => ()
  }
}

///|
fn choose_source(
  creep : OwnedCreep,
  sources : Array[Source],
) -> Source? {
  creep.find_closest(sources, by=Range)
}

///|
fn choose_enemy(
  creep : OwnedCreep,
  enemies : Array[EnemyCreep],
) -> EnemyCreep? {
  creep.find_closest(enemies, by=Range)
}

///|
fn run_worker(
  creep : OwnedCreep,
  sources : Array[Source],
  spawn : OwnedSpawn,
) -> Unit {
  if creep.store().free_energy() > 0 {
    guard choose_source(creep, sources) is Some(source) else { return }
    let result = try? creep.harvest(source)
    move_if_needed(creep, source, result)
  } else {
    let result = try? creep.transfer_energy(spawn)
    move_if_needed(creep, spawn, result)
  }
}

///|
fn run_fighter(
  creep : OwnedCreep,
  enemies : Array[EnemyCreep],
) -> Unit {
  guard choose_enemy(creep, enemies) is Some(enemy) else { return }
  let result = try? creep.attack(enemy)
  move_if_needed(creep, enemy, result)
}

///|
fn try_spawn_worker(spawn : OwnedSpawn) -> Unit {
  ignore(try? spawn.spawn_creep(worker_body()))
}

///|
fn try_spawn_fighter(spawn : OwnedSpawn) -> Unit {
  let heavy_result = try? spawn.spawn_creep(heavy_fighter_body())
  match heavy_result {
    Ok(_) => ()
    Err(@screeps.ActionError::NotEnoughEnergy) =>
      ignore(try? spawn.spawn_creep(light_fighter_body()))
    Err(_) => ()
  }
}

///|
fn run_spawn_logic(
  spawn : OwnedSpawn,
  my_creeps : Array[OwnedCreep],
  enemies : Array[EnemyCreep],
) -> Unit {
  let worker_count = workers(my_creeps).length()
  let fighter_count = fighters(my_creeps).length()
  let enemy_count = enemies.length()
  if worker_count == 0 {
    try_spawn_worker(spawn)
  } else if fighter_count == 0 {
    try_spawn_fighter(spawn)
  } else if worker_count < 2 {
    try_spawn_worker(spawn)
  } else if fighter_count < enemy_count + 1 {
    try_spawn_fighter(spawn)
  } else {
    try_spawn_fighter(spawn)
  }
}

///|
fn fallback_sources() -> Array[Source] {
  let live_sources = @screeps.active_sources()
  if live_sources.is_empty() {
    @screeps.sources()
  } else {
    live_sources
  }
}

///|
pub fn main_loop() -> Unit {
  guard @screeps.owned_spawns() is [spawn, ..] else { return }
  let my_creeps = @screeps.owned_creeps()
  let enemies = @screeps.enemy_creeps()
  let sources = fallback_sources()
  run_spawn_logic(spawn, my_creeps, enemies)
  for creep in workers(my_creeps) {
    run_worker(creep, sources, spawn)
  }
  for creep in fighters(my_creeps) {
    run_fighter(creep, enemies)
  }
}

///|
fn main {

}
