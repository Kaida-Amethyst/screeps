///|
/// Source 的通用观察视图。
pub struct Source {
  priv raw : @raw.JsSource
}

///|
pub fn Source::create(raw : @raw.JsSource) -> Source {
  Source::{ raw, }
}

///|
pub fn Source::to_raw(self : Source) -> @raw.JsSource {
  self.raw
}

///|
pub fn Source::as_game_object(self : Source) -> GameObject {
  GameObject::create(self.raw.to_game_object())
}

///|
pub fn Source::id(self : Source) -> String {
  self.as_game_object().id()
}

///|
pub fn Source::x(self : Source) -> Int {
  self.as_game_object().x()
}

///|
pub fn Source::y(self : Source) -> Int {
  self.as_game_object().y()
}

///|
pub fn Source::exists(self : Source) -> Bool {
  self.as_game_object().exists()
}

///|
pub fn Source::energy(self : Source) -> Int {
  self.raw.energy()
}

///|
pub fn Source::energy_capacity(self : Source) -> Int {
  self.raw.energy_capacity()
}
