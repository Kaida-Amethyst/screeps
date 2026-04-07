///|
/// Screeps 的导出入口。
/// 当前切到第九个 tutorial：Construction。
using @screeps {type ConstructionSite, type Creep, type StructureContainer}

///|
fn withdraw_from_closest_container(
  creep : Creep,
  containers : Array[StructureContainer],
) -> Unit {
  guard creep.find_closest_by_path(containers) is Some(container) else {
    return
  }
  if creep.withdraw_energy_result(container) is @screeps.NotInRange {
    creep.move_to(container)
  }
}

///|
fn build_construction_site(creep : Creep, site : ConstructionSite) -> Unit {
  if creep.build_result(site) is @screeps.NotInRange {
    creep.move_to(site)
  }
}

///|
pub fn main_loop() -> Unit {
  guard @screeps.my_creeps() is [creep, ..] else { return }
  if creep.store().energy() == 0 {
    withdraw_from_closest_container(creep, @screeps.containers())
    return
  }
  match @screeps.my_construction_sites() {
    [site, ..] => build_construction_site(creep, site)
    _ => ignore(@screeps.create_tower_construction_site(50, 55))
  }
}

///|
fn main {

}
