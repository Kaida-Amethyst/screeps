///|
/// 指定“最近”查询使用路径距离还是线性距离。
pub(all) enum ClosestMetric {
  Path
  Range
} derive(Show, Eq, Compare)

///|
/// 返回当前支持的最近距离度量方式。
pub fn closest_metrics() -> Array[ClosestMetric] {
  [Path, Range]
}

///|
fn[T : GameObjectLike] raw_candidates(
  candidates : Array[T],
) -> Array[@raw.JsGameObject] {
  candidates.map(candidate => candidate.as_game_object().to_raw())
}

///|
fn[T] find_candidate_by_raw(
  candidates : Array[T],
  raw_target : @raw.JsGameObject?,
  id_of : (T) -> String,
) -> T? {
  match raw_target {
    Some(raw_target) => {
      let target_id = GameObject::create(raw_target).id()
      for candidate in candidates {
        if id_of(candidate) == target_id {
          return Some(candidate)
        }
      }
      None
    }
    None => None
  }
}

///|
/// 在候选列表中按指定度量寻找距离起点最近的目标。
pub fn[From : GameObjectLike, T : GameObjectLike] find_closest(
  from : From,
  candidates : Array[T],
  by? : ClosestMetric = Path,
) -> T? {
  guard !candidates.is_empty() else { return None }
  let from_raw = from.as_game_object().to_raw()
  let candidate_raw = raw_candidates(candidates)
  let raw_target = match by {
    Path => from_raw.find_closest_by_path_raw(candidate_raw).to_option()
    Range => from_raw.find_closest_by_range_raw(candidate_raw).to_option()
  }
  find_candidate_by_raw(candidates, raw_target, candidate => candidate.id())
}

///|
/// 返回候选列表中位于指定范围内的全部目标。
pub fn[From : GameObjectLike, T : GameObjectLike] find_in_range(
  from : From,
  candidates : Array[T],
  range : Int,
) -> Array[T] {
  let result_ids = from
    .as_game_object()
    .to_raw()
    .find_in_range_raw(raw_candidates(candidates), range)
    .map(raw_target => GameObject::create(raw_target).id())
  candidates.filter(candidate => result_ids.contains(candidate.id()))
}

///|
/// 返回两个对象之间的线性距离。
pub fn[A : GameObjectLike, B : GameObjectLike] range_between(
  a : A,
  b : B,
) -> Int {
  a.as_game_object().to_raw().get_range_to_raw(b.as_game_object().to_raw())
}

///|
/// 从当前对象出发，按指定度量寻找最近目标。
pub fn[T : GameObjectLike] GameObject::find_closest(
  self : GameObject,
  candidates : Array[T],
  by? : ClosestMetric = Path,
) -> T? {
  find_closest(self, candidates, by~)
}

///|
/// 返回当前对象周围指定范围内的全部目标。
pub fn[T : GameObjectLike] GameObject::find_in_range(
  self : GameObject,
  candidates : Array[T],
  range : Int,
) -> Array[T] {
  find_in_range(self, candidates, range)
}

///|
/// 返回当前对象与目标之间的线性距离。
pub fn[T : GameObjectLike] GameObject::range_to(
  self : GameObject,
  target : T,
) -> Int {
  range_between(self, target)
}

///|
/// 从当前 creep 出发，按指定度量寻找最近目标。
pub fn[T : GameObjectLike] Creep::find_closest(
  self : Creep,
  candidates : Array[T],
  by? : ClosestMetric = Path,
) -> T? {
  find_closest(self, candidates, by~)
}

///|
/// 返回当前 creep 周围指定范围内的全部目标。
pub fn[T : GameObjectLike] Creep::find_in_range(
  self : Creep,
  candidates : Array[T],
  range : Int,
) -> Array[T] {
  find_in_range(self, candidates, range)
}

///|
/// 返回当前 creep 与目标之间的线性距离。
pub fn[T : GameObjectLike] Creep::range_to(self : Creep, target : T) -> Int {
  range_between(self, target)
}

///|
/// 从当前己方 creep 出发，按指定度量寻找最近目标。
pub fn[T : GameObjectLike] MyCreep::find_closest(
  self : MyCreep,
  candidates : Array[T],
  by? : ClosestMetric = Path,
) -> T? {
  find_closest(self, candidates, by~)
}

///|
/// 返回当前己方 creep 周围指定范围内的全部目标。
pub fn[T : GameObjectLike] MyCreep::find_in_range(
  self : MyCreep,
  candidates : Array[T],
  range : Int,
) -> Array[T] {
  find_in_range(self, candidates, range)
}

///|
/// 返回当前己方 creep 与目标之间的线性距离。
pub fn[T : GameObjectLike] MyCreep::range_to(self : MyCreep, target : T) -> Int {
  range_between(self, target)
}

