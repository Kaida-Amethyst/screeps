///|
/// 当前包的可运行入口。
/// 这里保持最薄，只负责导出给 Screeps 使用的桥接逻辑。
/// 如需本地构建，可在项目根目录运行 `moon run cmd/main`。
#module("game/utils")
extern "js" fn getTicks() -> Int = "getTicks"

///|
pub fn main_loop() -> Unit {
  println("tick = \{getTicks()}")
}

///|
fn main {

}
