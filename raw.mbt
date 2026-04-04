///|
/// Screeps 的最小原始绑定层。
/// 这里只放后续 tutorial 和 bot 骨架马上要用到的能力。

///|
#external
pub type GameObject

///|
#external
pub type Creep

///|
#external
pub type Source

///|
#external
pub type Flag

///|
#external
pub type StructureSpawn

///|
#external
pub type Store

///|
pub fn GameObject::as_any(self : GameObject) -> @core.Any = "%identity"

///|
pub fn Creep::as_any(self : Creep) -> @core.Any = "%identity"

///|
pub fn Source::as_any(self : Source) -> @core.Any = "%identity"

///|
pub fn Flag::as_any(self : Flag) -> @core.Any = "%identity"

///|
pub fn StructureSpawn::as_any(self : StructureSpawn) -> @core.Any = "%identity"

///|
pub fn Store::as_any(self : Store) -> @core.Any = "%identity"

///|
pub const OK_CODE : Int = 0

///|
pub const ERR_NOT_IN_RANGE : Int = -9

///|
pub const MOVE_PART : String = "move"

///|
pub const CARRY_PART : String = "carry"

///|
pub const WORK_PART : String = "work"

///|
pub const RESOURCE_ENERGY : String = "energy"

///|
#module("game/utils")
extern "js" fn get_objects_ffi() -> Array[@core.Any] = "getObjects"

///|
#module("game/utils")
pub extern "js" fn get_ticks() -> Int = "getTicks"

///|
extern "js" fn object_type_name(object : @core.Any) -> String =
  #| (object) => object?.constructor?.name ?? ""

///|
fn[T] objects_by_type_name(type_name : String) -> Array[T] {
  get_objects_ffi()
  .filter(object => object_type_name(object) == type_name)
  .map(object => object.cast())
}

///|
pub fn creeps() -> Array[Creep] {
  objects_by_type_name("Creep")
}

///|
pub fn sources() -> Array[Source] {
  objects_by_type_name("Source")
}

///|
pub fn flags() -> Array[Flag] {
  objects_by_type_name("Flag")
}

///|
pub fn spawns() -> Array[StructureSpawn] {
  objects_by_type_name("StructureSpawn")
}

///|
pub fn my_creeps() -> Array[Creep] {
  creeps().filter(creep => creep.my())
}

///|
pub fn my_spawns() -> Array[StructureSpawn] {
  spawns().filter(spawn => spawn.my())
}

///|
pub fn active_sources() -> Array[Source] {
  sources().filter(source => source.energy() > 0)
}

///|
pub extern "js" fn Creep::my(self : Creep) -> Bool =
  #| (self) => self.my

///|
pub extern "js" fn Creep::store(self : Creep) -> Store =
  #| (self) => self.store

///|
pub extern "js" fn Creep::harvest_raw(self : Creep, target : Source) -> Int =
  #| (self, target) => self.harvest(target)

///|
pub extern "js" fn Creep::move_to_raw(self : Creep, target : GameObject) -> Int =
  #| (self, target) => self.moveTo(target)

///|
pub extern "js" fn Creep::transfer_raw(
  self : Creep,
  target : GameObject,
  resource : String,
) -> Int =
  #| (self, target, resource) => self.transfer(target, resource)

///|
pub extern "js" fn Source::energy(self : Source) -> Int =
  #| (self) => self.energy

///|
pub extern "js" fn StructureSpawn::my(self : StructureSpawn) -> Bool =
  #| (self) => self.my

///|
pub extern "js" fn StructureSpawn::is_spawning(self : StructureSpawn) -> Bool =
  #| (self) => self.spawning != null

///|
pub extern "js" fn StructureSpawn::spawn_creep(
  self : StructureSpawn,
  body : Array[String],
) -> @core.Any =
  #| (self, body) => self.spawnCreep(body)

///|
pub extern "js" fn StructureSpawn::store(self : StructureSpawn) -> Store =
  #| (self) => self.store

///|
pub extern "js" fn Store::used_energy(self : Store) -> Int =
  #| (self) => self.getUsedCapacity("energy") ?? 0

///|
pub extern "js" fn Store::free_energy(self : Store) -> Int =
  #| (self) => self.getFreeCapacity("energy") ?? 0