///|
/// 从当前敌方 creep 出发，按指定度量寻找最近目标。
pub fn[T : GameObjectLike] EnemyCreep::find_closest(
  self : EnemyCreep,
  candidates : Array[T],
  by? : ClosestMetric = Path,
) -> T? {
  find_closest(self, candidates, by~)
}

///|
/// 返回当前敌方 creep 周围指定范围内的全部目标。
pub fn[T : GameObjectLike] EnemyCreep::find_in_range(
  self : EnemyCreep,
  candidates : Array[T],
  range : Int,
) -> Array[T] {
  find_in_range(self, candidates, range)
}

///|
/// 返回当前敌方 creep 与目标之间的线性距离。
pub fn[T : GameObjectLike] EnemyCreep::range_to(
  self : EnemyCreep,
  target : T,
) -> Int {
  range_between(self, target)
}

///|
/// 从当前 source 出发，按指定度量寻找最近目标。
pub fn[T : GameObjectLike] Source::find_closest(
  self : Source,
  candidates : Array[T],
  by? : ClosestMetric = Path,
) -> T? {
  find_closest(self, candidates, by~)
}

///|
/// 返回当前 source 周围指定范围内的全部目标。
pub fn[T : GameObjectLike] Source::find_in_range(
  self : Source,
  candidates : Array[T],
  range : Int,
) -> Array[T] {
  find_in_range(self, candidates, range)
}

///|
/// 返回当前 source 与目标之间的线性距离。
pub fn[T : GameObjectLike] Source::range_to(self : Source, target : T) -> Int {
  range_between(self, target)
}

///|
/// 从当前 flag 出发，按指定度量寻找最近目标。
pub fn[T : GameObjectLike] Flag::find_closest(
  self : Flag,
  candidates : Array[T],
  by? : ClosestMetric = Path,
) -> T? {
  find_closest(self, candidates, by~)
}

///|
/// 返回当前 flag 周围指定范围内的全部目标。
pub fn[T : GameObjectLike] Flag::find_in_range(
  self : Flag,
  candidates : Array[T],
  range : Int,
) -> Array[T] {
  find_in_range(self, candidates, range)
}

///|
/// 返回当前 flag 与目标之间的线性距离。
pub fn[T : GameObjectLike] Flag::range_to(self : Flag, target : T) -> Int {
  range_between(self, target)
}

///|
/// 从当前结构出发，按指定度量寻找最近目标。
pub fn[T : GameObjectLike] Structure::find_closest(
  self : Structure,
  candidates : Array[T],
  by? : ClosestMetric = Path,
) -> T? {
  find_closest(self, candidates, by~)
}

///|
/// 返回当前结构周围指定范围内的全部目标。
pub fn[T : GameObjectLike] Structure::find_in_range(
  self : Structure,
  candidates : Array[T],
  range : Int,
) -> Array[T] {
  find_in_range(self, candidates, range)
}

///|
/// 返回当前结构与目标之间的线性距离。
pub fn[T : GameObjectLike] Structure::range_to(
  self : Structure,
  target : T,
) -> Int {
  range_between(self, target)
}

///|
/// 从当前 spawn 出发，按指定度量寻找最近目标。
pub fn[T : GameObjectLike] StructureSpawn::find_closest(
  self : StructureSpawn,
  candidates : Array[T],
  by? : ClosestMetric = Path,
) -> T? {
  find_closest(self, candidates, by~)
}

///|
/// 返回当前 spawn 周围指定范围内的全部目标。
pub fn[T : GameObjectLike] StructureSpawn::find_in_range(
  self : StructureSpawn,
  candidates : Array[T],
  range : Int,
) -> Array[T] {
  find_in_range(self, candidates, range)
}

///|
/// 返回当前 spawn 与目标之间的线性距离。
pub fn[T : GameObjectLike] StructureSpawn::range_to(
  self : StructureSpawn,
  target : T,
) -> Int {
  range_between(self, target)
}

///|
/// 从当前己方 spawn 出发，按指定度量寻找最近目标。
pub fn[T : GameObjectLike] MySpawn::find_closest(
  self : MySpawn,
  candidates : Array[T],
  by? : ClosestMetric = Path,
) -> T? {
  find_closest(self, candidates, by~)
}

///|
/// 返回当前己方 spawn 周围指定范围内的全部目标。
pub fn[T : GameObjectLike] MySpawn::find_in_range(
  self : MySpawn,
  candidates : Array[T],
  range : Int,
) -> Array[T] {
  find_in_range(self, candidates, range)
}

///|
/// 返回当前己方 spawn 与目标之间的线性距离。
pub fn[T : GameObjectLike] MySpawn::range_to(self : MySpawn, target : T) -> Int {
  range_between(self, target)
}

