///|
/// Screeps 的导出入口。
/// 当前切到第六个 tutorial：Terrain。
using @screeps {type Creep, type Flag}

///|
fn move_to_closest_flag(creep : Creep, flags : Array[Flag]) -> Unit {
  guard creep.find_closest_by_path(flags) is Some(flag) else { return }
  creep.move_to(flag)
}

///|
pub fn main_loop() -> Unit {
  let flags = @screeps.flags()
  for creep in @screeps.my_creeps() {
    move_to_closest_flag(creep, flags)
  }
}

///|
fn main {

}
