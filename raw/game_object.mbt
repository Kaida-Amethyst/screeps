///|
/// raw extern type 之间允许做零成本的 JS 句柄转换。
pub fn JsCreep::to_game_object(self : JsCreep) -> JsGameObject = "%identity"

///|
pub fn JsSource::to_game_object(self : JsSource) -> JsGameObject = "%identity"

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
