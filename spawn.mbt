///|
/// spawn 当前进行中的孵化任务观察视图。
pub struct Spawning {
  priv raw : @raw.JsSpawning
}

///|
/// 从 raw spawning 构造高层视图。通常下游无需直接调用。
pub fn Spawning::create(raw : @raw.JsSpawning) -> Spawning {
  Spawning::{ raw, }
}

///|
/// 返回底层 raw spawning 句柄。通常下游无需直接调用。
pub fn Spawning::to_raw(self : Spawning) -> @raw.JsSpawning {
  self.raw
}

///|
/// 返回这次孵化总共需要的时间。
pub fn Spawning::need_time(self : Spawning) -> Int {
  self.raw.need_time()
}

///|
/// 返回当前剩余的孵化时间。
pub fn Spawning::remaining_time(self : Spawning) -> Int {
  self.raw.remaining_time()
}

///|
/// 返回当前正在被孵化的 creep。
pub fn Spawning::creep(self : Spawning) -> Creep {
  Creep::create(self.raw.creep())
}

///|
/// StructureSpawn 的通用观察视图。
pub struct StructureSpawn {
  priv raw : @raw.JsStructureSpawn
  priv relation : Relation
}

///|
/// 己方 spawn 的强约束视图。
pub struct MySpawn {
  priv raw : @raw.JsStructureSpawn
}

///|
/// 敌方 spawn 的强约束视图。
pub struct EnemySpawn {
  priv raw : @raw.JsStructureSpawn
}

///|
/// 从 raw spawn 构造通用 spawn 视图。通常下游无需直接调用。
pub fn StructureSpawn::create(raw : @raw.JsStructureSpawn) -> StructureSpawn {
  StructureSpawn::{ raw, relation: relation_of_my_flag(raw.my().to_option()) }
}

///|
/// 从 raw spawn 构造己方 spawn 视图。通常下游无需直接调用。
pub fn MySpawn::create(raw : @raw.JsStructureSpawn) -> MySpawn {
  MySpawn::{ raw, }
}

///|
/// 从 raw spawn 构造敌方 spawn 视图。通常下游无需直接调用。
pub fn EnemySpawn::create(raw : @raw.JsStructureSpawn) -> EnemySpawn {
  EnemySpawn::{ raw, }
}

///|
/// 返回底层 raw spawn 句柄。通常下游无需直接调用。
pub fn StructureSpawn::to_raw(self : StructureSpawn) -> @raw.JsStructureSpawn {
  self.raw
}

///|
/// 返回底层 raw spawn 句柄。通常下游无需直接调用。
pub fn MySpawn::to_raw(self : MySpawn) -> @raw.JsStructureSpawn {
  self.raw
}

///|
/// 返回底层 raw spawn 句柄。通常下游无需直接调用。
pub fn EnemySpawn::to_raw(self : EnemySpawn) -> @raw.JsStructureSpawn {
  self.raw
}

///|
/// 将 spawn 转成通用 `GameObject` 视图。
pub fn StructureSpawn::as_game_object(self : StructureSpawn) -> GameObject {
  GameObject::create(self.raw.to_game_object())
}

///|
/// 将己方 spawn 转成通用 `GameObject` 视图。
pub fn MySpawn::as_game_object(self : MySpawn) -> GameObject {
  GameObject::create(self.raw.to_game_object())
}

///|
/// 将敌方 spawn 转成通用 `GameObject` 视图。
pub fn EnemySpawn::as_game_object(self : EnemySpawn) -> GameObject {
  GameObject::create(self.raw.to_game_object())
}

///|
/// 返回 spawn 的敌我关系。
pub fn StructureSpawn::relation(self : StructureSpawn) -> Relation {
  self.relation
}

///|
/// 返回固定为己方的敌我关系。
pub fn MySpawn::relation(_self : MySpawn) -> Relation {
  Mine
}

///|
/// 返回固定为敌方的敌我关系。
pub fn EnemySpawn::relation(_self : EnemySpawn) -> Relation {
  Enemy
}

///|
/// 返回该 spawn 是否属于己方。
pub fn StructureSpawn::is_my(self : StructureSpawn) -> Bool {
  self.relation == Mine
}

///|
/// 返回该 spawn 是否属于敌方。
pub fn StructureSpawn::is_enemy(self : StructureSpawn) -> Bool {
  self.relation == Enemy
}

///|
/// 返回 `true`，表示这是己方 spawn 视图。
pub fn MySpawn::is_my(_self : MySpawn) -> Bool {
  true
}

///|
/// 返回 `false`，表示这不是敌方 spawn 视图。
pub fn MySpawn::is_enemy(_self : MySpawn) -> Bool {
  false
}

///|
/// 返回 `false`，表示这不是己方 spawn 视图。
pub fn EnemySpawn::is_my(_self : EnemySpawn) -> Bool {
  false
}

///|
/// 返回 `true`，表示这是敌方 spawn 视图。
pub fn EnemySpawn::is_enemy(_self : EnemySpawn) -> Bool {
  true
}

///|
/// 若当前 spawn 属于己方，则转成 `MySpawn` 视图。
pub fn StructureSpawn::as_my(self : StructureSpawn) -> MySpawn? {
  if self.relation == Mine {
    Some(MySpawn::{ raw: self.raw })
  } else {
    None
  }
}

