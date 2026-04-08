///|
/// Screeps 普通动作在第一阶段统一映射到共享结果类型。
pub(all) enum ActionResult {
  Success
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
/// `spawn_creep` 的正式高层结果。
pub(all) enum SpawnResult {
  Spawned(OwnedCreep)
  SpawnFailed(ActionResult)
}

///|
/// `create_construction_site` 的正式高层结果。
pub(all) enum CreateConstructionSiteResult {
  Created(ConstructionSite)
  CreateFailed(ActionResult)
}

///|
fn action_result_of(code : Int) -> ActionResult {
  match code {
    @raw.OK_CODE => Success
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
