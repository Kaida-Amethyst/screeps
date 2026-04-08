///|
pub fn[T : GameObjectLike] OwnedCreep::move_to(
  self : OwnedCreep,
  target : T,
) -> Unit raise ActionError {
  raise_action_error(
    self.to_raw().move_to_raw(target.as_game_object().to_raw()),
  )
}

///|
pub fn OwnedCreep::harvest(
  self : OwnedCreep,
  target : Source,
) -> Unit raise ActionError {
  raise_action_error(self.to_raw().harvest_raw(target.to_raw()))
}

///|
pub fn[T : GameObjectLike] OwnedCreep::transfer(
  self : OwnedCreep,
  target : T,
  resource : ResourceKind,
) -> Unit raise ActionError {
  raise_action_error(
    self
    .to_raw()
    .transfer_raw(target.as_game_object().to_raw(), resource.to_raw()),
  )
}

///|
pub fn OwnedCreep::transfer_energy(
  self : OwnedCreep,
  target : OwnedSpawn,
) -> Unit raise ActionError {
  self.transfer(target, Energy)
}

///|
pub fn[T : GameObjectLike] OwnedCreep::withdraw(
  self : OwnedCreep,
  target : T,
  resource : ResourceKind,
) -> Unit raise ActionError {
  raise_action_error(
    self
    .to_raw()
    .withdraw_raw(target.as_game_object().to_raw(), resource.to_raw()),
  )
}

///|
pub fn OwnedCreep::withdraw_energy(
  self : OwnedCreep,
  target : StructureContainer,
) -> Unit raise ActionError {
  self.withdraw(target, Energy)
}

///|
pub fn OwnedCreep::build(
  self : OwnedCreep,
  target : ConstructionSite,
) -> Unit raise ActionError {
  raise_action_error(self.to_raw().build_raw(target.to_raw()))
}