///|
/// 从当前敌方 spawn 出发，按指定度量寻找最近目标。
pub fn[T : GameObjectLike] EnemySpawn::find_closest(
  self : EnemySpawn,
  candidates : Array[T],
  by? : ClosestMetric = Path,
) -> T? {
  find_closest(self, candidates, by~)
}

///|
/// 返回当前敌方 spawn 周围指定范围内的全部目标。
pub fn[T : GameObjectLike] EnemySpawn::find_in_range(
  self : EnemySpawn,
  candidates : Array[T],
  range : Int,
) -> Array[T] {
  find_in_range(self, candidates, range)
}

///|
/// 返回当前敌方 spawn 与目标之间的线性距离。
pub fn[T : GameObjectLike] EnemySpawn::range_to(
  self : EnemySpawn,
  target : T,
) -> Int {
  range_between(self, target)
}

///|
/// 从当前 tower 出发，按指定度量寻找最近目标。
pub fn[T : GameObjectLike] StructureTower::find_closest(
  self : StructureTower,
  candidates : Array[T],
  by? : ClosestMetric = Path,
) -> T? {
  find_closest(self, candidates, by~)
}

///|
/// 返回当前 tower 周围指定范围内的全部目标。
pub fn[T : GameObjectLike] StructureTower::find_in_range(
  self : StructureTower,
  candidates : Array[T],
  range : Int,
) -> Array[T] {
  find_in_range(self, candidates, range)
}

///|
/// 返回当前 tower 与目标之间的线性距离。
pub fn[T : GameObjectLike] StructureTower::range_to(
  self : StructureTower,
  target : T,
) -> Int {
  range_between(self, target)
}

///|
/// 从当前己方 tower 出发，按指定度量寻找最近目标。
pub fn[T : GameObjectLike] MyTower::find_closest(
  self : MyTower,
  candidates : Array[T],
  by? : ClosestMetric = Path,
) -> T? {
  find_closest(self, candidates, by~)
}

///|
/// 返回当前己方 tower 周围指定范围内的全部目标。
pub fn[T : GameObjectLike] MyTower::find_in_range(
  self : MyTower,
  candidates : Array[T],
  range : Int,
) -> Array[T] {
  find_in_range(self, candidates, range)
}

///|
/// 返回当前己方 tower 与目标之间的线性距离。
pub fn[T : GameObjectLike] MyTower::range_to(self : MyTower, target : T) -> Int {
  range_between(self, target)
}

///|
/// 从当前敌方 tower 出发，按指定度量寻找最近目标。
pub fn[T : GameObjectLike] EnemyTower::find_closest(
  self : EnemyTower,
  candidates : Array[T],
  by? : ClosestMetric = Path,
) -> T? {
  find_closest(self, candidates, by~)
}

///|
/// 返回当前敌方 tower 周围指定范围内的全部目标。
pub fn[T : GameObjectLike] EnemyTower::find_in_range(
  self : EnemyTower,
  candidates : Array[T],
  range : Int,
) -> Array[T] {
  find_in_range(self, candidates, range)
}

///|
/// 返回当前敌方 tower 与目标之间的线性距离。
pub fn[T : GameObjectLike] EnemyTower::range_to(
  self : EnemyTower,
  target : T,
) -> Int {
  range_between(self, target)
}

///|
/// 从当前 container 出发，按指定度量寻找最近目标。
pub fn[T : GameObjectLike] StructureContainer::find_closest(
  self : StructureContainer,
  candidates : Array[T],
  by? : ClosestMetric = Path,
) -> T? {
  find_closest(self, candidates, by~)
}

///|
/// 返回当前 container 周围指定范围内的全部目标。
pub fn[T : GameObjectLike] StructureContainer::find_in_range(
  self : StructureContainer,
  candidates : Array[T],
  range : Int,
) -> Array[T] {
  find_in_range(self, candidates, range)
}

///|
/// 返回当前 container 与目标之间的线性距离。
pub fn[T : GameObjectLike] StructureContainer::range_to(
  self : StructureContainer,
  target : T,
) -> Int {
  range_between(self, target)
}

///|
/// 从当前工地出发，按指定度量寻找最近目标。
pub fn[T : GameObjectLike] ConstructionSite::find_closest(
  self : ConstructionSite,
  candidates : Array[T],
  by? : ClosestMetric = Path,
) -> T? {
  find_closest(self, candidates, by~)
}

///|
/// 返回当前工地周围指定范围内的全部目标。
pub fn[T : GameObjectLike] ConstructionSite::find_in_range(
  self : ConstructionSite,
  candidates : Array[T],
  range : Int,
) -> Array[T] {
  find_in_range(self, candidates, range)
}

///|
/// 返回当前工地与目标之间的线性距离。
pub fn[T : GameObjectLike] ConstructionSite::range_to(
  self : ConstructionSite,
  target : T,
) -> Int {
  range_between(self, target)
}
