///|
pub fn main_loop() -> Unit {
  guard @screeps.my_towers() is [tower, ..] else { return }
  guard @screeps.my_creeps() is [my_creep, ..] else { return }
  guard @screeps.containers() is [container, ..] else { return }
  guard @screeps.enemy_creeps() is [target, ..] else { return }

  if tower.store().energy() >= 10 {
    tower.attack(target) |> ignore
    return
  }

  match my_creep.store().energy() {
    0 => my_creep.withdraw_energy_or_move(container)
    _ => my_creep.transfer_energy_or_move(tower)
  }
}

///|
fn main {

}
