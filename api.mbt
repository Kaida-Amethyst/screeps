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
/// 可以作为 `attack` 目标的对象。
/// 当前先只给 `Creep` 实现，后面补到结构和工地时再继续扩展。
pub(open) trait AttackTarget {
  as_attack_target(Self) -> GameObject
}

///|
/// 可以作为 `rangedAttack` 目标的对象。
/// 当前先只给 `Creep` 实现，等后面补结构时再继续扩展。
pub(open) trait RangedAttackTarget {
  as_ranged_attack_target(Self) -> GameObject
}

///|
/// 可以作为 `transfer` 目标的对象。
/// 当前只覆盖已经绑定出来的目标类型。
pub(open) trait TransferTarget {
  as_transfer_target(Self) -> GameObject
}

///|
/// 可以作为 `withdraw` 目标的对象。
/// 当前只覆盖 tutorial 里会用到的结构类型。
pub(open) trait WithdrawTarget {
  as_withdraw_target(Self) -> GameObject
}

///|
/// 可以作为塔攻击目标的对象。
/// 这一层先只覆盖 tutorial 里出现的 creep。
pub(open) trait TowerAttackTarget {
  as_tower_attack_target(Self) -> GameObject
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
pub impl GameObjectLike for StructureTower with as_game_object(self) -> GameObject = "%identity"

///|
pub impl GameObjectLike for StructureContainer with as_game_object(self) -> GameObject = "%identity"

///|
pub impl AttackTarget for Creep with as_attack_target(self) -> GameObject = "%identity"

///|
pub impl RangedAttackTarget for Creep with as_ranged_attack_target(self) -> GameObject = "%identity"

///|
pub impl TransferTarget for Creep with as_transfer_target(self) -> GameObject = "%identity"

///|
pub impl TransferTarget for StructureSpawn with as_transfer_target(self) -> GameObject = "%identity"

///|
pub impl TransferTarget for StructureTower with as_transfer_target(self) -> GameObject = "%identity"

///|
pub impl TransferTarget for StructureContainer with as_transfer_target(self) -> GameObject = "%identity"

///|
pub impl WithdrawTarget for StructureSpawn with as_withdraw_target(self) -> GameObject = "%identity"

///|
pub impl WithdrawTarget for StructureTower with as_withdraw_target(self) -> GameObject = "%identity"

///|
pub impl WithdrawTarget for StructureContainer with as_withdraw_target(self) -> GameObject = "%identity"

///|
pub impl TowerAttackTarget for Creep with as_tower_attack_target(self) -> GameObject = "%identity"

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
pub fn[T : GameObjectLike] Creep::find_closest_by_path(
  self : Creep,
  targets : Array[T],
) -> T? {
  match
    self
    .find_closest_by_path_raw(
      targets.map(target => GameObjectLike::as_game_object(target)),
    )
    .to_option() {
    Some(target) => Some(target.as_any().cast())
    None => None
  }
}

///|
pub fn[T : AttackTarget] Creep::attack(self : Creep, target : T) -> Unit {
  ignore(self.attack_result(target))
}

///|
pub fn[T : AttackTarget] Creep::attack_result(
  self : Creep,
  target : T,
) -> ActionResult {
  action_result_of(self.attack_raw(AttackTarget::as_attack_target(target)))
}

///|
pub fn[T : RangedAttackTarget] Creep::ranged_attack(
  self : Creep,
  target : T,
) -> Unit {
  ignore(self.ranged_attack_result(target))
}

///|
pub fn[T : RangedAttackTarget] Creep::ranged_attack_result(
  self : Creep,
  target : T,
) -> ActionResult {
  action_result_of(
    self.ranged_attack_raw(RangedAttackTarget::as_ranged_attack_target(target)),
  )
}

///|
pub fn Creep::heal(self : Creep, target : Creep) -> Unit {
  ignore(self.heal_result(target))
}

///|
pub fn Creep::heal_result(self : Creep, target : Creep) -> ActionResult {
  action_result_of(self.heal_raw(target))
}

///|
pub fn Creep::harvest_result(self : Creep, target : Source) -> ActionResult {
  action_result_of(self.harvest_raw(target))
}

///|
pub fn Creep::has_body_part(self : Creep, part_type : String) -> Bool {
  self.body().any(body_part => body_part.part_type() == part_type)
}

///|
pub fn Creep::is_damaged(self : Creep) -> Bool {
  self.hits() < self.hits_max()
}

///|
pub fn[T : TransferTarget] Creep::transfer_resource_result(
  self : Creep,
  target : T,
  resource : String,
) -> ActionResult {
  action_result_of(
    self.transfer_raw(TransferTarget::as_transfer_target(target), resource),
  )
}

///|
pub fn[T : TransferTarget] Creep::transfer_energy_result(
  self : Creep,
  target : T,
) -> ActionResult {
  self.transfer_resource_result(target, RESOURCE_ENERGY)
}

///|
pub fn[T : WithdrawTarget] Creep::withdraw_resource_result(
  self : Creep,
  target : T,
  resource : String,
) -> ActionResult {
  action_result_of(
    self.withdraw_raw(WithdrawTarget::as_withdraw_target(target), resource),
  )
}

///|
pub fn[T : WithdrawTarget] Creep::withdraw_energy_result(
  self : Creep,
  target : T,
) -> ActionResult {
  self.withdraw_resource_result(target, RESOURCE_ENERGY)
}

///|
pub fn[T : TowerAttackTarget] StructureTower::attack(
  self : StructureTower,
  target : T,
) -> Unit {
  ignore(self.attack_result(target))
}

///|
pub fn[T : TowerAttackTarget] StructureTower::attack_result(
  self : StructureTower,
  target : T,
) -> ActionResult {
  action_result_of(
    self.attack_raw(TowerAttackTarget::as_tower_attack_target(target)),
  )
}

///|
pub fn Store::energy(self : Store) -> Int {
  self.used_energy()
}

///|
pub fn enemy_creeps() -> Array[Creep] {
  creeps().filter(creep => !creep.my())
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
