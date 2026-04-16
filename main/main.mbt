///|
pub fn main_loop() -> Unit {
  let flags = @screeps.flags()
  for creep in @screeps.my_creeps() {
    guard creep.find_closest(flags) is Some(flag) else { continue }
    creep.move_to(flag) |> ignore
  }
}

///|
fn main {

}
