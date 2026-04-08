///|
fn body_to_raw(body : Array[BodyPartKind]) -> Array[String] {
  body.map(part => part.to_raw())
}

///|
pub fn spawn_creep(
  spawn : @model.OwnedSpawn,
  body : Array[BodyPartKind],
) -> @model.OwnedCreep raise ActionError {
  let result = spawn.to_raw().spawn_creep_raw(body_to_raw(body))
  match result.object().to_option() {
    Some(creep) => @model.OwnedCreep::create(creep)
    None =>
      match result.error().to_option() {
        Some(code) => raise action_error_of(code)
        None => raise UnknownRawError(-9999)
      }
  }
}
