///|
pub fn main_loop() -> Unit {
  guard @screeps.my_creeps() is [creep, ..] else { return }
  guard @screeps.flags() is [flag, ..] else { return }
  creep.move_to(flag) |> ignore
}

///|
fn main {

}
