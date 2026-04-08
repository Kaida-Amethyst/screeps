///|
/// Flag 的通用观察视图。
pub struct Flag {
  priv raw : @raw.JsFlag
  priv relation : Relation
}

///|
pub fn Flag::create(raw : @raw.JsFlag) -> Flag {
  Flag::{ raw, relation: relation_of_owned_flag(raw.my().to_option()) }
}

///|
pub fn Flag::to_raw(self : Flag) -> @raw.JsFlag {
  self.raw
}

///|
pub fn Flag::as_game_object(self : Flag) -> GameObject {
  GameObject::create(self.raw.to_game_object())
}

///|
pub fn Flag::relation(self : Flag) -> Relation {
  self.relation
}

///|
pub fn Flag::is_owned(self : Flag) -> Bool {
  self.relation == Mine
}

///|
pub fn Flag::is_enemy(self : Flag) -> Bool {
  self.relation == Enemy
}

///|
pub fn Flag::id(self : Flag) -> String {
  self.as_game_object().id()
}

///|
pub fn Flag::x(self : Flag) -> Int {
  self.as_game_object().x()
}

///|
pub fn Flag::y(self : Flag) -> Int {
  self.as_game_object().y()
}

///|
pub fn Flag::exists(self : Flag) -> Bool {
  self.as_game_object().exists()
}
