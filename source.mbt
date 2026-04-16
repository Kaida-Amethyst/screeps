///|
/// Source 的通用观察视图。
pub struct Source {
  priv raw : @raw.JsSource
}

///|
/// 从 raw source 构造高层视图。通常下游无需直接调用。
pub fn Source::create(raw : @raw.JsSource) -> Source {
  Source::{ raw, }
}

///|
/// 返回底层 raw source 句柄。通常下游无需直接调用。
pub fn Source::to_raw(self : Source) -> @raw.JsSource {
  self.raw
}

///|
/// 将 source 转成通用 `GameObject` 视图。
pub fn Source::as_game_object(self : Source) -> GameObject {
  GameObject::create(self.raw.to_game_object())
}

///|
/// 返回 source 的唯一 id。
pub fn Source::id(self : Source) -> String {
  self.as_game_object().id()
}

///|
/// 返回 source 当前的 x 坐标。
pub fn Source::x(self : Source) -> Int {
  self.as_game_object().x()
}

///|
/// 返回 source 当前的 y 坐标。
pub fn Source::y(self : Source) -> Int {
  self.as_game_object().y()
}

///|
/// 返回 source 当前是否仍存在于场上。
pub fn Source::exists(self : Source) -> Bool {
  self.as_game_object().exists()
}

///|
/// 返回 source 当前剩余的能量。
pub fn Source::energy(self : Source) -> Int {
  self.raw.energy()
}

///|
/// 返回 source 的最大能量容量。
pub fn Source::energy_capacity(self : Source) -> Int {
  self.raw.energy_capacity()
}
