///|
/// Screeps 的导出入口。
/// 当前切到第二个 tutorial：Simple move。

///|
pub fn main_loop() -> Unit {
  guard @screeps.creeps() is [creep, ..] else { return }
  guard @screeps.flags() is [flag, ..] else { return }
  creep.move_to(flag)
}

///|
fn main {

}
