///|
/// 正式 API 中使用枚举表达 body part，而不是直接暴露原始字符串。
pub enum BodyPartKind {
  Move
  Work
  Carry
  Attack
  RangedAttack
  Heal
  Tough
} derive(Show, Eq, Compare)

///|
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
pub fn body_part_kind_of(raw : String) -> BodyPartKind? {
  match raw {
    "move" => Some(Move)
    "work" => Some(Work)
    "carry" => Some(Carry)
    "attack" => Some(Attack)
    "ranged_attack" => Some(RangedAttack)
    "heal" => Some(Heal)
    "tough" => Some(Tough)
    _ => None
  }
}

///|
/// 第一阶段资源类型先只覆盖 Energy，但正式 API 仍采用枚举结构。
pub enum ResourceKind {
  Energy
} derive(Show, Eq, Compare)

///|
pub fn ResourceKind::to_raw(self : ResourceKind) -> String {
  match self {
    Energy => @raw.RESOURCE_ENERGY
  }
}

///|
pub fn resource_kind_of(raw : String) -> ResourceKind? {
  match raw {
    "energy" => Some(Energy)
    _ => None
  }
}

///|
/// 结构原型名称用于创建 construction site。
pub enum StructureKind {
  Spawn
  Extension
  Road
  Rampart
  Wall
  Tower
  Container
} derive(Show, Eq, Compare)

///|
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
