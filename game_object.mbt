///|
/// 所有正式 wrapper 的共同基础视图。
pub struct GameObject {
  priv raw : @raw.JsGameObject
}

///|
/// 从 raw game object 构造高层视图。通常下游无需直接调用。
pub fn GameObject::create(raw : @raw.JsGameObject) -> GameObject {
  GameObject::{ raw, }
}

///|
/// 返回底层 raw game object 句柄。通常下游无需直接调用。
pub fn GameObject::to_raw(self : GameObject) -> @raw.JsGameObject {
  self.raw
}

///|
/// 返回对象的唯一 id。
pub fn GameObject::id(self : GameObject) -> String {
  self.raw.id()
}

///|
/// 返回对象当前的 x 坐标。
pub fn GameObject::x(self : GameObject) -> Int {
  self.raw.x()
}

///|
/// 返回对象当前的 y 坐标。
pub fn GameObject::y(self : GameObject) -> Int {
  self.raw.y()
}

///|
/// 返回对象当前是否仍存在于场上。
pub fn GameObject::exists(self : GameObject) -> Bool {
  self.raw.exists()
}

///|
/// 返回对象的原始 prototype 名称。
pub fn GameObject::prototype_name(self : GameObject) -> String {
  self.raw.prototype_name()
}

///|
/// 若对象实际是 creep，则返回其高层视图。
pub fn GameObject::as_creep(self : GameObject) -> Creep? {
  if self.prototype_name() == "Creep" {
    Some(Creep::create(self.raw.to_creep()))
  } else {
    None
  }
}

///|
/// 若对象实际是 source，则返回其高层视图。
pub fn GameObject::as_source(self : GameObject) -> Source? {
  if self.prototype_name() == "Source" {
    Some(Source::create(self.raw.to_source()))
  } else {
    None
  }
}

///|
/// 若对象实际是 flag，则返回其高层视图。
pub fn GameObject::as_flag(self : GameObject) -> Flag? {
  if self.prototype_name() == "Flag" {
    Some(Flag::create(self.raw.to_flag()))
  } else {
    None
  }
}

///|
/// 若对象实际是 structure，则返回其通用结构视图。
pub fn GameObject::as_structure(self : GameObject) -> Structure? {
  if self.raw.is_structure() {
    Some(Structure::create(self.raw))
  } else {
    None
  }
}

///|
/// 若对象实际是 spawn，则返回其高层视图。
pub fn GameObject::as_structure_spawn(self : GameObject) -> StructureSpawn? {
  if self.prototype_name() == "StructureSpawn" {
    Some(StructureSpawn::create(self.raw.to_structure_spawn()))
  } else {
    None
  }
}

///|
/// 若对象实际是 tower，则返回其高层视图。
pub fn GameObject::as_structure_tower(self : GameObject) -> StructureTower? {
  if self.prototype_name() == "StructureTower" {
    Some(StructureTower::create(self.raw.to_structure_tower()))
  } else {
    None
  }
}

///|
/// 若对象实际是 container，则返回其高层视图。
pub fn GameObject::as_structure_container(
  self : GameObject,
) -> StructureContainer? {
  if self.prototype_name() == "StructureContainer" {
    Some(StructureContainer::create(self.raw.to_structure_container()))
  } else {
    None
  }
}

///|
/// 若对象实际是 construction site，则返回其高层视图。
pub fn GameObject::as_construction_site(self : GameObject) -> ConstructionSite? {
  if self.prototype_name() == "ConstructionSite" {
    Some(ConstructionSite::create(self.raw.to_construction_site()))
  } else {
    None
  }
}
