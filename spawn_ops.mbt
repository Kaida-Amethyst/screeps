///|
fn body_to_raw(body : Array[BodyPartKind]) -> Array[String] {
  body.map(part => part.to_raw())
}

///|
pub fn OwnedSpawn::spawn_creep(
  self : OwnedSpawn,
  body : Array[BodyPartKind],
) -> SpawnResult {
  let result = self.to_raw().spawn_creep_raw(body_to_raw(body))
  match result.object().to_option() {
    Some(creep) => Spawned(OwnedCreep::create(creep))
    None =>
      match result.error().to_option() {
        Some(code) => SpawnFailed(action_result_of(code))
        None => SpawnFailed(UnknownRawError(-9999))
      }
  }
}
