///|
/// StructureSpawn 的通用观察视图。
pub struct StructureSpawn {
  priv raw : @raw.JsStructureSpawn
  priv relation : Relation
}

///|
/// 己方 spawn 的强约束视图。
pub struct OwnedSpawn {
  priv raw : @raw.JsStructureSpawn
}

///|
/// 敌方 spawn 的强约束视图。
pub struct EnemySpawn {
  priv raw : @raw.JsStructureSpawn
}

///|
pub fn StructureSpawn::create(raw : @raw.JsStructureSpawn) -> StructureSpawn {
  StructureSpawn::{
    raw,
    relation: relation_of_owned_flag(raw.my().to_option()),
  }
}

///|
pub fn OwnedSpawn::create(raw : @raw.JsStructureSpawn) -> OwnedSpawn {
  OwnedSpawn::{ raw, }
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
pub fn OwnedSpawn::to_raw(self : OwnedSpawn) -> @raw.JsStructureSpawn {
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
pub fn OwnedSpawn::as_game_object(self : OwnedSpawn) -> GameObject {
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
pub fn OwnedSpawn::relation(_self : OwnedSpawn) -> Relation {
  Mine
}

///|
pub fn EnemySpawn::relation(_self : EnemySpawn) -> Relation {
  Enemy
}

///|
pub fn StructureSpawn::is_owned(self : StructureSpawn) -> Bool {
  self.relation == Mine
}

///|
pub fn StructureSpawn::is_enemy(self : StructureSpawn) -> Bool {
  self.relation == Enemy
}

///|
pub fn OwnedSpawn::is_owned(_self : OwnedSpawn) -> Bool {
  true
}

///|
pub fn OwnedSpawn::is_enemy(_self : OwnedSpawn) -> Bool {
  false
}

///|
pub fn EnemySpawn::is_owned(_self : EnemySpawn) -> Bool {
  false
}

///|
pub fn EnemySpawn::is_enemy(_self : EnemySpawn) -> Bool {
  true
}

///|
pub fn StructureSpawn::as_owned(self : StructureSpawn) -> OwnedSpawn? {
  if self.relation == Mine {
    Some(OwnedSpawn::{ raw: self.raw })
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
pub fn OwnedSpawn::as_structure_spawn(self : OwnedSpawn) -> StructureSpawn {
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
pub fn OwnedSpawn::id(self : OwnedSpawn) -> String {
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
pub fn OwnedSpawn::x(self : OwnedSpawn) -> Int {
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
pub fn OwnedSpawn::y(self : OwnedSpawn) -> Int {
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
pub fn OwnedSpawn::exists(self : OwnedSpawn) -> Bool {
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
pub fn OwnedSpawn::store(self : OwnedSpawn) -> Store {
  Store::create(self.raw.store())
}

///|
pub fn EnemySpawn::store(self : EnemySpawn) -> Store {
  Store::create(self.raw.store())
}

///|
pub fn StructureSpawn::hits(self : StructureSpawn) -> Int {
  self.raw.hits()
}

///|
pub fn OwnedSpawn::hits(self : OwnedSpawn) -> Int {
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
pub fn OwnedSpawn::hits_max(self : OwnedSpawn) -> Int {
  self.raw.hits_max()
}

///|
pub fn EnemySpawn::hits_max(self : EnemySpawn) -> Int {
  self.raw.hits_max()
}
