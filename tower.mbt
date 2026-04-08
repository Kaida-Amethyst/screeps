///|
/// StructureTower 的通用观察视图。
pub struct StructureTower {
  priv raw : @raw.JsStructureTower
  priv relation : Relation
}

///|
/// 己方 tower 的强约束视图。
pub struct OwnedTower {
  priv raw : @raw.JsStructureTower
}

///|
/// 敌方 tower 的强约束视图。
pub struct EnemyTower {
  priv raw : @raw.JsStructureTower
}

///|
pub fn StructureTower::create(raw : @raw.JsStructureTower) -> StructureTower {
  StructureTower::{
    raw,
    relation: relation_of_owned_flag(raw.my().to_option()),
  }
}

///|
pub fn OwnedTower::create(raw : @raw.JsStructureTower) -> OwnedTower {
  OwnedTower::{ raw, }
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
pub fn OwnedTower::to_raw(self : OwnedTower) -> @raw.JsStructureTower {
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
pub fn OwnedTower::as_game_object(self : OwnedTower) -> GameObject {
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
pub fn OwnedTower::relation(_self : OwnedTower) -> Relation {
  Mine
}

///|
pub fn EnemyTower::relation(_self : EnemyTower) -> Relation {
  Enemy
}

///|
pub fn StructureTower::is_owned(self : StructureTower) -> Bool {
  self.relation == Mine
}

///|
pub fn StructureTower::is_enemy(self : StructureTower) -> Bool {
  self.relation == Enemy
}

///|
pub fn OwnedTower::is_owned(_self : OwnedTower) -> Bool {
  true
}

///|
pub fn OwnedTower::is_enemy(_self : OwnedTower) -> Bool {
  false
}

///|
pub fn EnemyTower::is_owned(_self : EnemyTower) -> Bool {
  false
}

///|
pub fn EnemyTower::is_enemy(_self : EnemyTower) -> Bool {
  true
}

///|
pub fn StructureTower::as_owned(self : StructureTower) -> OwnedTower? {
  if self.relation == Mine {
    Some(OwnedTower::{ raw: self.raw })
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
pub fn OwnedTower::as_structure_tower(self : OwnedTower) -> StructureTower {
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
pub fn OwnedTower::id(self : OwnedTower) -> String {
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
pub fn OwnedTower::x(self : OwnedTower) -> Int {
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
pub fn OwnedTower::y(self : OwnedTower) -> Int {
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
pub fn OwnedTower::exists(self : OwnedTower) -> Bool {
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
pub fn OwnedTower::store(self : OwnedTower) -> Store {
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
pub fn OwnedTower::hits(self : OwnedTower) -> Int {
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
pub fn OwnedTower::hits_max(self : OwnedTower) -> Int {
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
pub fn OwnedTower::cooldown(self : OwnedTower) -> Int {
  self.raw.cooldown()
}

///|
pub fn EnemyTower::cooldown(self : EnemyTower) -> Int {
  self.raw.cooldown()
}
