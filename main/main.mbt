///|
pub fn main_loop() -> Unit {
  let my_creeps = @screeps.my_creeps()
  guard @screeps.enemy_creeps() is [enemy_creep, ..] else { return }
  let damaged_creeps = my_creeps.filter(creep => creep.hp() < creep.max_hp())
  let melee_creeps = my_creeps.filter(creep => {
    creep.has_body_part(@screeps.Attack)
  })
  let healers = my_creeps.filter(creep => creep.has_body_part(@screeps.Heal))
  let ranged_creeps = my_creeps.filter(creep => {
    creep.has_body_part(@screeps.RangedAttack)
  })

  for creep in melee_creeps {
    creep.attack_or_move(enemy_creep)
  }

  for creep in ranged_creeps {
    creep.ranged_attack_or_move(enemy_creep)
  }

  if damaged_creeps is [damaged_creep, ..] {
    for creep in healers {
      creep.heal_or_move(damaged_creep)
    }
  }
}

///|
fn main {

}
