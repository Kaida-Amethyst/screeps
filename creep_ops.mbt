///|
pub fn[T : MoveTarget] OwnedCreep::move_to(
  self : OwnedCreep,
  target : T,
) -> ActionResult {
  action_result_of(self.to_raw().move_to_raw(target.as_move_target().to_raw()))
}

///|
pub fn[T : MoveTarget] OwnedCreep::move_if_not_in_range(
  self : OwnedCreep,
  target : T,
  result : ActionResult,
) -> Unit {
  match result {
    NotInRange => ignore(self.move_to(target))
    _ => ()
  }
}

///|
pub fn[T : HarvestTarget] OwnedCreep::harvest(
  self : OwnedCreep,
  target : T,
) -> ActionResult {
  action_result_of(
    self.to_raw().harvest_raw(target.as_harvest_target().to_raw()),
  )
}

///|
pub fn[T : HarvestTarget] OwnedCreep::harvest_or_move(
  self : OwnedCreep,
  target : T,
) -> Unit {
  self.move_if_not_in_range(target.as_harvest_target(), self.harvest(target))
}

///|
pub fn[T : TransferTarget] OwnedCreep::transfer(
  self : OwnedCreep,
  target : T,
  resource : ResourceKind,
) -> ActionResult {
  action_result_of(
    self
    .to_raw()
    .transfer_raw(target.as_transfer_target().to_raw(), resource.to_raw()),
  )
}

///|
pub fn[T : TransferTarget] OwnedCreep::transfer_or_move(
  self : OwnedCreep,
  target : T,
  resource : ResourceKind,
) -> Unit {
  self.move_if_not_in_range(
    target.as_transfer_target(),
    self.transfer(target, resource),
  )
}

///|
pub fn[T : TransferTarget] OwnedCreep::transfer_energy(
  self : OwnedCreep,
  target : T,
) -> ActionResult {
  self.transfer(target, Energy)
}

///|
pub fn[T : TransferTarget] OwnedCreep::transfer_energy_or_move(
  self : OwnedCreep,
  target : T,
) -> Unit {
  self.move_if_not_in_range(
    target.as_transfer_target(),
    self.transfer_energy(target),
  )
}

///|
pub fn[T : WithdrawTarget] OwnedCreep::withdraw(
  self : OwnedCreep,
  target : T,
  resource : ResourceKind,
) -> ActionResult {
  action_result_of(
    self
    .to_raw()
    .withdraw_raw(target.as_withdraw_target().to_raw(), resource.to_raw()),
  )
}

///|
pub fn[T : WithdrawTarget] OwnedCreep::withdraw_or_move(
  self : OwnedCreep,
  target : T,
  resource : ResourceKind,
) -> Unit {
  self.move_if_not_in_range(
    target.as_withdraw_target(),
    self.withdraw(target, resource),
  )
}

///|
pub fn[T : WithdrawTarget] OwnedCreep::withdraw_energy(
  self : OwnedCreep,
  target : T,
) -> ActionResult {
  self.withdraw(target, Energy)
}

///|
pub fn[T : WithdrawTarget] OwnedCreep::withdraw_energy_or_move(
  self : OwnedCreep,
  target : T,
) -> Unit {
  self.move_if_not_in_range(
    target.as_withdraw_target(),
    self.withdraw_energy(target),
  )
}

///|
pub fn[T : BuildTarget] OwnedCreep::build(
  self : OwnedCreep,
  target : T,
) -> ActionResult {
  action_result_of(self.to_raw().build_raw(target.as_build_target().to_raw()))
}

///|
pub fn[T : BuildTarget] OwnedCreep::build_or_move(
  self : OwnedCreep,
  target : T,
) -> Unit {
  self.move_if_not_in_range(target.as_build_target(), self.build(target))
}

///|
pub fn[T : AttackTarget] OwnedCreep::attack(
  self : OwnedCreep,
  target : T,
) -> ActionResult {
  action_result_of(self.to_raw().attack_raw(target.as_attack_target().to_raw()))
}

///|
pub fn[T : AttackTarget] OwnedCreep::attack_or_move(
  self : OwnedCreep,
  target : T,
) -> Unit {
  self.move_if_not_in_range(target.as_attack_target(), self.attack(target))
}

///|
pub fn[T : RangedAttackTarget] OwnedCreep::ranged_attack(
  self : OwnedCreep,
  target : T,
) -> ActionResult {
  action_result_of(
    self.to_raw().ranged_attack_raw(target.as_ranged_attack_target().to_raw()),
  )
}

///|
pub fn[T : RangedAttackTarget] OwnedCreep::ranged_attack_or_move(
  self : OwnedCreep,
  target : T,
) -> Unit {
  self.move_if_not_in_range(
    target.as_ranged_attack_target(),
    self.ranged_attack(target),
  )
}

///|
pub fn[T : HealTarget] OwnedCreep::heal(
  self : OwnedCreep,
  target : T,
) -> ActionResult {
  action_result_of(self.to_raw().heal_raw(target.as_heal_target().to_raw()))
}

///|
pub fn[T : HealTarget] OwnedCreep::heal_or_move(
  self : OwnedCreep,
  target : T,
) -> Unit {
  self.move_if_not_in_range(target.as_heal_target(), self.heal(target))
}
