///|
pub fn[T : MoveTarget] MyCreep::move_to(
  self : MyCreep,
  target : T,
) -> ActionResult {
  action_result_of(self.to_raw().move_to_raw(target.as_move_target().to_raw()))
}

///|
pub fn[T : MoveTarget] MyCreep::move_if_not_in_range(
  self : MyCreep,
  target : T,
  result : ActionResult,
) -> Unit {
  match result {
    Failed(NotInRange) => ignore(self.move_to(target))
    _ => ()
  }
}

///|
pub fn[T : HarvestTarget] MyCreep::harvest(
  self : MyCreep,
  target : T,
) -> ActionResult {
  action_result_of(
    self.to_raw().harvest_raw(target.as_harvest_target().to_raw()),
  )
}

///|
pub fn[T : HarvestTarget] MyCreep::harvest_or_move(
  self : MyCreep,
  target : T,
) -> Unit {
  self.move_if_not_in_range(target.as_harvest_target(), self.harvest(target))
}

///|
pub fn[T : TransferTarget] MyCreep::transfer(
  self : MyCreep,
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
pub fn[T : TransferTarget] MyCreep::transfer_or_move(
  self : MyCreep,
  target : T,
  resource : ResourceKind,
) -> Unit {
  self.move_if_not_in_range(
    target.as_transfer_target(),
    self.transfer(target, resource),
  )
}

///|
pub fn[T : TransferTarget] MyCreep::transfer_energy(
  self : MyCreep,
  target : T,
) -> ActionResult {
  self.transfer(target, Energy)
}

///|
pub fn[T : TransferTarget] MyCreep::transfer_energy_or_move(
  self : MyCreep,
  target : T,
) -> Unit {
  self.move_if_not_in_range(
    target.as_transfer_target(),
    self.transfer_energy(target),
  )
}

///|
pub fn[T : WithdrawTarget] MyCreep::withdraw(
  self : MyCreep,
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
pub fn[T : WithdrawTarget] MyCreep::withdraw_or_move(
  self : MyCreep,
  target : T,
  resource : ResourceKind,
) -> Unit {
  self.move_if_not_in_range(
    target.as_withdraw_target(),
    self.withdraw(target, resource),
  )
}

///|
pub fn[T : WithdrawTarget] MyCreep::withdraw_energy(
  self : MyCreep,
  target : T,
) -> ActionResult {
  self.withdraw(target, Energy)
}

///|
pub fn[T : WithdrawTarget] MyCreep::withdraw_energy_or_move(
  self : MyCreep,
  target : T,
) -> Unit {
  self.move_if_not_in_range(
    target.as_withdraw_target(),
    self.withdraw_energy(target),
  )
}

///|
pub fn[T : BuildTarget] MyCreep::build(
  self : MyCreep,
  target : T,
) -> ActionResult {
  action_result_of(self.to_raw().build_raw(target.as_build_target().to_raw()))
}

///|
pub fn[T : BuildTarget] MyCreep::build_or_move(
  self : MyCreep,
  target : T,
) -> Unit {
  self.move_if_not_in_range(target.as_build_target(), self.build(target))
}

///|
pub fn[T : AttackTarget] MyCreep::attack(
  self : MyCreep,
  target : T,
) -> ActionResult {
  action_result_of(self.to_raw().attack_raw(target.as_attack_target().to_raw()))
}

///|
pub fn[T : AttackTarget] MyCreep::attack_or_move(
  self : MyCreep,
  target : T,
) -> Unit {
  self.move_if_not_in_range(target.as_attack_target(), self.attack(target))
}

///|
pub fn[T : RangedAttackTarget] MyCreep::ranged_attack(
  self : MyCreep,
  target : T,
) -> ActionResult {
  action_result_of(
    self.to_raw().ranged_attack_raw(target.as_ranged_attack_target().to_raw()),
  )
}

///|
pub fn[T : RangedAttackTarget] MyCreep::ranged_attack_or_move(
  self : MyCreep,
  target : T,
) -> Unit {
  self.move_if_not_in_range(
    target.as_ranged_attack_target(),
    self.ranged_attack(target),
  )
}

///|
pub fn[T : HealTarget] MyCreep::heal(
  self : MyCreep,
  target : T,
) -> ActionResult {
  action_result_of(self.to_raw().heal_raw(target.as_heal_target().to_raw()))
}

///|
pub fn[T : HealTarget] MyCreep::heal_or_move(
  self : MyCreep,
  target : T,
) -> Unit {
  self.move_if_not_in_range(target.as_heal_target(), self.heal(target))
}
