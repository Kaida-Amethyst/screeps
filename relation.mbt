///|
/// 所有权关系在 model 层以枚举形式保存，避免重复的布尔字段。
pub enum Relation {
  Mine
  Enemy
  Neutral
} derive(Show, Eq, Compare)

///|
/// 将可能为 `None` 的 `my` 标记转换为统一的 `Relation`。
pub fn relation_of_my_flag(my : Bool?) -> Relation {
  match my {
    Some(true) => Mine
    Some(false) => Enemy
    None => Neutral
  }
}

///|
/// 将非空的 `my` 布尔值转换为统一的 `Relation`。
pub fn relation_of_my_bool(my : Bool) -> Relation {
  if my {
    Mine
  } else {
    Enemy
  }
}
