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
/// 从 raw game object 构造通用结构视图。通常下游无需直接调用。
pub fn Structure::create(raw : @raw.JsGameObject) -> Structure {
  Structure::{ raw, relation: relation_of_my_flag(raw.my().to_option()) }
}

///|
/// 返回底层 raw 结构句柄。通常下游无需直接调用。
pub fn Structure::to_raw(self : Structure) -> @raw.JsGameObject {
  self.raw
}

///|
/// 将结构转成通用 `GameObject` 视图。
pub fn Structure::as_game_object(self : Structure) -> GameObject {
  GameObject::create(self.raw)
}

///|
/// 返回结构的敌我关系。
pub fn Structure::relation(self : Structure) -> Relation {
  self.relation
}

///|
/// 返回该结构是否属于己方。
pub fn Structure::is_my(self : Structure) -> Bool {
  self.relation == Mine
}

///|
/// 返回该结构是否属于敌方。
pub fn Structure::is_enemy(self : Structure) -> Bool {
  self.relation == Enemy
}

///|
/// 返回结构的唯一 id。
pub fn Structure::id(self : Structure) -> String {
  self.as_game_object().id()
}

///|
/// 返回结构当前的 x 坐标。
pub fn Structure::x(self : Structure) -> Int {
  self.as_game_object().x()
}

///|
/// 返回结构当前的 y 坐标。
pub fn Structure::y(self : Structure) -> Int {
  self.as_game_object().y()
}

///|
/// 返回结构当前是否仍存在于场上。
pub fn Structure::exists(self : Structure) -> Bool {
  self.as_game_object().exists()
}

///|
/// 返回结构的原始 prototype 名称。
pub fn Structure::prototype_name(self : Structure) -> String {
  self.as_game_object().prototype_name()
}

///|
/// 返回结构当前生命值。
pub fn Structure::hits(self : Structure) -> Int {
  structure_stat_or_zero(self.raw.hits())
}

///|
/// 返回结构最大生命值。
pub fn Structure::hits_max(self : Structure) -> Int {
  structure_stat_or_zero(self.raw.hits_max())
}
