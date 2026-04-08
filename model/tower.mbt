///|
/// StructureTower 的通用观察视图。
pub struct StructureTower {
  raw : @raw.JsStructureTower
  relation : Relation
}

///|
/// 己方 tower 的强约束视图。
pub struct OwnedTower {
  raw : @raw.JsStructureTower
}

///|
/// 敌方 tower 的强约束视图。
pub struct EnemyTower {
  raw : @raw.JsStructureTower
}
