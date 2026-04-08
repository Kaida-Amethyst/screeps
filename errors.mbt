///|
/// Screeps 普通动作失败原因在第一阶段统一映射到共享类型。
pub(all) enum ActionFailure {
  NotOwner
  Busy
  NotEnoughEnergy
  InvalidTarget
  Full
  NotInRange
  InvalidArgs
  Tired
  NoBodyPart
  UnknownRawError(Int)
} derive(Show, Eq)

///|
/// Screeps 普通动作在第一阶段统一映射到共享结果类型。
pub(all) enum ActionResult {
  Success
  Failed(ActionFailure)
} derive(Show, Eq)

///|
/// `spawn_creep` 的失败原因。
pub(all) enum SpawnFailure {
  SpawnNotOwner
  SpawnBusy
  SpawnNotEnoughEnergy
  SpawnInvalidArgs
  SpawnUnknownRawError(Int)
} derive(Show, Eq)

///|
/// `spawn_creep` 的正式高层结果。
pub(all) enum SpawnResult {
  Spawned(MyCreep)
  SpawnFailed(SpawnFailure)
}

///|
/// `create_construction_site` 的失败原因。
pub(all) enum CreateConstructionSiteFailure {
  CreateInvalidArgs
  CreateInvalidTarget
  CreateFull
  CreateUnknownRawError(Int)
} derive(Show, Eq)

///|
/// `create_construction_site` 的正式高层结果。
pub(all) enum CreateConstructionSiteResult {
  Created(ConstructionSite)
  CreateFailed(CreateConstructionSiteFailure)
}

///|
fn action_result_of(code : Int) -> ActionResult {
  match code {
    @raw.OK_CODE => Success
    _ => Failed(action_failure_of(code))
  }
}

///|
fn action_failure_of(code : Int) -> ActionFailure {
  match code {
    @raw.ERR_NOT_OWNER => NotOwner
    @raw.ERR_BUSY => Busy
    // Arena 中 `ERR_NOT_ENOUGH_ENERGY` 与 `ERR_NOT_ENOUGH_RESOURCES`
    // 共享同一个原始错误码 `-6`。第一阶段先统一映射到能量不足。
    @raw.ERR_NOT_ENOUGH_ENERGY => NotEnoughEnergy
    @raw.ERR_INVALID_TARGET => InvalidTarget
    @raw.ERR_FULL => Full
    @raw.ERR_NOT_IN_RANGE => NotInRange
    @raw.ERR_INVALID_ARGS => InvalidArgs
    @raw.ERR_TIRED => Tired
    @raw.ERR_NO_BODYPART => NoBodyPart
    _ => UnknownRawError(code)
  }
}

///|
fn spawn_failure_of(code : Int) -> SpawnFailure {
  match code {
    @raw.ERR_NOT_OWNER => SpawnNotOwner
    @raw.ERR_BUSY => SpawnBusy
    @raw.ERR_NOT_ENOUGH_ENERGY => SpawnNotEnoughEnergy
    @raw.ERR_INVALID_ARGS => SpawnInvalidArgs
    _ => SpawnUnknownRawError(code)
  }
}

///|
fn create_construction_site_failure_of(
  code : Int,
) -> CreateConstructionSiteFailure {
  match code {
    @raw.ERR_INVALID_ARGS => CreateInvalidArgs
    @raw.ERR_INVALID_TARGET => CreateInvalidTarget
    @raw.ERR_FULL => CreateFull
    _ => CreateUnknownRawError(code)
  }
}
