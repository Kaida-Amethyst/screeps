///|
pub fn[T : TowerAttackTarget] OwnedTower::attack(
  self : OwnedTower,
  target : T,
) -> Unit raise ActionError {
  raise_action_error(
    self.to_raw().attack_raw(target.as_tower_attack_target().to_raw()),
  )
}

///|
pub fn[T : HealTarget] OwnedTower::heal(
  self : OwnedTower,
  target : T,
) -> Unit raise ActionError {
  raise_action_error(self.to_raw().heal_raw(target.as_heal_target().to_raw()))
}
