///|
pub fn main_loop() -> Unit {
  guard @screeps.my_creeps() is [creep, ..] else { return }
  let containers = @screeps.containers()
  
  if creep.store().energy() == 0 {
    if creep.find_closest(containers) is Some(container) {
      creep.withdraw_energy_or_move(container) |> ignore
    }
    return
  }

  match @screeps.my_construction_sites() {
    [construction_site, ..] => creep.build_or_move(construction_site)
    _ => @screeps.create_construction_site(50, 55, Tower) |> ignore
  }
}

///|
fn main {

}
