///|
/// 当前游戏已运行的 tick 数。
pub fn get_ticks() -> Int {
  @raw.get_ticks()
}

///|
/// 通过唯一 id 获取正式高层 `GameObject` 视图。
pub fn object_by_id(id : String) -> GameObject? {
  @raw.get_object_by_id(id).map(GameObject::create)
}

///|
/// 返回当前场上的全部 flag。
pub fn flags() -> Array[Flag] {
  @raw.flags().map(Flag::create)
}

///|
/// 返回当前场上的全部 creep 观察视图。
pub fn creeps() -> Array[Creep] {
  @raw.creeps().map(Creep::create)
}

///|
/// 返回当前全部己方 creep 的强约束视图。
pub fn my_creeps() -> Array[MyCreep] {
  creeps().filter_map(creep => creep.as_my())
}

///|
/// 返回当前全部敌方 creep 的强约束视图。
pub fn enemy_creeps() -> Array[EnemyCreep] {
  creeps().filter_map(creep => creep.as_enemy())
}

///|
/// 返回当前场上的全部 source。
pub fn sources() -> Array[Source] {
  @raw.sources().map(Source::create)
}

///|
/// 返回当前仍有能量可采集的 source。
pub fn active_sources() -> Array[Source] {
  sources().filter(source => source.energy() > 0)
}

///|
/// 返回当前场上的全部通用结构观察视图。
pub fn structures() -> Array[Structure] {
  @raw.structures().map(Structure::create)
}

///|
/// 返回当前场上的全部 spawn 通用视图。
pub fn spawns() -> Array[StructureSpawn] {
  @raw.spawns().map(StructureSpawn::create)
}

///|
/// 返回当前全部己方 spawn 的强约束视图。
pub fn my_spawns() -> Array[MySpawn] {
  spawns().filter_map(spawn => spawn.as_my())
}

///|
/// 返回当前全部敌方 spawn 的强约束视图。
pub fn enemy_spawns() -> Array[EnemySpawn] {
  spawns().filter_map(spawn => spawn.as_enemy())
}

///|
/// 返回当前场上的全部 tower 通用视图。
pub fn towers() -> Array[StructureTower] {
  @raw.towers().map(StructureTower::create)
}

///|
/// 返回当前全部己方 tower 的强约束视图。
pub fn my_towers() -> Array[MyTower] {
  towers().filter_map(tower => tower.as_my())
}

///|
/// 返回当前全部敌方 tower 的强约束视图。
pub fn enemy_towers() -> Array[EnemyTower] {
  towers().filter_map(tower => tower.as_enemy())
}

///|
/// 返回当前场上的全部 container。
pub fn containers() -> Array[StructureContainer] {
  @raw.containers().map(StructureContainer::create)
}

///|
/// 返回当前场上的全部 construction site。
pub fn construction_sites() -> Array[ConstructionSite] {
  @raw.construction_sites().map(ConstructionSite::create)
}

///|
/// 返回当前全部己方 construction site。
pub fn my_construction_sites() -> Array[ConstructionSite] {
  construction_sites().filter(site => site.is_my())
}
