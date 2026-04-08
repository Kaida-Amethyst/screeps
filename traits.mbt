///|
/// 所有可作为游戏对象观察视图的类型都应满足这一层最小能力。
pub(open) trait GameObjectLike {
  as_game_object(Self) -> GameObject
  id(Self) -> String
  x(Self) -> Int
  y(Self) -> Int
  exists(Self) -> Bool
}

///|
/// 带有所有权关系语义的对象应实现这一 trait。
pub(open) trait OwnedLike {
  relation(Self) -> Relation
  is_owned(Self) -> Bool
  is_enemy(Self) -> Bool
}

///|
/// 带有 Store 的对象应实现这一 trait。
pub(open) trait HasStore {
  store(Self) -> Store
}

///|
/// 带有 hits / hits_max 语义的对象应实现这一 trait。
pub(open) trait HasHits {
  hits(Self) -> Int
  hits_max(Self) -> Int
}

///|
/// Move 的目标对象。
pub(open) trait MoveTarget: GameObjectLike {
  as_move_target(Self) -> GameObject
}

///|
/// 近战攻击目标。
pub(open) trait AttackTarget: GameObjectLike {
  as_attack_target(Self) -> GameObject
}

///|
/// 远程攻击目标。
pub(open) trait RangedAttackTarget: GameObjectLike {
  as_ranged_attack_target(Self) -> GameObject
}

///|
/// 治疗目标。
pub(open) trait HealTarget: GameObjectLike {
  as_heal_target(Self) -> GameObject
}

///|
/// Tower 的攻击目标。
pub(open) trait TowerAttackTarget: GameObjectLike {
  as_tower_attack_target(Self) -> GameObject
}

///|
/// 采集目标。
pub(open) trait HarvestTarget {
  as_harvest_target(Self) -> Source
}

///|
/// 转移资源目标。
pub(open) trait TransferTarget: GameObjectLike {
  as_transfer_target(Self) -> GameObject
}

///|
/// 提取资源目标。
pub(open) trait WithdrawTarget: GameObjectLike {
  as_withdraw_target(Self) -> GameObject
}

///|
/// 建造目标。
pub(open) trait BuildTarget {
  as_build_target(Self) -> ConstructionSite
}
