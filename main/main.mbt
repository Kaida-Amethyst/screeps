///|
using @screeps {
  type BodyPartKind,
  type MyCreep,
  type EnemyCreep,
  type Source,
  type MySpawn,
}

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
fn choose_source(creep : MyCreep, sources : Array[Source]) -> Source? {
  creep.find_closest(sources, by=Range)
}

///|
fn choose_enemy(creep : MyCreep, enemies : Array[EnemyCreep]) -> EnemyCreep? {
  creep.find_closest(enemies, by=Range)
}

///|
fn run_worker(
  creep : MyCreep,
  sources : Array[Source],
  spawn : MySpawn,
) -> Unit {
  if creep.store().free_energy() > 0 {
    guard choose_source(creep, sources) is Some(source) else { return }
    creep.harvest_or_move(source)
  } else {
    creep.transfer_energy_or_move(spawn)
  }
}

///|
fn run_fighter(creep : MyCreep, enemies : Array[EnemyCreep]) -> Unit {
  guard choose_enemy(creep, enemies) is Some(enemy) else { return }
  creep.attack_or_move(enemy)
}

///|
fn try_spawn_worker(spawn : MySpawn) -> Unit {
  ignore(spawn.spawn_creep(worker_body()))
}

///|
fn try_spawn_fighter(spawn : MySpawn) -> Unit {
  let heavy_result = spawn.spawn_creep(heavy_fighter_body())
  match heavy_result {
    Spawned(_) => ()
    SpawnFailed(NotEnoughEnergy) =>
      ignore(spawn.spawn_creep(light_fighter_body()))
    SpawnFailed(_) => ()
  }
}

///|
fn run_spawn_logic(
  spawn : MySpawn,
  my_creeps : Array[MyCreep],
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
  guard @screeps.my_spawns() is [spawn, ..] else { return }
  let my_creeps = @screeps.my_creeps()
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
