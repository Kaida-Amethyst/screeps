///|
/// raw extern type 之间允许做零成本的 JS 句柄转换。
pub fn JsCreep::to_game_object(self : JsCreep) -> JsGameObject = "%identity"

///|
pub fn JsSource::to_game_object(self : JsSource) -> JsGameObject = "%identity"

///|
pub fn JsFlag::to_game_object(self : JsFlag) -> JsGameObject = "%identity"

///|
pub fn JsStructureSpawn::to_game_object(
  self : JsStructureSpawn,
) -> JsGameObject = "%identity"

///|
pub fn JsStructureTower::to_game_object(
  self : JsStructureTower,
) -> JsGameObject = "%identity"

///|
pub fn JsStructureContainer::to_game_object(
  self : JsStructureContainer,
) -> JsGameObject = "%identity"

///|
pub fn JsConstructionSite::to_game_object(
  self : JsConstructionSite,
) -> JsGameObject = "%identity"

///|
pub fn JsGameObject::to_creep(self : JsGameObject) -> JsCreep = "%identity"

///|
pub fn JsGameObject::to_source(self : JsGameObject) -> JsSource = "%identity"

///|
pub fn JsGameObject::to_flag(self : JsGameObject) -> JsFlag = "%identity"

///|
pub fn JsGameObject::to_structure_spawn(
  self : JsGameObject,
) -> JsStructureSpawn = "%identity"

///|
pub fn JsGameObject::to_structure_tower(
  self : JsGameObject,
) -> JsStructureTower = "%identity"

///|
pub fn JsGameObject::to_structure_container(
  self : JsGameObject,
) -> JsStructureContainer = "%identity"

///|
pub fn JsGameObject::to_construction_site(
  self : JsGameObject,
) -> JsConstructionSite = "%identity"

///|
/// `id` 在 typings 中可能是 `number | string`，formal API 统一转成字符串。
pub extern "js" fn JsGameObject::id(self : JsGameObject) -> String =
  #| (self) => String(self.id)

///|
pub extern "js" fn JsGameObject::x(self : JsGameObject) -> Int =
  #| (self) => self.x

///|
pub extern "js" fn JsGameObject::y(self : JsGameObject) -> Int =
  #| (self) => self.y

///|
pub extern "js" fn JsGameObject::exists(self : JsGameObject) -> Bool =
  #| (self) => self.exists

///|
pub extern "js" fn JsGameObject::my(self : JsGameObject) -> @core.Nullish[Bool] =
  #| (self) => self.my

///|
pub extern "js" fn JsGameObject::hits(
  self : JsGameObject,
) -> @core.Nullish[Int] =
  #| (self) => self.hits

///|
pub extern "js" fn JsGameObject::hits_max(
  self : JsGameObject,
) -> @core.Nullish[Int] =
  #| (self) => self.hitsMax

///|
pub extern "js" fn JsGameObject::is_structure(self : JsGameObject) -> Bool =
  #| (self) => self?.constructor?.name?.startsWith("Structure") ?? false

///|
pub extern "js" fn JsGameObject::prototype_name(self : JsGameObject) -> String =
  #| (self) => self?.constructor?.name ?? ""
