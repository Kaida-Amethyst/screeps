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
/// 从 raw construction site 构造高层视图。通常下游无需直接调用。
pub fn ConstructionSite::create(
  raw : @raw.JsConstructionSite,
) -> ConstructionSite {
  ConstructionSite::{ raw, relation: relation_of_my_flag(raw.my().to_option()) }
}

///|
/// 返回底层 raw construction site 句柄。通常下游无需直接调用。
pub fn ConstructionSite::to_raw(
  self : ConstructionSite,
) -> @raw.JsConstructionSite {
  self.raw
}

///|
/// 将 construction site 转成通用 `GameObject` 视图。
pub fn ConstructionSite::as_game_object(self : ConstructionSite) -> GameObject {
  GameObject::create(self.raw.to_game_object())
}

///|
/// 返回工地的敌我关系。
pub fn ConstructionSite::relation(self : ConstructionSite) -> Relation {
  self.relation
}

///|
/// 返回该工地是否属于己方。
pub fn ConstructionSite::is_my(self : ConstructionSite) -> Bool {
  self.relation == Mine
}

///|
/// 返回该工地是否属于敌方。
pub fn ConstructionSite::is_enemy(self : ConstructionSite) -> Bool {
  self.relation == Enemy
}

///|
/// 返回工地的唯一 id。
pub fn ConstructionSite::id(self : ConstructionSite) -> String {
  self.as_game_object().id()
}

///|
/// 返回工地当前的 x 坐标。
pub fn ConstructionSite::x(self : ConstructionSite) -> Int {
  self.as_game_object().x()
}

///|
/// 返回工地当前的 y 坐标。
pub fn ConstructionSite::y(self : ConstructionSite) -> Int {
  self.as_game_object().y()
}

///|
/// 返回工地当前是否仍存在于场上。
pub fn ConstructionSite::exists(self : ConstructionSite) -> Bool {
  self.as_game_object().exists()
}

///|
/// 返回工地当前建造进度。
pub fn ConstructionSite::progress(self : ConstructionSite) -> Int {
  progress_value_or_zero(self.raw.progress())
}

///|
/// 返回工地完成建造所需的总进度。
pub fn ConstructionSite::progress_total(self : ConstructionSite) -> Int {
  progress_value_or_zero(self.raw.progress_total())
}

///|
/// 移除该工地。
pub fn ConstructionSite::remove(self : ConstructionSite) -> Unit {
  self.raw.remove_raw()
}
