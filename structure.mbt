///|
/// 通用 `Structure` 观察视图，主要用于共享结构属性与 `object_by_id` 下转。
pub struct Structure {
  priv raw : @raw.JsGameObject
  priv relation : Relation
}

///|
fn structure_stat_or_zero(value : @core.Nullish[Int]) -> Int {
  match value.to_option() {
    Some(value) => value
    None => 0
  }
}

///|
pub fn Structure::create(raw : @raw.JsGameObject) -> Structure {
  Structure::{ raw, relation: relation_of_my_flag(raw.my().to_option()) }
}

///|
pub fn Structure::to_raw(self : Structure) -> @raw.JsGameObject {
  self.raw
}

///|
pub fn Structure::as_game_object(self : Structure) -> GameObject {
  GameObject::create(self.raw)
}

///|
pub fn Structure::relation(self : Structure) -> Relation {
  self.relation
}

///|
pub fn Structure::is_my(self : Structure) -> Bool {
  self.relation == Mine
}

///|
pub fn Structure::is_enemy(self : Structure) -> Bool {
  self.relation == Enemy
}

///|
pub fn Structure::id(self : Structure) -> String {
  self.as_game_object().id()
}

///|
pub fn Structure::x(self : Structure) -> Int {
  self.as_game_object().x()
}

///|
pub fn Structure::y(self : Structure) -> Int {
  self.as_game_object().y()
}

///|
pub fn Structure::exists(self : Structure) -> Bool {
  self.as_game_object().exists()
}

///|
pub fn Structure::prototype_name(self : Structure) -> String {
  self.as_game_object().prototype_name()
}

///|
pub fn Structure::hits(self : Structure) -> Int {
  structure_stat_or_zero(self.raw.hits())
}

///|
pub fn Structure::hits_max(self : Structure) -> Int {
  structure_stat_or_zero(self.raw.hits_max())
}
