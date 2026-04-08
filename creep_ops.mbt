///|
pub fn[T : MoveTarget] OwnedCreep::move_to(
  self : OwnedCreep,
  target : T,
) -> Unit raise ActionError {
  raise_action_error(
    self.to_raw().move_to_raw(target.as_move_target().to_raw()),
  )
}

///|
pub fn[T : HarvestTarget] OwnedCreep::harvest(
  self : OwnedCreep,
  target : T,
) -> Unit raise ActionError {
  raise_action_error(
    self.to_raw().harvest_raw(target.as_harvest_target().to_raw()),
  )
}

///|
pub fn[T : TransferTarget] OwnedCreep::transfer(
  self : OwnedCreep,
  target : T,
  resource : ResourceKind,
) -> Unit raise ActionError {
  raise_action_error(
    self
    .to_raw()
    .transfer_raw(target.as_transfer_target().to_raw(), resource.to_raw()),
  )
}

///|
pub fn[T : TransferTarget] OwnedCreep::transfer_energy(
  self : OwnedCreep,
  target : T,
) -> Unit raise ActionError {
  self.transfer(target, Energy)
}

///|
pub fn[T : WithdrawTarget] OwnedCreep::withdraw(
  self : OwnedCreep,
  target : T,
  resource : ResourceKind,
) -> Unit raise ActionError {
  raise_action_error(
    self
    .to_raw()
    .withdraw_raw(target.as_withdraw_target().to_raw(), resource.to_raw()),
  )
}

///|
pub fn[T : WithdrawTarget] OwnedCreep::withdraw_energy(
  self : OwnedCreep,
  target : T,
) -> Unit raise ActionError {
  self.withdraw(target, Energy)
}

///|
pub fn[T : BuildTarget] OwnedCreep::build(
  self : OwnedCreep,
  target : T,
) -> Unit raise ActionError {
  raise_action_error(self.to_raw().build_raw(target.as_build_target().to_raw()))
}

///|
pub fn[T : AttackTarget] OwnedCreep::attack(
  self : OwnedCreep,
  target : T,
) -> Unit raise ActionError {
  raise_action_error(
    self.to_raw().attack_raw(target.as_attack_target().to_raw()),
  )
}

///|
pub fn[T : RangedAttackTarget] OwnedCreep::ranged_attack(
  self : OwnedCreep,
  target : T,
) -> Unit raise ActionError {
  raise_action_error(
    self.to_raw().ranged_attack_raw(target.as_ranged_attack_target().to_raw()),
  )
}

///|
pub fn[T : HealTarget] OwnedCreep::heal(
  self : OwnedCreep,
  target : T,
) -> Unit raise ActionError {
  raise_action_error(self.to_raw().heal_raw(target.as_heal_target().to_raw()))
}
