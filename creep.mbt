///|
/// Creep 的通用观察视图。
pub struct Creep {
  priv raw : @raw.JsCreep
  priv relation : Relation
}

///|
/// 己方 creep 的强约束视图。
pub struct MyCreep {
  priv raw : @raw.JsCreep
}

///|
/// 敌方 creep 的强约束视图。
pub struct EnemyCreep {
  priv raw : @raw.JsCreep
}

///|
/// 从 raw creep 构造通用 creep 视图。通常下游无需直接调用。
pub fn Creep::create(raw : @raw.JsCreep) -> Creep {
  Creep::{ raw, relation: relation_of_my_bool(raw.my()) }
}

///|
/// 从 raw creep 构造己方 creep 视图。通常下游无需直接调用。
pub fn MyCreep::create(raw : @raw.JsCreep) -> MyCreep {
  MyCreep::{ raw, }
}

///|
/// 从 raw creep 构造敌方 creep 视图。通常下游无需直接调用。
pub fn EnemyCreep::create(raw : @raw.JsCreep) -> EnemyCreep {
  EnemyCreep::{ raw, }
}

///|
/// 返回底层 raw creep 句柄。通常下游无需直接调用。
pub fn Creep::to_raw(self : Creep) -> @raw.JsCreep {
  self.raw
}

///|
/// 返回底层 raw creep 句柄。通常下游无需直接调用。
pub fn MyCreep::to_raw(self : MyCreep) -> @raw.JsCreep {
  self.raw
}

///|
/// 返回底层 raw creep 句柄。通常下游无需直接调用。
pub fn EnemyCreep::to_raw(self : EnemyCreep) -> @raw.JsCreep {
  self.raw
}

///|
/// 将 creep 转成通用 `GameObject` 视图。
pub fn Creep::as_game_object(self : Creep) -> GameObject {
  GameObject::create(self.raw.to_game_object())
}

///|
/// 将己方 creep 转成通用 `GameObject` 视图。
pub fn MyCreep::as_game_object(self : MyCreep) -> GameObject {
  GameObject::create(self.raw.to_game_object())
}

///|
/// 将敌方 creep 转成通用 `GameObject` 视图。
pub fn EnemyCreep::as_game_object(self : EnemyCreep) -> GameObject {
  GameObject::create(self.raw.to_game_object())
}

///|
/// 返回 creep 的敌我关系。
pub fn Creep::relation(self : Creep) -> Relation {
  self.relation
}

///|
/// 返回固定为己方的敌我关系。
pub fn MyCreep::relation(_self : MyCreep) -> Relation {
  Mine
}

///|
/// 返回固定为敌方的敌我关系。
pub fn EnemyCreep::relation(_self : EnemyCreep) -> Relation {
  Enemy
}

///|
/// 返回该 creep 是否属于己方。
pub fn Creep::is_my(self : Creep) -> Bool {
  self.relation == Mine
}

///|
/// 返回该 creep 是否属于敌方。
pub fn Creep::is_enemy(self : Creep) -> Bool {
  self.relation == Enemy
}

///|
/// 返回 `true`，表示这是己方 creep 视图。
pub fn MyCreep::is_my(_self : MyCreep) -> Bool {
  true
}

///|
/// 返回 `false`，表示这不是敌方 creep 视图。
pub fn MyCreep::is_enemy(_self : MyCreep) -> Bool {
  false
}

///|
/// 返回 `false`，表示这不是己方 creep 视图。
pub fn EnemyCreep::is_my(_self : EnemyCreep) -> Bool {
  false
}

///|
/// 返回 `true`，表示这是敌方 creep 视图。
pub fn EnemyCreep::is_enemy(_self : EnemyCreep) -> Bool {
  true
}

///|
/// 若当前 creep 属于己方，则转成 `MyCreep` 视图。
pub fn Creep::as_my(self : Creep) -> MyCreep? {
  if self.relation == Mine {
    Some(MyCreep::{ raw: self.raw })
  } else {
    None
  }
}

///|
/// 若当前 creep 属于敌方，则转成 `EnemyCreep` 视图。
pub fn Creep::as_enemy(self : Creep) -> EnemyCreep? {
  if self.relation == Enemy {
    Some(EnemyCreep::{ raw: self.raw })
  } else {
    None
  }
}

///|
/// 将己方 creep 放宽成通用 `Creep` 视图。
pub fn MyCreep::as_creep(self : MyCreep) -> Creep {
  Creep::{ raw: self.raw, relation: Mine }
}

///|
/// 将敌方 creep 放宽成通用 `Creep` 视图。
pub fn EnemyCreep::as_creep(self : EnemyCreep) -> Creep {
  Creep::{ raw: self.raw, relation: Enemy }
}

///|
/// 返回 creep 的唯一 id。
pub fn Creep::id(self : Creep) -> String {
  self.as_game_object().id()
}

///|
/// 返回己方 creep 的唯一 id。
pub fn MyCreep::id(self : MyCreep) -> String {
  self.as_game_object().id()
}

