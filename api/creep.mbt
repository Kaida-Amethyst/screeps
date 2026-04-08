///|
pub fn[T : GameObjectLike] move_to(
  creep : @model.OwnedCreep,
  target : T,
) -> Unit raise ActionError {
  raise_action_error(
    creep.to_raw().move_to_raw(target.as_game_object().to_raw()),
  )
}

///|
pub fn harvest(
  creep : @model.OwnedCreep,
  target : @model.Source,
) -> Unit raise ActionError {
  raise_action_error(creep.to_raw().harvest_raw(target.to_raw()))
}

///|
pub fn[T : GameObjectLike] transfer(
  creep : @model.OwnedCreep,
  target : T,
  resource : ResourceKind,
) -> Unit raise ActionError {
  raise_action_error(
    creep
    .to_raw()
    .transfer_raw(target.as_game_object().to_raw(), resource.to_raw()),
  )
}

///|
pub fn transfer_energy(
  creep : @model.OwnedCreep,
  target : @model.OwnedSpawn,
) -> Unit raise ActionError {
  transfer(creep, target, Energy)
}
