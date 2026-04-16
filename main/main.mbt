
///|
pub fn main_loop() -> Unit {
  guard @screeps.my_spawns() is [my_spawn, ..] else { return }

  let flags = @screeps.flags()
  let creeps = @screeps.my_creeps()

  let num_of_flags = flags.length()
  let num_of_creeps = creeps.length()

  if num_of_creeps < num_of_flags {
    my_spawn.spawn_creep([Move]) |> ignore
  }

  for i in 0..<min(num_of_creeps, num_of_flags) {
    creeps[i].move_to(flags[i]) |> ignore
  } 
}

fn min(a: Int, b: Int) -> Int {
  match a < b {
    true => a
    false => b
  }
}

///|
fn main {

}
