///|
pub fn[T : GameObjectLike] OwnedTower::attack(
  self : OwnedTower,
  target : T,
) -> Unit raise ActionError {
  raise_action_error(self.to_raw().attack_raw(target.as_game_object().to_raw()))
}

///|
pub fn[T : GameObjectLike] OwnedTower::heal(
  self : OwnedTower,
  target : T,
) -> Unit raise ActionError {
  raise_action_error(self.to_raw().heal_raw(target.as_game_object().to_raw()))
}
