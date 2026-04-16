///|
/// Flag 的通用观察视图。
pub struct Flag {
  priv raw : @raw.JsFlag
  priv relation : Relation
}

///|
/// 从 raw flag 构造高层视图。通常下游无需直接调用。
pub fn Flag::create(raw : @raw.JsFlag) -> Flag {
  Flag::{ raw, relation: relation_of_my_flag(raw.my().to_option()) }
}

///|
/// 返回底层 raw flag 句柄。通常下游无需直接调用。
pub fn Flag::to_raw(self : Flag) -> @raw.JsFlag {
  self.raw
}

///|
/// 将 flag 转成通用 `GameObject` 视图。
pub fn Flag::as_game_object(self : Flag) -> GameObject {
  GameObject::create(self.raw.to_game_object())
}

///|
/// 返回 flag 的敌我关系。
pub fn Flag::relation(self : Flag) -> Relation {
  self.relation
}

///|
/// 返回该 flag 是否属于己方。
pub fn Flag::is_my(self : Flag) -> Bool {
  self.relation == Mine
}

///|
/// 返回该 flag 是否属于敌方。
pub fn Flag::is_enemy(self : Flag) -> Bool {
  self.relation == Enemy
}

///|
/// 返回 flag 的唯一 id。
pub fn Flag::id(self : Flag) -> String {
  self.as_game_object().id()
}

///|
/// 返回 flag 当前的 x 坐标。
pub fn Flag::x(self : Flag) -> Int {
  self.as_game_object().x()
}

///|
/// 返回 flag 当前的 y 坐标。
pub fn Flag::y(self : Flag) -> Int {
  self.as_game_object().y()
}

///|
/// 返回 flag 当前是否仍存在于场上。
pub fn Flag::exists(self : Flag) -> Bool {
  self.as_game_object().exists()
}
