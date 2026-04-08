///|
/// Screeps 行为失败在第一阶段统一映射到共享错误类型。
pub suberror ActionError {
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
} derive(Show)

///|
fn action_error_of(code : Int) -> ActionError {
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
fn raise_action_error(code : Int) -> Unit raise ActionError {
  if code == @raw.OK_CODE {
    ()
  } else {
    raise action_error_of(code)
  }
}
