///|
/// StructureTower 的通用观察视图。
pub struct StructureTower {
  priv raw : @raw.JsStructureTower
  priv relation : Relation
}

///|
/// 己方 tower 的强约束视图。
pub struct MyTower {
  priv raw : @raw.JsStructureTower
}

///|
/// 敌方 tower 的强约束视图。
pub struct EnemyTower {
  priv raw : @raw.JsStructureTower
}

///|
/// 从 raw tower 构造通用 tower 视图。通常下游无需直接调用。
pub fn StructureTower::create(raw : @raw.JsStructureTower) -> StructureTower {
  StructureTower::{ raw, relation: relation_of_my_flag(raw.my().to_option()) }
}

///|
/// 从 raw tower 构造己方 tower 视图。通常下游无需直接调用。
pub fn MyTower::create(raw : @raw.JsStructureTower) -> MyTower {
  MyTower::{ raw, }
}

///|
/// 从 raw tower 构造敌方 tower 视图。通常下游无需直接调用。
pub fn EnemyTower::create(raw : @raw.JsStructureTower) -> EnemyTower {
  EnemyTower::{ raw, }
}

///|
/// 返回底层 raw tower 句柄。通常下游无需直接调用。
pub fn StructureTower::to_raw(self : StructureTower) -> @raw.JsStructureTower {
  self.raw
}

///|
/// 返回底层 raw tower 句柄。通常下游无需直接调用。
pub fn MyTower::to_raw(self : MyTower) -> @raw.JsStructureTower {
  self.raw
}

///|
/// 返回底层 raw tower 句柄。通常下游无需直接调用。
pub fn EnemyTower::to_raw(self : EnemyTower) -> @raw.JsStructureTower {
  self.raw
}

///|
/// 将 tower 转成通用 `GameObject` 视图。
pub fn StructureTower::as_game_object(self : StructureTower) -> GameObject {
  GameObject::create(self.raw.to_game_object())
}

///|
/// 将己方 tower 转成通用 `GameObject` 视图。
pub fn MyTower::as_game_object(self : MyTower) -> GameObject {
  GameObject::create(self.raw.to_game_object())
}

///|
/// 将敌方 tower 转成通用 `GameObject` 视图。
pub fn EnemyTower::as_game_object(self : EnemyTower) -> GameObject {
  GameObject::create(self.raw.to_game_object())
}

///|
/// 返回 tower 的敌我关系。
pub fn StructureTower::relation(self : StructureTower) -> Relation {
  self.relation
}

///|
/// 返回固定为己方的敌我关系。
pub fn MyTower::relation(_self : MyTower) -> Relation {
  Mine
}

///|
/// 返回固定为敌方的敌我关系。
pub fn EnemyTower::relation(_self : EnemyTower) -> Relation {
  Enemy
}

///|
/// 返回该 tower 是否属于己方。
pub fn StructureTower::is_my(self : StructureTower) -> Bool {
  self.relation == Mine
}

///|
/// 返回该 tower 是否属于敌方。
pub fn StructureTower::is_enemy(self : StructureTower) -> Bool {
  self.relation == Enemy
}

///|
/// 返回 `true`，表示这是己方 tower 视图。
pub fn MyTower::is_my(_self : MyTower) -> Bool {
  true
}

///|
/// 返回 `false`，表示这不是敌方 tower 视图。
pub fn MyTower::is_enemy(_self : MyTower) -> Bool {
  false
}

///|
/// 返回 `false`，表示这不是己方 tower 视图。
pub fn EnemyTower::is_my(_self : EnemyTower) -> Bool {
  false
}

///|
/// 返回 `true`，表示这是敌方 tower 视图。
pub fn EnemyTower::is_enemy(_self : EnemyTower) -> Bool {
  true
}

///|
/// 若当前 tower 属于己方，则转成 `MyTower` 视图。
pub fn StructureTower::as_my(self : StructureTower) -> MyTower? {
  if self.relation == Mine {
    Some(MyTower::{ raw: self.raw })
  } else {
    None
  }
}

///|
/// 若当前 tower 属于敌方，则转成 `EnemyTower` 视图。
pub fn StructureTower::as_enemy(self : StructureTower) -> EnemyTower? {
  if self.relation == Enemy {
    Some(EnemyTower::{ raw: self.raw })
  } else {
    None
  }
}

