///|
/// 直接调用官方 `getTicks`。
#module("game/utils")
pub extern "js" fn get_ticks() -> Int = "getTicks"

///|
/// 获取当前游戏中的全部对象。
#module("game/utils")
pub extern "js" fn get_objects() -> Array[JsGameObject] = "getObjects"

///|
/// 通过 id 获取对象。
#module("game/utils")
extern "js" fn get_object_by_id_ffi(id : String) -> @core.Nullish[JsGameObject] = "getObjectById"

///|
pub fn get_object_by_id(id : String) -> JsGameObject? {
  get_object_by_id_ffi(id).to_option()
}

///|
extern "js" fn get_objects_by_prototype_name_ffi(
  name : String,
) -> Array[@core.Any] =
  #| (name) => {
  #|   const host = globalThis.__moonbit_screeps_host;
  #|   if (!host?.getObjectsByPrototypeName) {
  #|     throw new Error("Missing __moonbit_screeps_host.getObjectsByPrototypeName");
  #|   }
  #|   return host.getObjectsByPrototypeName(name);
  #| }

///|
fn[T] cast_objects(values : Array[@core.Any]) -> Array[T] {
  values.map(value => value.cast())
}

///|
pub fn creeps() -> Array[JsCreep] {
  cast_objects(get_objects_by_prototype_name_ffi("Creep"))
}

///|
pub fn sources() -> Array[JsSource] {
  cast_objects(get_objects_by_prototype_name_ffi("Source"))
}

///|
pub fn flags() -> Array[JsFlag] {
  cast_objects(get_objects_by_prototype_name_ffi("Flag"))
}

///|
pub fn structures() -> Array[JsGameObject] {
  cast_objects(get_objects_by_prototype_name_ffi("Structure"))
}

///|
pub fn spawns() -> Array[JsStructureSpawn] {
  cast_objects(get_objects_by_prototype_name_ffi("StructureSpawn"))
}

///|
pub fn towers() -> Array[JsStructureTower] {
  cast_objects(get_objects_by_prototype_name_ffi("StructureTower"))
}

///|
pub fn containers() -> Array[JsStructureContainer] {
  cast_objects(get_objects_by_prototype_name_ffi("StructureContainer"))
}

///|
pub fn construction_sites() -> Array[JsConstructionSite] {
  cast_objects(get_objects_by_prototype_name_ffi("ConstructionSite"))
}

///|
extern "js" fn create_construction_site_by_name_ffi(
  x : Int,
  y : Int,
  name : String,
) -> JsCreateConstructionSiteResult =
  #| (x, y, name) => {
  #|   const host = globalThis.__moonbit_screeps_host;
  #|   if (!host?.createConstructionSiteByPrototypeName) {
  #|     throw new Error("Missing __moonbit_screeps_host.createConstructionSiteByPrototypeName");
  #|   }
  #|   return host.createConstructionSiteByPrototypeName({ x, y }, name);
  #| }

///|
pub fn create_construction_site_by_name(
  x : Int,
  y : Int,
  name : String,
) -> JsCreateConstructionSiteResult {
  create_construction_site_by_name_ffi(x, y, name)
}

///|
pub extern "js" fn JsCreateConstructionSiteResult::object(
  self : JsCreateConstructionSiteResult,
) -> @core.Nullish[JsConstructionSite] =
  #| (self) => self.object

///|
pub extern "js" fn JsCreateConstructionSiteResult::error(
  self : JsCreateConstructionSiteResult,
) -> @core.Nullish[Int] =
  #| (self) => self.error
