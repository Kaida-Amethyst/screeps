///|
/// ConstructionSite 的通用观察视图。
pub struct ConstructionSite {
  priv raw : @raw.JsConstructionSite
  priv relation : Relation
}

///|
fn progress_value_or_zero(value : @core.Nullish[Int]) -> Int {
  match value.to_option() {
    Some(value) => value
    None => 0
  }
}

///|
pub fn ConstructionSite::create(
  raw : @raw.JsConstructionSite,
) -> ConstructionSite {
  ConstructionSite::{
    raw,
    relation: relation_of_owned_flag(raw.my().to_option()),
  }
}

///|
pub fn ConstructionSite::to_raw(
  self : ConstructionSite,
) -> @raw.JsConstructionSite {
  self.raw
}

///|
pub fn ConstructionSite::as_game_object(self : ConstructionSite) -> GameObject {
  GameObject::create(self.raw.to_game_object())
}

///|
pub fn ConstructionSite::relation(self : ConstructionSite) -> Relation {
  self.relation
}

///|
pub fn ConstructionSite::is_owned(self : ConstructionSite) -> Bool {
  self.relation == Mine
}

///|
pub fn ConstructionSite::is_enemy(self : ConstructionSite) -> Bool {
  self.relation == Enemy
}

///|
pub fn ConstructionSite::id(self : ConstructionSite) -> String {
  self.as_game_object().id()
}

///|
pub fn ConstructionSite::x(self : ConstructionSite) -> Int {
  self.as_game_object().x()
}

///|
pub fn ConstructionSite::y(self : ConstructionSite) -> Int {
  self.as_game_object().y()
}

///|
pub fn ConstructionSite::exists(self : ConstructionSite) -> Bool {
  self.as_game_object().exists()
}

///|
pub fn ConstructionSite::progress(self : ConstructionSite) -> Int {
  progress_value_or_zero(self.raw.progress())
}

///|
pub fn ConstructionSite::progress_total(self : ConstructionSite) -> Int {
  progress_value_or_zero(self.raw.progress_total())
}

///|
pub fn ConstructionSite::remove(self : ConstructionSite) -> Unit {
  self.raw.remove_raw()
}
