///|
/// spawn 当前进行中的孵化任务观察视图。
pub struct Spawning {
  priv raw : @raw.JsSpawning
}

///|
pub fn Spawning::create(raw : @raw.JsSpawning) -> Spawning {
  Spawning::{ raw, }
}

///|
pub fn Spawning::to_raw(self : Spawning) -> @raw.JsSpawning {
  self.raw
}

///|
pub fn Spawning::need_time(self : Spawning) -> Int {
  self.raw.need_time()
}

///|
pub fn Spawning::remaining_time(self : Spawning) -> Int {
  self.raw.remaining_time()
}

///|
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
pub fn StructureSpawn::create(raw : @raw.JsStructureSpawn) -> StructureSpawn {
  StructureSpawn::{ raw, relation: relation_of_my_flag(raw.my().to_option()) }
}

///|
pub fn MySpawn::create(raw : @raw.JsStructureSpawn) -> MySpawn {
  MySpawn::{ raw, }
}

///|
pub fn EnemySpawn::create(raw : @raw.JsStructureSpawn) -> EnemySpawn {
  EnemySpawn::{ raw, }
}

///|
pub fn StructureSpawn::to_raw(self : StructureSpawn) -> @raw.JsStructureSpawn {
  self.raw
}

///|
pub fn MySpawn::to_raw(self : MySpawn) -> @raw.JsStructureSpawn {
  self.raw
}

///|
pub fn EnemySpawn::to_raw(self : EnemySpawn) -> @raw.JsStructureSpawn {
  self.raw
}

///|
pub fn StructureSpawn::as_game_object(self : StructureSpawn) -> GameObject {
  GameObject::create(self.raw.to_game_object())
}

///|
pub fn MySpawn::as_game_object(self : MySpawn) -> GameObject {
  GameObject::create(self.raw.to_game_object())
}

///|
pub fn EnemySpawn::as_game_object(self : EnemySpawn) -> GameObject {
  GameObject::create(self.raw.to_game_object())
}

///|
pub fn StructureSpawn::relation(self : StructureSpawn) -> Relation {
  self.relation
}

///|
pub fn MySpawn::relation(_self : MySpawn) -> Relation {
  Mine
}

///|
pub fn EnemySpawn::relation(_self : EnemySpawn) -> Relation {
  Enemy
}

///|
pub fn StructureSpawn::is_my(self : StructureSpawn) -> Bool {
  self.relation == Mine
}

///|
pub fn StructureSpawn::is_enemy(self : StructureSpawn) -> Bool {
  self.relation == Enemy
}

///|
pub fn MySpawn::is_my(_self : MySpawn) -> Bool {
  true
}

///|
pub fn MySpawn::is_enemy(_self : MySpawn) -> Bool {
  false
}

///|
pub fn EnemySpawn::is_my(_self : EnemySpawn) -> Bool {
  false
}

///|
pub fn EnemySpawn::is_enemy(_self : EnemySpawn) -> Bool {
  true
}

///|
pub fn StructureSpawn::as_my(self : StructureSpawn) -> MySpawn? {
  if self.relation == Mine {
    Some(MySpawn::{ raw: self.raw })
  } else {
    None
  }
}

///|
pub fn StructureSpawn::as_enemy(self : StructureSpawn) -> EnemySpawn? {
  if self.relation == Enemy {
    Some(EnemySpawn::{ raw: self.raw })
  } else {
    None
  }
}

///|
pub fn MySpawn::as_structure_spawn(self : MySpawn) -> StructureSpawn {
  StructureSpawn::{ raw: self.raw, relation: Mine }
}

///|
pub fn EnemySpawn::as_structure_spawn(self : EnemySpawn) -> StructureSpawn {
  StructureSpawn::{ raw: self.raw, relation: Enemy }
}

///|
pub fn StructureSpawn::id(self : StructureSpawn) -> String {
  self.as_game_object().id()
}

///|
pub fn MySpawn::id(self : MySpawn) -> String {
  self.as_game_object().id()
}

///|
pub fn EnemySpawn::id(self : EnemySpawn) -> String {
  self.as_game_object().id()
}

///|
pub fn StructureSpawn::x(self : StructureSpawn) -> Int {
  self.as_game_object().x()
}

///|
pub fn MySpawn::x(self : MySpawn) -> Int {
  self.as_game_object().x()
}

///|
pub fn EnemySpawn::x(self : EnemySpawn) -> Int {
  self.as_game_object().x()
}

///|
pub fn StructureSpawn::y(self : StructureSpawn) -> Int {
  self.as_game_object().y()
}

///|
pub fn MySpawn::y(self : MySpawn) -> Int {
  self.as_game_object().y()
}

///|
pub fn EnemySpawn::y(self : EnemySpawn) -> Int {
  self.as_game_object().y()
}

///|
pub fn StructureSpawn::exists(self : StructureSpawn) -> Bool {
  self.as_game_object().exists()
}

///|
pub fn MySpawn::exists(self : MySpawn) -> Bool {
  self.as_game_object().exists()
}

///|
pub fn EnemySpawn::exists(self : EnemySpawn) -> Bool {
  self.as_game_object().exists()
}

///|
pub fn StructureSpawn::store(self : StructureSpawn) -> Store {
  Store::create(self.raw.store())
}

///|
pub fn MySpawn::store(self : MySpawn) -> Store {
  Store::create(self.raw.store())
}

///|
pub fn EnemySpawn::store(self : EnemySpawn) -> Store {
  Store::create(self.raw.store())
}

///|
pub fn StructureSpawn::spawning(self : StructureSpawn) -> Spawning? {
  self.raw.spawning().to_option().map(Spawning::create)
}

///|
pub fn MySpawn::spawning(self : MySpawn) -> Spawning? {
  self.raw.spawning().to_option().map(Spawning::create)
}

///|
pub fn EnemySpawn::spawning(self : EnemySpawn) -> Spawning? {
  self.raw.spawning().to_option().map(Spawning::create)
}

///|
pub fn StructureSpawn::hits(self : StructureSpawn) -> Int {
  self.raw.hits()
}

///|
pub fn MySpawn::hits(self : MySpawn) -> Int {
  self.raw.hits()
}

///|
pub fn EnemySpawn::hits(self : EnemySpawn) -> Int {
  self.raw.hits()
}

///|
pub fn StructureSpawn::hits_max(self : StructureSpawn) -> Int {
  self.raw.hits_max()
}

///|
pub fn MySpawn::hits_max(self : MySpawn) -> Int {
  self.raw.hits_max()
}

///|
pub fn EnemySpawn::hits_max(self : EnemySpawn) -> Int {
  self.raw.hits_max()
}
