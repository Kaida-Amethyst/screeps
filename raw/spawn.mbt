///|
pub extern "js" fn JsStructureSpawn::my(
  self : JsStructureSpawn,
) -> @core.Nullish[Bool] =
  #| (self) => self.my

///|
pub extern "js" fn JsStructureSpawn::store(self : JsStructureSpawn) -> JsStore =
  #| (self) => self.store

///|
pub extern "js" fn JsStructureSpawn::hits(self : JsStructureSpawn) -> Int =
  #| (self) => self.hits ?? 0

///|
pub extern "js" fn JsStructureSpawn::hits_max(self : JsStructureSpawn) -> Int =
  #| (self) => self.hitsMax ?? 0

///|
pub extern "js" fn JsStructureSpawn::spawn_creep_raw(
  self : JsStructureSpawn,
  body : Array[String],
) -> JsSpawnCreepResult =
  #| (self, body) => self.spawnCreep(body)

///|
pub extern "js" fn JsSpawnCreepResult::object(
  self : JsSpawnCreepResult,
) -> @core.Nullish[JsCreep] =
  #| (self) => self.object

///|
pub extern "js" fn JsSpawnCreepResult::error(
  self : JsSpawnCreepResult,
) -> @core.Nullish[Int] =
  #| (self) => self.error