///|
/// 返回敌方 creep 的唯一 id。
pub fn EnemyCreep::id(self : EnemyCreep) -> String {
  self.as_game_object().id()
}

///|
/// 返回 creep 当前的 x 坐标。
pub fn Creep::x(self : Creep) -> Int {
  self.as_game_object().x()
}

///|
/// 返回己方 creep 当前的 x 坐标。
pub fn MyCreep::x(self : MyCreep) -> Int {
  self.as_game_object().x()
}

///|
/// 返回敌方 creep 当前的 x 坐标。
pub fn EnemyCreep::x(self : EnemyCreep) -> Int {
  self.as_game_object().x()
}

///|
/// 返回 creep 当前的 y 坐标。
pub fn Creep::y(self : Creep) -> Int {
  self.as_game_object().y()
}

///|
/// 返回己方 creep 当前的 y 坐标。
pub fn MyCreep::y(self : MyCreep) -> Int {
  self.as_game_object().y()
}

///|
/// 返回敌方 creep 当前的 y 坐标。
pub fn EnemyCreep::y(self : EnemyCreep) -> Int {
  self.as_game_object().y()
}

///|
/// 返回 creep 当前是否仍存在于场上。
pub fn Creep::exists(self : Creep) -> Bool {
  self.as_game_object().exists()
}

///|
/// 返回己方 creep 当前是否仍存在于场上。
pub fn MyCreep::exists(self : MyCreep) -> Bool {
  self.as_game_object().exists()
}

///|
/// 返回敌方 creep 当前是否仍存在于场上。
pub fn EnemyCreep::exists(self : EnemyCreep) -> Bool {
  self.as_game_object().exists()
}

///|
/// 返回 creep 的存储视图。
pub fn Creep::store(self : Creep) -> Store {
  Store::create(self.raw.store())
}

///|
/// 返回己方 creep 的存储视图。
pub fn MyCreep::store(self : MyCreep) -> Store {
  Store::create(self.raw.store())
}

///|
/// 返回敌方 creep 的存储视图。
pub fn EnemyCreep::store(self : EnemyCreep) -> Store {
  Store::create(self.raw.store())
}

///|
/// 返回 creep 身上的 body part 列表。
pub fn Creep::body(self : Creep) -> Array[BodyPart] {
  self.raw.body().map(BodyPart::create)
}

///|
/// 返回己方 creep 身上的 body part 列表。
pub fn MyCreep::body(self : MyCreep) -> Array[BodyPart] {
  self.raw.body().map(BodyPart::create)
}

///|
/// 返回敌方 creep 身上的 body part 列表。
pub fn EnemyCreep::body(self : EnemyCreep) -> Array[BodyPart] {
  self.raw.body().map(BodyPart::create)
}

///|
fn has_body_part(parts : Array[BodyPart], kind : BodyPartKind) -> Bool {
  parts.filter(part => part.kind() == kind) is [_, ..]
}

///|
/// 判断 creep 是否拥有指定种类的 body part。
pub fn Creep::has_body_part(self : Creep, kind : BodyPartKind) -> Bool {
  has_body_part(self.body(), kind)
}

///|
/// 判断己方 creep 是否拥有指定种类的 body part。
pub fn MyCreep::has_body_part(self : MyCreep, kind : BodyPartKind) -> Bool {
  has_body_part(self.body(), kind)
}

///|
/// 判断敌方 creep 是否拥有指定种类的 body part。
pub fn EnemyCreep::has_body_part(
  self : EnemyCreep,
  kind : BodyPartKind,
) -> Bool {
  has_body_part(self.body(), kind)
}

///|
/// 返回 creep 当前生命值。
#alias(hp)
pub fn Creep::hits(self : Creep) -> Int {
  self.raw.hits()
}

///|
/// 返回己方 creep 当前生命值。
#alias(hp)
pub fn MyCreep::hits(self : MyCreep) -> Int {
  self.raw.hits()
}

///|
/// 返回敌方 creep 当前生命值。
#alias(hp)
pub fn EnemyCreep::hits(self : EnemyCreep) -> Int {
  self.raw.hits()
}

///|
/// 返回 creep 最大生命值。
#alias(max_hp)
pub fn Creep::hits_max(self : Creep) -> Int {
  self.raw.hits_max()
}

///|
/// 返回己方 creep 最大生命值。
#alias(max_hp)
pub fn MyCreep::hits_max(self : MyCreep) -> Int {
  self.raw.hits_max()
}

///|
/// 返回敌方 creep 最大生命值。
#alias(max_hp)
pub fn EnemyCreep::hits_max(self : EnemyCreep) -> Int {
  self.raw.hits_max()
}

///|
/// 返回该 creep 是否仍在孵化中。
pub fn Creep::spawning(self : Creep) -> Bool {
  self.raw.spawning()
}

///|
/// 返回该己方 creep 是否仍在孵化中。
pub fn MyCreep::spawning(self : MyCreep) -> Bool {
  self.raw.spawning()
}

///|
/// 返回该敌方 creep 是否仍在孵化中。
pub fn EnemyCreep::spawning(self : EnemyCreep) -> Bool {
  self.raw.spawning()
}
