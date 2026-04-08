///|
/// StructureContainer 的通用观察视图。
pub struct StructureContainer {
  priv raw : @raw.JsStructureContainer
  priv relation : Relation
}

///|
pub fn StructureContainer::create(
  raw : @raw.JsStructureContainer,
) -> StructureContainer {
  StructureContainer::{
    raw,
    relation: relation_of_owned_flag(raw.my().to_option()),
  }
}

///|
pub fn StructureContainer::to_raw(
  self : StructureContainer,
) -> @raw.JsStructureContainer {
  self.raw
}

///|
pub fn StructureContainer::as_game_object(
  self : StructureContainer,
) -> GameObject {
  GameObject::create(self.raw.to_game_object())
}

///|
pub fn StructureContainer::relation(self : StructureContainer) -> Relation {
  self.relation
}

///|
pub fn StructureContainer::is_owned(self : StructureContainer) -> Bool {
  self.relation == Mine
}

///|
pub fn StructureContainer::is_enemy(self : StructureContainer) -> Bool {
  self.relation == Enemy
}

///|
pub fn StructureContainer::id(self : StructureContainer) -> String {
  self.as_game_object().id()
}

///|
pub fn StructureContainer::x(self : StructureContainer) -> Int {
  self.as_game_object().x()
}

///|
pub fn StructureContainer::y(self : StructureContainer) -> Int {
  self.as_game_object().y()
}

///|
pub fn StructureContainer::exists(self : StructureContainer) -> Bool {
  self.as_game_object().exists()
}

///|
pub fn StructureContainer::store(self : StructureContainer) -> Store {
  Store::create(self.raw.store())
}

///|
pub fn StructureContainer::hits(self : StructureContainer) -> Int {
  self.raw.hits()
}

///|
pub fn StructureContainer::hits_max(self : StructureContainer) -> Int {
  self.raw.hits_max()
}
