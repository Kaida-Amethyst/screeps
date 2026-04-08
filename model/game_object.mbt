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
