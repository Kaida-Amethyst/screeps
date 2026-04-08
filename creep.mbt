///|
/// Creep 的通用观察视图。
pub struct Creep {
  priv raw : @raw.JsCreep
  priv relation : Relation
}

///|
/// 己方 creep 的强约束视图。
pub struct MyCreep {
  priv raw : @raw.JsCreep
}

///|
/// 敌方 creep 的强约束视图。
pub struct EnemyCreep {
  priv raw : @raw.JsCreep
}

///|
pub fn Creep::create(raw : @raw.JsCreep) -> Creep {
  Creep::{ raw, relation: relation_of_my_bool(raw.my()) }
}

///|
pub fn MyCreep::create(raw : @raw.JsCreep) -> MyCreep {
  MyCreep::{ raw, }
}

///|
pub fn EnemyCreep::create(raw : @raw.JsCreep) -> EnemyCreep {
  EnemyCreep::{ raw, }
}

///|
pub fn Creep::to_raw(self : Creep) -> @raw.JsCreep {
  self.raw
}

///|
pub fn MyCreep::to_raw(self : MyCreep) -> @raw.JsCreep {
  self.raw
}

///|
pub fn EnemyCreep::to_raw(self : EnemyCreep) -> @raw.JsCreep {
  self.raw
}

///|
pub fn Creep::as_game_object(self : Creep) -> GameObject {
  GameObject::create(self.raw.to_game_object())
}

///|
pub fn MyCreep::as_game_object(self : MyCreep) -> GameObject {
  GameObject::create(self.raw.to_game_object())
}

///|
pub fn EnemyCreep::as_game_object(self : EnemyCreep) -> GameObject {
  GameObject::create(self.raw.to_game_object())
}

///|
pub fn Creep::relation(self : Creep) -> Relation {
  self.relation
}

///|
pub fn MyCreep::relation(_self : MyCreep) -> Relation {
  Mine
}

///|
pub fn EnemyCreep::relation(_self : EnemyCreep) -> Relation {
  Enemy
}

///|
pub fn Creep::is_my(self : Creep) -> Bool {
  self.relation == Mine
}

///|
pub fn Creep::is_enemy(self : Creep) -> Bool {
  self.relation == Enemy
}

///|
pub fn MyCreep::is_my(_self : MyCreep) -> Bool {
  true
}

///|
pub fn MyCreep::is_enemy(_self : MyCreep) -> Bool {
  false
}

///|
pub fn EnemyCreep::is_my(_self : EnemyCreep) -> Bool {
  false
}

///|
pub fn EnemyCreep::is_enemy(_self : EnemyCreep) -> Bool {
  true
}

///|
pub fn Creep::as_my(self : Creep) -> MyCreep? {
  if self.relation == Mine {
    Some(MyCreep::{ raw: self.raw })
  } else {
    None
  }
}

///|
pub fn Creep::as_enemy(self : Creep) -> EnemyCreep? {
  if self.relation == Enemy {
    Some(EnemyCreep::{ raw: self.raw })
  } else {
    None
  }
}

///|
pub fn MyCreep::as_creep(self : MyCreep) -> Creep {
  Creep::{ raw: self.raw, relation: Mine }
}

///|
pub fn EnemyCreep::as_creep(self : EnemyCreep) -> Creep {
  Creep::{ raw: self.raw, relation: Enemy }
}

///|
pub fn Creep::id(self : Creep) -> String {
  self.as_game_object().id()
}

///|
pub fn MyCreep::id(self : MyCreep) -> String {
  self.as_game_object().id()
}

///|
pub fn EnemyCreep::id(self : EnemyCreep) -> String {
  self.as_game_object().id()
}

///|
pub fn Creep::x(self : Creep) -> Int {
  self.as_game_object().x()
}

///|
pub fn MyCreep::x(self : MyCreep) -> Int {
  self.as_game_object().x()
}

///|
pub fn EnemyCreep::x(self : EnemyCreep) -> Int {
  self.as_game_object().x()
}

///|
pub fn Creep::y(self : Creep) -> Int {
  self.as_game_object().y()
}

///|
pub fn MyCreep::y(self : MyCreep) -> Int {
  self.as_game_object().y()
}

///|
pub fn EnemyCreep::y(self : EnemyCreep) -> Int {
  self.as_game_object().y()
}

///|
pub fn Creep::exists(self : Creep) -> Bool {
  self.as_game_object().exists()
}

///|
pub fn MyCreep::exists(self : MyCreep) -> Bool {
  self.as_game_object().exists()
}

///|
pub fn EnemyCreep::exists(self : EnemyCreep) -> Bool {
  self.as_game_object().exists()
}

///|
pub fn Creep::store(self : Creep) -> Store {
  Store::create(self.raw.store())
}

///|
pub fn MyCreep::store(self : MyCreep) -> Store {
  Store::create(self.raw.store())
}

///|
pub fn EnemyCreep::store(self : EnemyCreep) -> Store {
  Store::create(self.raw.store())
}

///|
pub fn Creep::hits(self : Creep) -> Int {
  self.raw.hits()
}

///|
pub fn MyCreep::hits(self : MyCreep) -> Int {
  self.raw.hits()
}

///|
pub fn EnemyCreep::hits(self : EnemyCreep) -> Int {
  self.raw.hits()
}

///|
pub fn Creep::hits_max(self : Creep) -> Int {
  self.raw.hits_max()
}

///|
pub fn MyCreep::hits_max(self : MyCreep) -> Int {
  self.raw.hits_max()
}

///|
pub fn EnemyCreep::hits_max(self : EnemyCreep) -> Int {
  self.raw.hits_max()
}

///|
pub fn Creep::spawning(self : Creep) -> Bool {
  self.raw.spawning()
}

///|
pub fn MyCreep::spawning(self : MyCreep) -> Bool {
  self.raw.spawning()
}

///|
pub fn EnemyCreep::spawning(self : EnemyCreep) -> Bool {
  self.raw.spawning()
}
