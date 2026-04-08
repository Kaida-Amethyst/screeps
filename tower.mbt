///|
/// StructureTower 的通用观察视图。
pub struct StructureTower {
  priv raw : @raw.JsStructureTower
  priv relation : Relation
}

///|
/// 己方 tower 的强约束视图。
pub struct MyTower {
  priv raw : @raw.JsStructureTower
}

///|
/// 敌方 tower 的强约束视图。
pub struct EnemyTower {
  priv raw : @raw.JsStructureTower
}

///|
pub fn StructureTower::create(raw : @raw.JsStructureTower) -> StructureTower {
  StructureTower::{ raw, relation: relation_of_my_flag(raw.my().to_option()) }
}

///|
pub fn MyTower::create(raw : @raw.JsStructureTower) -> MyTower {
  MyTower::{ raw, }
}

///|
pub fn EnemyTower::create(raw : @raw.JsStructureTower) -> EnemyTower {
  EnemyTower::{ raw, }
}

///|
pub fn StructureTower::to_raw(self : StructureTower) -> @raw.JsStructureTower {
  self.raw
}

///|
pub fn MyTower::to_raw(self : MyTower) -> @raw.JsStructureTower {
  self.raw
}

///|
pub fn EnemyTower::to_raw(self : EnemyTower) -> @raw.JsStructureTower {
  self.raw
}

///|
pub fn StructureTower::as_game_object(self : StructureTower) -> GameObject {
  GameObject::create(self.raw.to_game_object())
}

///|
pub fn MyTower::as_game_object(self : MyTower) -> GameObject {
  GameObject::create(self.raw.to_game_object())
}

///|
pub fn EnemyTower::as_game_object(self : EnemyTower) -> GameObject {
  GameObject::create(self.raw.to_game_object())
}

///|
pub fn StructureTower::relation(self : StructureTower) -> Relation {
  self.relation
}

///|
pub fn MyTower::relation(_self : MyTower) -> Relation {
  Mine
}

///|
pub fn EnemyTower::relation(_self : EnemyTower) -> Relation {
  Enemy
}

///|
pub fn StructureTower::is_my(self : StructureTower) -> Bool {
  self.relation == Mine
}

///|
pub fn StructureTower::is_enemy(self : StructureTower) -> Bool {
  self.relation == Enemy
}

///|
pub fn MyTower::is_my(_self : MyTower) -> Bool {
  true
}

///|
pub fn MyTower::is_enemy(_self : MyTower) -> Bool {
  false
}

///|
pub fn EnemyTower::is_my(_self : EnemyTower) -> Bool {
  false
}

///|
pub fn EnemyTower::is_enemy(_self : EnemyTower) -> Bool {
  true
}

///|
pub fn StructureTower::as_my(self : StructureTower) -> MyTower? {
  if self.relation == Mine {
    Some(MyTower::{ raw: self.raw })
  } else {
    None
  }
}

///|
pub fn StructureTower::as_enemy(self : StructureTower) -> EnemyTower? {
  if self.relation == Enemy {
    Some(EnemyTower::{ raw: self.raw })
  } else {
    None
  }
}

///|
pub fn MyTower::as_structure_tower(self : MyTower) -> StructureTower {
  StructureTower::{ raw: self.raw, relation: Mine }
}

///|
pub fn EnemyTower::as_structure_tower(self : EnemyTower) -> StructureTower {
  StructureTower::{ raw: self.raw, relation: Enemy }
}

///|
pub fn StructureTower::id(self : StructureTower) -> String {
  self.as_game_object().id()
}

///|
pub fn MyTower::id(self : MyTower) -> String {
  self.as_game_object().id()
}

///|
pub fn EnemyTower::id(self : EnemyTower) -> String {
  self.as_game_object().id()
}

///|
pub fn StructureTower::x(self : StructureTower) -> Int {
  self.as_game_object().x()
}

///|
pub fn MyTower::x(self : MyTower) -> Int {
  self.as_game_object().x()
}

///|
pub fn EnemyTower::x(self : EnemyTower) -> Int {
  self.as_game_object().x()
}

///|
pub fn StructureTower::y(self : StructureTower) -> Int {
  self.as_game_object().y()
}

///|
pub fn MyTower::y(self : MyTower) -> Int {
  self.as_game_object().y()
}

///|
pub fn EnemyTower::y(self : EnemyTower) -> Int {
  self.as_game_object().y()
}

///|
pub fn StructureTower::exists(self : StructureTower) -> Bool {
  self.as_game_object().exists()
}

///|
pub fn MyTower::exists(self : MyTower) -> Bool {
  self.as_game_object().exists()
}

///|
pub fn EnemyTower::exists(self : EnemyTower) -> Bool {
  self.as_game_object().exists()
}

///|
pub fn StructureTower::store(self : StructureTower) -> Store {
  Store::create(self.raw.store())
}

///|
pub fn MyTower::store(self : MyTower) -> Store {
  Store::create(self.raw.store())
}

///|
pub fn EnemyTower::store(self : EnemyTower) -> Store {
  Store::create(self.raw.store())
}

///|
pub fn StructureTower::hits(self : StructureTower) -> Int {
  self.raw.hits()
}

///|
pub fn MyTower::hits(self : MyTower) -> Int {
  self.raw.hits()
}

///|
pub fn EnemyTower::hits(self : EnemyTower) -> Int {
  self.raw.hits()
}

///|
pub fn StructureTower::hits_max(self : StructureTower) -> Int {
  self.raw.hits_max()
}

///|
pub fn MyTower::hits_max(self : MyTower) -> Int {
  self.raw.hits_max()
}

///|
pub fn EnemyTower::hits_max(self : EnemyTower) -> Int {
  self.raw.hits_max()
}

///|
pub fn StructureTower::cooldown(self : StructureTower) -> Int {
  self.raw.cooldown()
}

///|
pub fn MyTower::cooldown(self : MyTower) -> Int {
  self.raw.cooldown()
}

///|
pub fn EnemyTower::cooldown(self : EnemyTower) -> Int {
  self.raw.cooldown()
}
