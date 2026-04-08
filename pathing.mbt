///|
pub enum ClosestMetric {
  Path
  Range
} derive(Show, Eq, Compare)

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
pub fn[A : GameObjectLike, B : GameObjectLike] range_between(
  a : A,
  b : B,
) -> Int {
  a.as_game_object().to_raw().get_range_to_raw(b.as_game_object().to_raw())
}

///|
pub fn[T : GameObjectLike] GameObject::find_closest(
  self : GameObject,
  candidates : Array[T],
  by? : ClosestMetric = Path,
) -> T? {
  find_closest(self, candidates, by~)
}

///|
pub fn[T : GameObjectLike] GameObject::find_in_range(
  self : GameObject,
  candidates : Array[T],
  range : Int,
) -> Array[T] {
  find_in_range(self, candidates, range)
}

///|
pub fn[T : GameObjectLike] GameObject::range_to(
  self : GameObject,
  target : T,
) -> Int {
  range_between(self, target)
}

///|
pub fn[T : GameObjectLike] Creep::find_closest(
  self : Creep,
  candidates : Array[T],
  by? : ClosestMetric = Path,
) -> T? {
  find_closest(self, candidates, by~)
}

///|
pub fn[T : GameObjectLike] Creep::find_in_range(
  self : Creep,
  candidates : Array[T],
  range : Int,
) -> Array[T] {
  find_in_range(self, candidates, range)
}

///|
pub fn[T : GameObjectLike] Creep::range_to(self : Creep, target : T) -> Int {
  range_between(self, target)
}

///|
pub fn[T : GameObjectLike] OwnedCreep::find_closest(
  self : OwnedCreep,
  candidates : Array[T],
  by? : ClosestMetric = Path,
) -> T? {
  find_closest(self, candidates, by~)
}

///|
pub fn[T : GameObjectLike] OwnedCreep::find_in_range(
  self : OwnedCreep,
  candidates : Array[T],
  range : Int,
) -> Array[T] {
  find_in_range(self, candidates, range)
}

///|
pub fn[T : GameObjectLike] OwnedCreep::range_to(
  self : OwnedCreep,
  target : T,
) -> Int {
  range_between(self, target)
}

///|
pub fn[T : GameObjectLike] EnemyCreep::find_closest(
  self : EnemyCreep,
  candidates : Array[T],
  by? : ClosestMetric = Path,
) -> T? {
  find_closest(self, candidates, by~)
}

///|
pub fn[T : GameObjectLike] EnemyCreep::find_in_range(
  self : EnemyCreep,
  candidates : Array[T],
  range : Int,
) -> Array[T] {
  find_in_range(self, candidates, range)
}

///|
pub fn[T : GameObjectLike] EnemyCreep::range_to(
  self : EnemyCreep,
  target : T,
) -> Int {
  range_between(self, target)
}

///|
pub fn[T : GameObjectLike] Source::find_closest(
  self : Source,
  candidates : Array[T],
  by? : ClosestMetric = Path,
) -> T? {
  find_closest(self, candidates, by~)
}

///|
pub fn[T : GameObjectLike] Source::find_in_range(
  self : Source,
  candidates : Array[T],
  range : Int,
) -> Array[T] {
  find_in_range(self, candidates, range)
}

///|
pub fn[T : GameObjectLike] Source::range_to(self : Source, target : T) -> Int {
  range_between(self, target)
}

///|
pub fn[T : GameObjectLike] StructureSpawn::find_closest(
  self : StructureSpawn,
  candidates : Array[T],
  by? : ClosestMetric = Path,
) -> T? {
  find_closest(self, candidates, by~)
}

///|
pub fn[T : GameObjectLike] StructureSpawn::find_in_range(
  self : StructureSpawn,
  candidates : Array[T],
  range : Int,
) -> Array[T] {
  find_in_range(self, candidates, range)
}

///|
pub fn[T : GameObjectLike] StructureSpawn::range_to(
  self : StructureSpawn,
  target : T,
) -> Int {
  range_between(self, target)
}

///|
pub fn[T : GameObjectLike] OwnedSpawn::find_closest(
  self : OwnedSpawn,
  candidates : Array[T],
  by? : ClosestMetric = Path,
) -> T? {
  find_closest(self, candidates, by~)
}

