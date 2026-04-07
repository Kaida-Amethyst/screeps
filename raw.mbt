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
pub type StructureTower

///|
#external
pub type StructureContainer

///|
#external
pub type SpawnCreepResult

///|
#external
pub type Store

///|
#external
pub type CreepBodyPart

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
pub fn StructureTower::as_any(self : StructureTower) -> @core.Any = "%identity"

///|
pub fn StructureContainer::as_any(self : StructureContainer) -> @core.Any = "%identity"

///|
pub fn SpawnCreepResult::as_any(self : SpawnCreepResult) -> @core.Any = "%identity"

///|
pub fn Store::as_any(self : Store) -> @core.Any = "%identity"

///|
pub fn CreepBodyPart::as_any(self : CreepBodyPart) -> @core.Any = "%identity"

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
pub const ATTACK_PART : String = "attack"

///|
pub const RANGED_ATTACK_PART : String = "ranged_attack"

///|
pub const HEAL_PART : String = "heal"

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
pub fn towers() -> Array[StructureTower] {
  objects_by_type_name("StructureTower")
}

///|
pub fn containers() -> Array[StructureContainer] {
  objects_by_type_name("StructureContainer")
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
pub extern "js" fn Creep::body(self : Creep) -> Array[CreepBodyPart] =
  #| (self) => self.body

///|
pub extern "js" fn Creep::hits(self : Creep) -> Int =
  #| (self) => self.hits

///|
pub extern "js" fn Creep::hits_max(self : Creep) -> Int =
  #| (self) => self.hitsMax

///|
pub extern "js" fn Creep::harvest_raw(self : Creep, target : Source) -> Int =
  #| (self, target) => self.harvest(target)

///|
pub extern "js" fn Creep::attack_raw(self : Creep, target : GameObject) -> Int =
  #| (self, target) => self.attack(target)

///|
pub extern "js" fn Creep::ranged_attack_raw(
  self : Creep,
  target : GameObject,
) -> Int =
  #| (self, target) => self.rangedAttack(target)

///|
pub extern "js" fn Creep::heal_raw(self : Creep, target : Creep) -> Int =
  #| (self, target) => self.heal(target)

///|
pub extern "js" fn Creep::move_to_raw(self : Creep, target : GameObject) -> Int =
  #| (self, target) => self.moveTo(target)

///|
pub extern "js" fn Creep::find_closest_by_path_raw(
  self : Creep,
  positions : Array[GameObject],
) -> @core.Nullish[GameObject] =
  #| (self, positions) => self.findClosestByPath(positions)

///|
pub extern "js" fn Creep::transfer_raw(
  self : Creep,
  target : GameObject,
  resource : String,
) -> Int =
  #| (self, target, resource) => self.transfer(target, resource)

///|
pub extern "js" fn Creep::withdraw_raw(
  self : Creep,
  target : GameObject,
  resource : String,
) -> Int =
  #| (self, target, resource) => self.withdraw(target, resource)

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
) -> SpawnCreepResult =
  #| (self, body) => self.spawnCreep(body)

///|
pub extern "js" fn StructureSpawn::store(self : StructureSpawn) -> Store =
  #| (self) => self.store

///|
pub extern "js" fn SpawnCreepResult::spawned_creep(
  self : SpawnCreepResult,
) -> @core.Nullish[Creep] =
  #| (self) => self.object

///|
pub extern "js" fn StructureTower::store(self : StructureTower) -> Store =
  #| (self) => self.store

///|
pub extern "js" fn StructureTower::attack_raw(
  self : StructureTower,
  target : GameObject,
) -> Int =
  #| (self, target) => self.attack(target)

///|
pub extern "js" fn StructureContainer::store(
  self : StructureContainer,
) -> Store =
  #| (self) => self.store

///|
pub extern "js" fn Store::used_energy(self : Store) -> Int =
  #| (self) => self.getUsedCapacity("energy") ?? 0

///|
pub extern "js" fn Store::free_energy(self : Store) -> Int =
  #| (self) => self.getFreeCapacity("energy") ?? 0

///|
pub extern "js" fn CreepBodyPart::part_type(self : CreepBodyPart) -> String =
  #| (self) => self.type

///|
pub extern "js" fn CreepBodyPart::hits(self : CreepBodyPart) -> Int =
  #| (self) => self.hits
