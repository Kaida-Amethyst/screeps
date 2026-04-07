///|
/// Screeps 的导出入口。
/// 当前切到第七个 tutorial：Spawn creeps。
using @screeps {type Creep, type Flag, type StructureSpawn}

///|
fn spawn_mover(spawn : StructureSpawn) -> Creep? {
  spawn.spawn([@screeps.MOVE_PART])
}

///|
fn move_creeps_to_flags(creeps : Array[Creep], flags : Array[Flag]) -> Unit {
  for i in 0..<creeps.length().min(flags.length()) {
    creeps[i].move_to(flags[i])
  }
}

///|
pub fn main_loop() -> Unit {
  guard @screeps.my_spawns() is [my_spawn, ..] else { return }
  let creeps = @screeps.my_creeps()
  let flags = @screeps.flags()

  if creeps.length() < flags.length() {
    spawn_mover(my_spawn) |> ignore
  }
  move_creeps_to_flags(creeps, flags)
}

///|
fn main {

}
