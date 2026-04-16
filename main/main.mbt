///|
pub fn main_loop() -> Unit {
  guard @screeps.my_creeps() is [my_creep, ..] else { return }
  guard @screeps.enemy_creeps() is [enemy_creep, ..] else { return }
  my_creep.attack_or_move(enemy_creep)
}

///|
fn main {

}
