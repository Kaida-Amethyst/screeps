///|
/// 当前游戏已运行的 tick 数。
pub fn ticks() -> Int {
  @raw.get_ticks()
}

///|
/// 通过 id 获取正式高层 `GameObject` 视图。
pub fn object_by_id(id : String) -> GameObject? {
  @raw.get_object_by_id(id).map(GameObject::create)
}

///|
pub fn creeps() -> Array[Creep] {
  @raw.creeps().map(Creep::create)
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
  @raw.sources().map(Source::create)
}

///|
pub fn active_sources() -> Array[Source] {
  sources().filter(source => source.energy() > 0)
}

///|
pub fn spawns() -> Array[StructureSpawn] {
  @raw.spawns().map(StructureSpawn::create)
}

///|
pub fn owned_spawns() -> Array[OwnedSpawn] {
  spawns().filter_map(spawn => spawn.as_owned())
}

///|
pub fn enemy_spawns() -> Array[EnemySpawn] {
  spawns().filter_map(spawn => spawn.as_enemy())
}

///|
pub fn towers() -> Array[StructureTower] {
  @raw.towers().map(StructureTower::create)
}

///|
pub fn owned_towers() -> Array[OwnedTower] {
  towers().filter_map(tower => tower.as_owned())
}

///|
pub fn enemy_towers() -> Array[EnemyTower] {
  towers().filter_map(tower => tower.as_enemy())
}

///|
pub fn containers() -> Array[StructureContainer] {
  @raw.containers().map(StructureContainer::create)
}

///|
pub fn construction_sites() -> Array[ConstructionSite] {
  @raw.construction_sites().map(ConstructionSite::create)
}

///|
pub fn owned_construction_sites() -> Array[ConstructionSite] {
  construction_sites().filter(site => site.is_owned())
}
