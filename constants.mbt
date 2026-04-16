///|
/// 正式 API 中使用枚举表达 body part，而不是直接暴露原始字符串。
pub(all) enum BodyPartKind {
  Move
  Work
  Carry
  Attack
  RangedAttack
  Heal
  Tough
} derive(Show, Eq, Compare)

///|
/// 转换为 raw 层使用的原始 body part 字符串。
pub fn BodyPartKind::to_raw(self : BodyPartKind) -> String {
  match self {
    Move => @raw.BODY_PART_MOVE
    Work => @raw.BODY_PART_WORK
    Carry => @raw.BODY_PART_CARRY
    Attack => @raw.BODY_PART_ATTACK
    RangedAttack => @raw.BODY_PART_RANGED_ATTACK
    Heal => @raw.BODY_PART_HEAL
    Tough => @raw.BODY_PART_TOUGH
  }
}

///|
fn body_part_kind_from_raw(raw_kind : String) -> BodyPartKind {
  match raw_kind {
    @raw.BODY_PART_MOVE => Move
    @raw.BODY_PART_WORK => Work
    @raw.BODY_PART_CARRY => Carry
    @raw.BODY_PART_ATTACK => Attack
    @raw.BODY_PART_RANGED_ATTACK => RangedAttack
    @raw.BODY_PART_HEAL => Heal
    @raw.BODY_PART_TOUGH => Tough
    _ => panic()
  }
}

///|
/// 第一阶段资源类型先只覆盖 Energy，但正式 API 仍采用枚举结构。
pub(all) enum ResourceKind {
  Energy
} derive(Show, Eq, Compare)

///|
/// 转换为 raw 层使用的原始资源字符串。
pub fn ResourceKind::to_raw(self : ResourceKind) -> String {
  match self {
    Energy => @raw.RESOURCE_ENERGY
  }
}

///|
/// 结构原型名称用于创建 construction site。
pub(all) enum StructureKind {
  Spawn
  Extension
  Road
  Rampart
  Wall
  Tower
  Container
} derive(Show, Eq, Compare)

///|
/// 转换为 raw 层使用的原始结构 prototype 名称。
pub fn StructureKind::to_prototype_name(self : StructureKind) -> String {
  match self {
    Spawn => "StructureSpawn"
    Extension => "StructureExtension"
    Road => "StructureRoad"
    Rampart => "StructureRampart"
    Wall => "StructureWall"
    Tower => "StructureTower"
    Container => "StructureContainer"
  }
}

///|
/// 返回当前已知的结构原型种类列表。
pub fn structure_kinds() -> Array[StructureKind] {
  [Spawn, Extension, Road, Rampart, Wall, Tower, Container]
}
