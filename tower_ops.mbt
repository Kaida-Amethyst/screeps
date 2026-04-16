///|
/// 让己方 tower 远程攻击目标。
pub fn[T : TowerAttackTarget] MyTower::attack(
  self : MyTower,
  target : T,
) -> ActionResult {
  action_result_of(
    self.to_raw().attack_raw(target.as_tower_attack_target().to_raw()),
  )
}

///|
/// 让己方 tower 远程治疗目标 creep。
pub fn[T : HealTarget] MyTower::heal(
  self : MyTower,
  target : T,
) -> ActionResult {
  action_result_of(self.to_raw().heal_raw(target.as_heal_target().to_raw()))
}