///|
/// 若当前 spawn 属于敌方，则转成 `EnemySpawn` 视图。
pub fn StructureSpawn::as_enemy(self : StructureSpawn) -> EnemySpawn? {
  if self.relation == Enemy {
    Some(EnemySpawn::{ raw: self.raw })
  } else {
    None
  }
}

///|
/// 将己方 spawn 放宽成通用 `StructureSpawn` 视图。
pub fn MySpawn::as_structure_spawn(self : MySpawn) -> StructureSpawn {
  StructureSpawn::{ raw: self.raw, relation: Mine }
}

///|
/// 将敌方 spawn 放宽成通用 `StructureSpawn` 视图。
pub fn EnemySpawn::as_structure_spawn(self : EnemySpawn) -> StructureSpawn {
  StructureSpawn::{ raw: self.raw, relation: Enemy }
}

///|
/// 返回 spawn 的唯一 id。
pub fn StructureSpawn::id(self : StructureSpawn) -> String {
  self.as_game_object().id()
}

///|
/// 返回己方 spawn 的唯一 id。
pub fn MySpawn::id(self : MySpawn) -> String {
  self.as_game_object().id()
}

///|
/// 返回敌方 spawn 的唯一 id。
pub fn EnemySpawn::id(self : EnemySpawn) -> String {
  self.as_game_object().id()
}

///|
/// 返回 spawn 当前的 x 坐标。
pub fn StructureSpawn::x(self : StructureSpawn) -> Int {
  self.as_game_object().x()
}

///|
/// 返回己方 spawn 当前的 x 坐标。
pub fn MySpawn::x(self : MySpawn) -> Int {
  self.as_game_object().x()
}

///|
/// 返回敌方 spawn 当前的 x 坐标。
pub fn EnemySpawn::x(self : EnemySpawn) -> Int {
  self.as_game_object().x()
}

///|
/// 返回 spawn 当前的 y 坐标。
pub fn StructureSpawn::y(self : StructureSpawn) -> Int {
  self.as_game_object().y()
}

///|
/// 返回己方 spawn 当前的 y 坐标。
pub fn MySpawn::y(self : MySpawn) -> Int {
  self.as_game_object().y()
}

///|
/// 返回敌方 spawn 当前的 y 坐标。
pub fn EnemySpawn::y(self : EnemySpawn) -> Int {
  self.as_game_object().y()
}

///|
/// 返回 spawn 当前是否仍存在于场上。
pub fn StructureSpawn::exists(self : StructureSpawn) -> Bool {
  self.as_game_object().exists()
}

///|
/// 返回己方 spawn 当前是否仍存在于场上。
pub fn MySpawn::exists(self : MySpawn) -> Bool {
  self.as_game_object().exists()
}

///|
/// 返回敌方 spawn 当前是否仍存在于场上。
pub fn EnemySpawn::exists(self : EnemySpawn) -> Bool {
  self.as_game_object().exists()
}

///|
/// 返回 spawn 的存储视图。
pub fn StructureSpawn::store(self : StructureSpawn) -> Store {
  Store::create(self.raw.store())
}

///|
/// 返回己方 spawn 的存储视图。
pub fn MySpawn::store(self : MySpawn) -> Store {
  Store::create(self.raw.store())
}

///|
/// 返回敌方 spawn 的存储视图。
pub fn EnemySpawn::store(self : EnemySpawn) -> Store {
  Store::create(self.raw.store())
}

///|
/// 返回 spawn 当前的孵化任务；若当前未在孵化，则返回 None。
pub fn StructureSpawn::spawning(self : StructureSpawn) -> Spawning? {
  self.raw.spawning().to_option().map(Spawning::create)
}

///|
/// 返回己方 spawn 当前的孵化任务；若当前未在孵化，则返回 None。
pub fn MySpawn::spawning(self : MySpawn) -> Spawning? {
  self.raw.spawning().to_option().map(Spawning::create)
}

///|
/// 返回敌方 spawn 当前的孵化任务；若当前未在孵化，则返回 None。
pub fn EnemySpawn::spawning(self : EnemySpawn) -> Spawning? {
  self.raw.spawning().to_option().map(Spawning::create)
}

///|
/// 返回 spawn 当前生命值。
pub fn StructureSpawn::hits(self : StructureSpawn) -> Int {
  self.raw.hits()
}

///|
/// 返回己方 spawn 当前生命值。
pub fn MySpawn::hits(self : MySpawn) -> Int {
  self.raw.hits()
}

///|
/// 返回敌方 spawn 当前生命值。
pub fn EnemySpawn::hits(self : EnemySpawn) -> Int {
  self.raw.hits()
}

///|
/// 返回 spawn 最大生命值。
pub fn StructureSpawn::hits_max(self : StructureSpawn) -> Int {
  self.raw.hits_max()
}

///|
/// 返回己方 spawn 最大生命值。
pub fn MySpawn::hits_max(self : MySpawn) -> Int {
  self.raw.hits_max()
}

///|
/// 返回敌方 spawn 最大生命值。
pub fn EnemySpawn::hits_max(self : EnemySpawn) -> Int {
  self.raw.hits_max()
}
