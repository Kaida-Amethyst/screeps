///|
using @model {
  type Creep,
  type EnemyCreep,
  type EnemySpawn,
  type OwnedCreep,
  type OwnedSpawn,
  type Source,
  type StructureSpawn,
}

///|
/// 当前游戏已运行的 tick 数。
pub fn ticks() -> Int {
  @raw.get_ticks()
}

///|
pub fn creeps() -> Array[Creep] {
  @raw.creeps().map(@model.Creep::create)
}

///|
pub fn owned_creeps() -> Array[OwnedCreep] {
  creeps().filter_map(creep => creep.as_owned())
}

///|
pub fn enemy_creeps() -> Array[EnemyCreep] {
  creeps().filter_map(creep => creep.as_enemy())
}

///|
pub fn sources() -> Array[Source] {
  @raw.sources().map(@model.Source::create)
}

///|
pub fn active_sources() -> Array[Source] {
  sources().filter(source => source.energy() > 0)
}

///|
pub fn spawns() -> Array[StructureSpawn] {
  @raw.spawns().map(@model.StructureSpawn::create)
}

///|
pub fn owned_spawns() -> Array[OwnedSpawn] {
  spawns().filter_map(spawn => spawn.as_owned())
}

///|
pub fn enemy_spawns() -> Array[EnemySpawn] {
  spawns().filter_map(spawn => spawn.as_enemy())
}