///|
/// 将己方 tower 放宽成通用 `StructureTower` 视图。
pub fn MyTower::as_structure_tower(self : MyTower) -> StructureTower {
  StructureTower::{ raw: self.raw, relation: Mine }
}

///|
/// 将敌方 tower 放宽成通用 `StructureTower` 视图。
pub fn EnemyTower::as_structure_tower(self : EnemyTower) -> StructureTower {
  StructureTower::{ raw: self.raw, relation: Enemy }
}

///|
/// 返回 tower 的唯一 id。
pub fn StructureTower::id(self : StructureTower) -> String {
  self.as_game_object().id()
}

///|
/// 返回己方 tower 的唯一 id。
pub fn MyTower::id(self : MyTower) -> String {
  self.as_game_object().id()
}

///|
/// 返回敌方 tower 的唯一 id。
pub fn EnemyTower::id(self : EnemyTower) -> String {
  self.as_game_object().id()
}

///|
/// 返回 tower 当前的 x 坐标。
pub fn StructureTower::x(self : StructureTower) -> Int {
  self.as_game_object().x()
}

///|
/// 返回己方 tower 当前的 x 坐标。
pub fn MyTower::x(self : MyTower) -> Int {
  self.as_game_object().x()
}

///|
/// 返回敌方 tower 当前的 x 坐标。
pub fn EnemyTower::x(self : EnemyTower) -> Int {
  self.as_game_object().x()
}

///|
/// 返回 tower 当前的 y 坐标。
pub fn StructureTower::y(self : StructureTower) -> Int {
  self.as_game_object().y()
}

///|
/// 返回己方 tower 当前的 y 坐标。
pub fn MyTower::y(self : MyTower) -> Int {
  self.as_game_object().y()
}

///|
/// 返回敌方 tower 当前的 y 坐标。
pub fn EnemyTower::y(self : EnemyTower) -> Int {
  self.as_game_object().y()
}

///|
/// 返回 tower 当前是否仍存在于场上。
pub fn StructureTower::exists(self : StructureTower) -> Bool {
  self.as_game_object().exists()
}

///|
/// 返回己方 tower 当前是否仍存在于场上。
pub fn MyTower::exists(self : MyTower) -> Bool {
  self.as_game_object().exists()
}

///|
/// 返回敌方 tower 当前是否仍存在于场上。
pub fn EnemyTower::exists(self : EnemyTower) -> Bool {
  self.as_game_object().exists()
}

///|
/// 返回 tower 的存储视图。
pub fn StructureTower::store(self : StructureTower) -> Store {
  Store::create(self.raw.store())
}

///|
/// 返回己方 tower 的存储视图。
pub fn MyTower::store(self : MyTower) -> Store {
  Store::create(self.raw.store())
}

///|
/// 返回敌方 tower 的存储视图。
pub fn EnemyTower::store(self : EnemyTower) -> Store {
  Store::create(self.raw.store())
}

///|
/// 返回 tower 当前生命值。
pub fn StructureTower::hits(self : StructureTower) -> Int {
  self.raw.hits()
}

///|
/// 返回己方 tower 当前生命值。
pub fn MyTower::hits(self : MyTower) -> Int {
  self.raw.hits()
}

///|
/// 返回敌方 tower 当前生命值。
pub fn EnemyTower::hits(self : EnemyTower) -> Int {
  self.raw.hits()
}

///|
/// 返回 tower 最大生命值。
pub fn StructureTower::hits_max(self : StructureTower) -> Int {
  self.raw.hits_max()
}

///|
/// 返回己方 tower 最大生命值。
pub fn MyTower::hits_max(self : MyTower) -> Int {
  self.raw.hits_max()
}

///|
/// 返回敌方 tower 最大生命值。
pub fn EnemyTower::hits_max(self : EnemyTower) -> Int {
  self.raw.hits_max()
}

///|
/// 返回 tower 剩余冷却时间。
pub fn StructureTower::cooldown(self : StructureTower) -> Int {
  self.raw.cooldown()
}

///|
/// 返回己方 tower 剩余冷却时间。
pub fn MyTower::cooldown(self : MyTower) -> Int {
  self.raw.cooldown()
}

///|
/// 返回敌方 tower 剩余冷却时间。
pub fn EnemyTower::cooldown(self : EnemyTower) -> Int {
  self.raw.cooldown()
}