///|
pub fn[T : GameObjectLike] OwnedSpawn::find_in_range(
  self : OwnedSpawn,
  candidates : Array[T],
  range : Int,
) -> Array[T] {
  find_in_range(self, candidates, range)
}

///|
pub fn[T : GameObjectLike] OwnedSpawn::range_to(
  self : OwnedSpawn,
  target : T,
) -> Int {
  range_between(self, target)
}

///|
pub fn[T : GameObjectLike] EnemySpawn::find_closest(
  self : EnemySpawn,
  candidates : Array[T],
  by? : ClosestMetric = Path,
) -> T? {
  find_closest(self, candidates, by~)
}

///|
pub fn[T : GameObjectLike] EnemySpawn::find_in_range(
  self : EnemySpawn,
  candidates : Array[T],
  range : Int,
) -> Array[T] {
  find_in_range(self, candidates, range)
}

///|
pub fn[T : GameObjectLike] EnemySpawn::range_to(
  self : EnemySpawn,
  target : T,
) -> Int {
  range_between(self, target)
}

///|
pub fn[T : GameObjectLike] StructureTower::find_closest(
  self : StructureTower,
  candidates : Array[T],
  by? : ClosestMetric = Path,
) -> T? {
  find_closest(self, candidates, by~)
}

///|
pub fn[T : GameObjectLike] StructureTower::find_in_range(
  self : StructureTower,
  candidates : Array[T],
  range : Int,
) -> Array[T] {
  find_in_range(self, candidates, range)
}

///|
pub fn[T : GameObjectLike] StructureTower::range_to(
  self : StructureTower,
  target : T,
) -> Int {
  range_between(self, target)
}

///|
pub fn[T : GameObjectLike] OwnedTower::find_closest(
  self : OwnedTower,
  candidates : Array[T],
  by? : ClosestMetric = Path,
) -> T? {
  find_closest(self, candidates, by~)
}

///|
pub fn[T : GameObjectLike] OwnedTower::find_in_range(
  self : OwnedTower,
  candidates : Array[T],
  range : Int,
) -> Array[T] {
  find_in_range(self, candidates, range)
}

///|
pub fn[T : GameObjectLike] OwnedTower::range_to(
  self : OwnedTower,
  target : T,
) -> Int {
  range_between(self, target)
}

///|
pub fn[T : GameObjectLike] EnemyTower::find_closest(
  self : EnemyTower,
  candidates : Array[T],
  by? : ClosestMetric = Path,
) -> T? {
  find_closest(self, candidates, by~)
}

///|
pub fn[T : GameObjectLike] EnemyTower::find_in_range(
  self : EnemyTower,
  candidates : Array[T],
  range : Int,
) -> Array[T] {
  find_in_range(self, candidates, range)
}

///|
pub fn[T : GameObjectLike] EnemyTower::range_to(
  self : EnemyTower,
  target : T,
) -> Int {
  range_between(self, target)
}

///|
pub fn[T : GameObjectLike] StructureContainer::find_closest(
  self : StructureContainer,
  candidates : Array[T],
  by? : ClosestMetric = Path,
) -> T? {
  find_closest(self, candidates, by~)
}

///|
pub fn[T : GameObjectLike] StructureContainer::find_in_range(
  self : StructureContainer,
  candidates : Array[T],
  range : Int,
) -> Array[T] {
  find_in_range(self, candidates, range)
}

///|
pub fn[T : GameObjectLike] StructureContainer::range_to(
  self : StructureContainer,
  target : T,
) -> Int {
  range_between(self, target)
}

///|
pub fn[T : GameObjectLike] ConstructionSite::find_closest(
  self : ConstructionSite,
  candidates : Array[T],
  by? : ClosestMetric = Path,
) -> T? {
  find_closest(self, candidates, by~)
}

///|
pub fn[T : GameObjectLike] ConstructionSite::find_in_range(
  self : ConstructionSite,
  candidates : Array[T],
  range : Int,
) -> Array[T] {
  find_in_range(self, candidates, range)
}

///|
pub fn[T : GameObjectLike] ConstructionSite::range_to(
  self : ConstructionSite,
  target : T,
) -> Int {
  range_between(self, target)
}
