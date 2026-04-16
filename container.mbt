///|
/// StructureContainer 的通用观察视图。
pub struct StructureContainer {
  priv raw : @raw.JsStructureContainer
  priv relation : Relation
}

///|
/// 从 raw container 构造高层视图。通常下游无需直接调用。
pub fn StructureContainer::create(
  raw : @raw.JsStructureContainer,
) -> StructureContainer {
  StructureContainer::{
    raw,
    relation: relation_of_my_flag(raw.my().to_option()),
  }
}

///|
/// 返回底层 raw container 句柄。通常下游无需直接调用。
pub fn StructureContainer::to_raw(
  self : StructureContainer,
) -> @raw.JsStructureContainer {
  self.raw
}

///|
/// 将 container 转成通用 `GameObject` 视图。
pub fn StructureContainer::as_game_object(
  self : StructureContainer,
) -> GameObject {
  GameObject::create(self.raw.to_game_object())
}

///|
/// 返回 container 的敌我关系。
pub fn StructureContainer::relation(self : StructureContainer) -> Relation {
  self.relation
}

///|
/// 返回该 container 是否属于己方。
pub fn StructureContainer::is_my(self : StructureContainer) -> Bool {
  self.relation == Mine
}

///|
/// 返回该 container 是否属于敌方。
pub fn StructureContainer::is_enemy(self : StructureContainer) -> Bool {
  self.relation == Enemy
}

///|
/// 返回 container 的唯一 id。
pub fn StructureContainer::id(self : StructureContainer) -> String {
  self.as_game_object().id()
}

///|
/// 返回 container 当前的 x 坐标。
pub fn StructureContainer::x(self : StructureContainer) -> Int {
  self.as_game_object().x()
}

///|
/// 返回 container 当前的 y 坐标。
pub fn StructureContainer::y(self : StructureContainer) -> Int {
  self.as_game_object().y()
}

///|
/// 返回 container 当前是否仍存在于场上。
pub fn StructureContainer::exists(self : StructureContainer) -> Bool {
  self.as_game_object().exists()
}

///|
/// 返回 container 的存储视图。
pub fn StructureContainer::store(self : StructureContainer) -> Store {
  Store::create(self.raw.store())
}

///|
/// 返回 container 当前生命值。
pub fn StructureContainer::hits(self : StructureContainer) -> Int {
  self.raw.hits()
}

///|
/// 返回 container 最大生命值。
pub fn StructureContainer::hits_max(self : StructureContainer) -> Int {
  self.raw.hits_max()
}
