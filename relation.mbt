///|
/// 所有权关系在 model 层以枚举形式保存，避免重复的布尔字段。
pub enum Relation {
  Mine
  Enemy
  Neutral
} derive(Show, Eq, Compare)

///|
pub fn relation_of_owned_flag(my : Bool?) -> Relation {
  match my {
    Some(true) => Mine
    Some(false) => Enemy
    None => Neutral
  }
}

///|
pub fn relation_of_my_bool(my : Bool) -> Relation {
  if my {
    Mine
  } else {
    Enemy
  }
}
