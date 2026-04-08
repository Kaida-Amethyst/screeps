///|
using @model {type GameObject, type Relation, type Store}

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
pub(open) trait MoveTarget: GameObjectLike {}

///|
/// 近战攻击目标。
pub(open) trait AttackTarget: GameObjectLike {}

///|
/// 远程攻击目标。
pub(open) trait RangedAttackTarget: GameObjectLike {}

///|
/// 治疗目标。
pub(open) trait HealTarget: GameObjectLike {}

///|
/// 采集目标。
pub(open) trait HarvestTarget: GameObjectLike {}

///|
/// 转移资源目标。
pub(open) trait TransferTarget: GameObjectLike {}

///|
/// 提取资源目标。
pub(open) trait WithdrawTarget: GameObjectLike {}

///|
/// 建造目标。
pub(open) trait BuildTarget: GameObjectLike {}
