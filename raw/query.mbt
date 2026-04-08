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
pub fn spawns() -> Array[JsStructureSpawn] {
  cast_objects(get_objects_by_prototype_name_ffi("StructureSpawn"))
}
