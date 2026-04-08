///|
fn body_to_raw(body : Array[BodyPartKind]) -> Array[String] {
  body.map(part => part.to_raw())
}

///|
pub fn MySpawn::spawn_creep(
  self : MySpawn,
  body : Array[BodyPartKind],
) -> SpawnResult {
  let result = self.to_raw().spawn_creep_raw(body_to_raw(body))
  match result.object().to_option() {
    Some(creep) => Spawned(MyCreep::create(creep))
    None =>
      match result.error().to_option() {
        Some(code) => SpawnFailed(action_result_of(code))
        None => SpawnFailed(UnknownRawError(-9999))
      }
  }
}
