///|
/// 所有正式 wrapper 的共同基础视图。
pub struct GameObject {
  priv raw : @raw.JsGameObject
}

///|
pub fn GameObject::create(raw : @raw.JsGameObject) -> GameObject {
  GameObject::{ raw, }
}

///|
pub fn GameObject::to_raw(self : GameObject) -> @raw.JsGameObject {
  self.raw
}

///|
pub fn GameObject::id(self : GameObject) -> String {
  self.raw.id()
}

///|
pub fn GameObject::x(self : GameObject) -> Int {
  self.raw.x()
}

///|
pub fn GameObject::y(self : GameObject) -> Int {
  self.raw.y()
}

///|
pub fn GameObject::exists(self : GameObject) -> Bool {
  self.raw.exists()
}

///|
pub fn GameObject::prototype_name(self : GameObject) -> String {
  self.raw.prototype_name()
}

///|
pub fn GameObject::as_creep(self : GameObject) -> Creep? {
  if self.prototype_name() == "Creep" {
    Some(Creep::create(self.raw.to_creep()))
  } else {
    None
  }
}

///|
pub fn GameObject::as_source(self : GameObject) -> Source? {
  if self.prototype_name() == "Source" {
    Some(Source::create(self.raw.to_source()))
  } else {
    None
  }
}

///|
pub fn GameObject::as_flag(self : GameObject) -> Flag? {
  if self.prototype_name() == "Flag" {
    Some(Flag::create(self.raw.to_flag()))
  } else {
    None
  }
}

///|
pub fn GameObject::as_structure(self : GameObject) -> Structure? {
  if self.raw.is_structure() {
    Some(Structure::create(self.raw))
  } else {
    None
  }
}

///|
pub fn GameObject::as_structure_spawn(self : GameObject) -> StructureSpawn? {
  if self.prototype_name() == "StructureSpawn" {
    Some(StructureSpawn::create(self.raw.to_structure_spawn()))
  } else {
    None
  }
}

///|
pub fn GameObject::as_structure_tower(self : GameObject) -> StructureTower? {
  if self.prototype_name() == "StructureTower" {
    Some(StructureTower::create(self.raw.to_structure_tower()))
  } else {
    None
  }
}

///|
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
pub fn GameObject::as_construction_site(self : GameObject) -> ConstructionSite? {
  if self.prototype_name() == "ConstructionSite" {
    Some(ConstructionSite::create(self.raw.to_construction_site()))
  } else {
    None
  }
}
