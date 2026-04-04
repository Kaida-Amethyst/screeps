///|
/// 更接近 MoonBit 使用方式的 API 层。
/// 当前只先实现第一版 harvest bot 骨架，后续会随着 tutorial 逐步扩展。

///|
/// 可以被当成 `GameObject` 使用的对象。
/// 这层主要用来把 `Flag`、`Source`、`StructureSpawn` 等对象
/// 统一接到更自然的高层 API 上。
pub(open) trait GameObjectLike {
  as_game_object(Self) -> GameObject
}

///|
pub impl GameObjectLike for GameObject with as_game_object(self) -> GameObject {
  self
}

///|
pub impl GameObjectLike for Creep with as_game_object(self) -> GameObject = "%identity"

///|
pub impl GameObjectLike for Source with as_game_object(self) -> GameObject = "%identity"

///|
pub impl GameObjectLike for Flag with as_game_object(self) -> GameObject = "%identity"

///|
pub impl GameObjectLike for StructureSpawn with as_game_object(self) -> GameObject = "%identity"

///|
pub enum ActionResult {
  Success
  NotInRange
  Error(Int)
}

///|
fn action_result_of(code : Int) -> ActionResult {
  if code == OK_CODE {
    Success
  } else if code == ERR_NOT_IN_RANGE {
    NotInRange
  } else {
    Error(code)
  }
}

///|
pub fn[T : GameObjectLike] Creep::move_to(self : Creep, target : T) -> Unit {
  ignore(self.move_to_result(target))
}

///|
pub fn[T : GameObjectLike] Creep::move_to_result(
  self : Creep,
  target : T,
) -> ActionResult {
  action_result_of(self.move_to_raw(GameObjectLike::as_game_object(target)))
}

///|
pub fn Creep::harvest_result(self : Creep, target : Source) -> ActionResult {
  action_result_of(self.harvest_raw(target))
}

///|
pub fn[T : GameObjectLike] Creep::transfer_resource_result(
  self : Creep,
  target : T,
  resource : String,
) -> ActionResult {
  action_result_of(
    self.transfer_raw(GameObjectLike::as_game_object(target), resource),
  )
}

///|
pub fn[T : GameObjectLike] Creep::transfer_energy_result(
  self : Creep,
  target : T,
) -> ActionResult {
  self.transfer_resource_result(target, RESOURCE_ENERGY)
}

///|
fn worker_body() -> Array[String] {
  [WORK_PART, CARRY_PART, MOVE_PART]
}

///|
fn ensure_worker() -> Unit {
  let spawns = my_spawns()
  if spawns.length() == 0 {
    return
  }
  if my_creeps().length() > 0 {
    return
  }
  let spawn = spawns[0]
  if spawn.is_spawning() {
    return
  }
  ignore(spawn.spawn_creep(worker_body()))
}

///|
fn run_worker(creep : Creep, source : Source, home : StructureSpawn) -> Unit {
  if creep.store().used_energy() > 0 {
    match creep.transfer_energy_result(home) {
      Success => ()
      NotInRange => creep.move_to(home)
      Error(_) => ()
    }
    return
  }
  match creep.harvest_result(source) {
    Success => ()
    NotInRange => creep.move_to(source)
    Error(_) => ()
  }
}

///|
pub fn run_harvest_bot() -> Unit {
  ensure_worker()
  let sources = active_sources()
  let spawns = my_spawns()
  if sources.length() == 0 || spawns.length() == 0 {
    return
  }
  let source = sources[0]
  let home = spawns[0]
  for creep in my_creeps() {
    run_worker(creep, source, home)
  }
}
