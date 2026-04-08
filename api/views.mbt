///|
pub impl GameObjectLike for @model.GameObject with as_game_object(self) -> @model.GameObject {
  self
}

///|
pub impl GameObjectLike for @model.GameObject with id(self) -> String {
  self.id()
}

///|
pub impl GameObjectLike for @model.GameObject with x(self) -> Int {
  self.x()
}

///|
pub impl GameObjectLike for @model.GameObject with y(self) -> Int {
  self.y()
}

///|
pub impl GameObjectLike for @model.GameObject with exists(self) -> Bool {
  self.exists()
}

///|
pub impl GameObjectLike for @model.Creep with as_game_object(self) -> @model.GameObject {
  self.as_game_object()
}

///|
pub impl GameObjectLike for @model.Creep with id(self) -> String {
  self.id()
}

///|
pub impl GameObjectLike for @model.Creep with x(self) -> Int {
  self.x()
}

///|
pub impl GameObjectLike for @model.Creep with y(self) -> Int {
  self.y()
}

///|
pub impl GameObjectLike for @model.Creep with exists(self) -> Bool {
  self.exists()
}

///|
pub impl GameObjectLike for @model.OwnedCreep with as_game_object(self) -> @model.GameObject {
  self.as_game_object()
}

///|
pub impl GameObjectLike for @model.OwnedCreep with id(self) -> String {
  self.id()
}

///|
pub impl GameObjectLike for @model.OwnedCreep with x(self) -> Int {
  self.x()
}

///|
pub impl GameObjectLike for @model.OwnedCreep with y(self) -> Int {
  self.y()
}

///|
pub impl GameObjectLike for @model.OwnedCreep with exists(self) -> Bool {
  self.exists()
}

///|
pub impl GameObjectLike for @model.EnemyCreep with as_game_object(self) -> @model.GameObject {
  self.as_game_object()
}

///|
pub impl GameObjectLike for @model.EnemyCreep with id(self) -> String {
  self.id()
}

///|
pub impl GameObjectLike for @model.EnemyCreep with x(self) -> Int {
  self.x()
}

///|
pub impl GameObjectLike for @model.EnemyCreep with y(self) -> Int {
  self.y()
}

///|
pub impl GameObjectLike for @model.EnemyCreep with exists(self) -> Bool {
  self.exists()
}

///|
pub impl GameObjectLike for @model.Source with as_game_object(self) -> @model.GameObject {
  self.as_game_object()
}

///|
pub impl GameObjectLike for @model.Source with id(self) -> String {
  self.id()
}

///|
pub impl GameObjectLike for @model.Source with x(self) -> Int {
  self.x()
}

///|
pub impl GameObjectLike for @model.Source with y(self) -> Int {
  self.y()
}

///|
pub impl GameObjectLike for @model.Source with exists(self) -> Bool {
  self.exists()
}

///|
pub impl GameObjectLike for @model.StructureSpawn with as_game_object(self) -> @model.GameObject {
  self.as_game_object()
}

///|
pub impl GameObjectLike for @model.StructureSpawn with id(self) -> String {
  self.id()
}

///|
pub impl GameObjectLike for @model.StructureSpawn with x(self) -> Int {
  self.x()
}

///|
pub impl GameObjectLike for @model.StructureSpawn with y(self) -> Int {
  self.y()
}

///|
pub impl GameObjectLike for @model.StructureSpawn with exists(self) -> Bool {
  self.exists()
}

///|
pub impl GameObjectLike for @model.OwnedSpawn with as_game_object(self) -> @model.GameObject {
  self.as_game_object()
}

///|
pub impl GameObjectLike for @model.OwnedSpawn with id(self) -> String {
  self.id()
}

///|
pub impl GameObjectLike for @model.OwnedSpawn with x(self) -> Int {
  self.x()
}

///|
pub impl GameObjectLike for @model.OwnedSpawn with y(self) -> Int {
  self.y()
}

///|
pub impl GameObjectLike for @model.OwnedSpawn with exists(self) -> Bool {
  self.exists()
}

///|
pub impl GameObjectLike for @model.EnemySpawn with as_game_object(self) -> @model.GameObject {
  self.as_game_object()
}

///|
pub impl GameObjectLike for @model.EnemySpawn with id(self) -> String {
  self.id()
}

///|
pub impl GameObjectLike for @model.EnemySpawn with x(self) -> Int {
  self.x()
}

///|
pub impl GameObjectLike for @model.EnemySpawn with y(self) -> Int {
  self.y()
}

///|
pub impl GameObjectLike for @model.EnemySpawn with exists(self) -> Bool {
  self.exists()
}

///|
pub impl OwnedLike for @model.Creep with relation(self) -> @model.Relation {
  self.relation()
}

///|
pub impl OwnedLike for @model.Creep with is_owned(self) -> Bool {
  self.is_owned()
}

///|
pub impl OwnedLike for @model.Creep with is_enemy(self) -> Bool {
  self.is_enemy()
}

///|
pub impl OwnedLike for @model.OwnedCreep with relation(self) -> @model.Relation {
  self.relation()
}

///|
pub impl OwnedLike for @model.OwnedCreep with is_owned(self) -> Bool {
  self.is_owned()
}

///|
pub impl OwnedLike for @model.OwnedCreep with is_enemy(self) -> Bool {
  self.is_enemy()
}

///|
pub impl OwnedLike for @model.EnemyCreep with relation(self) -> @model.Relation {
  self.relation()
}

///|
pub impl OwnedLike for @model.EnemyCreep with is_owned(self) -> Bool {
  self.is_owned()
}

///|
pub impl OwnedLike for @model.EnemyCreep with is_enemy(self) -> Bool {
  self.is_enemy()
}

///|
pub impl OwnedLike for @model.StructureSpawn with relation(self) -> @model.Relation {
  self.relation()
}

///|
pub impl OwnedLike for @model.StructureSpawn with is_owned(self) -> Bool {
  self.is_owned()
}

///|
pub impl OwnedLike for @model.StructureSpawn with is_enemy(self) -> Bool {
  self.is_enemy()
}

///|
pub impl OwnedLike for @model.OwnedSpawn with relation(self) -> @model.Relation {
  self.relation()
}

///|
pub impl OwnedLike for @model.OwnedSpawn with is_owned(self) -> Bool {
  self.is_owned()
}

///|
pub impl OwnedLike for @model.OwnedSpawn with is_enemy(self) -> Bool {
  self.is_enemy()
}

///|
pub impl OwnedLike for @model.EnemySpawn with relation(self) -> @model.Relation {
  self.relation()
}

///|
pub impl OwnedLike for @model.EnemySpawn with is_owned(self) -> Bool {
  self.is_owned()
}

///|
pub impl OwnedLike for @model.EnemySpawn with is_enemy(self) -> Bool {
  self.is_enemy()
}

///|
pub impl HasStore for @model.Creep with store(self) -> @model.Store {
  self.store()
}

///|
pub impl HasStore for @model.OwnedCreep with store(self) -> @model.Store {
  self.store()
}

///|
pub impl HasStore for @model.EnemyCreep with store(self) -> @model.Store {
  self.store()
}

///|
pub impl HasStore for @model.StructureSpawn with store(self) -> @model.Store {
  self.store()
}

///|
pub impl HasStore for @model.OwnedSpawn with store(self) -> @model.Store {
  self.store()
}

///|
pub impl HasStore for @model.EnemySpawn with store(self) -> @model.Store {
  self.store()
}

///|
pub impl HasHits for @model.Creep with hits(self) -> Int {
  self.hits()
}

///|
pub impl HasHits for @model.Creep with hits_max(self) -> Int {
  self.hits_max()
}

///|
pub impl HasHits for @model.OwnedCreep with hits(self) -> Int {
  self.hits()
}

///|
pub impl HasHits for @model.OwnedCreep with hits_max(self) -> Int {
  self.hits_max()
}

///|
pub impl HasHits for @model.EnemyCreep with hits(self) -> Int {
  self.hits()
}

///|
pub impl HasHits for @model.EnemyCreep with hits_max(self) -> Int {
  self.hits_max()
}

///|
pub impl HasHits for @model.StructureSpawn with hits(self) -> Int {
  self.hits()
}

///|
pub impl HasHits for @model.StructureSpawn with hits_max(self) -> Int {
  self.hits_max()
}

///|
pub impl HasHits for @model.OwnedSpawn with hits(self) -> Int {
  self.hits()
}

///|
pub impl HasHits for @model.OwnedSpawn with hits_max(self) -> Int {
  self.hits_max()
}

///|
pub impl HasHits for @model.EnemySpawn with hits(self) -> Int {
  self.hits()
}

///|
pub impl HasHits for @model.EnemySpawn with hits_max(self) -> Int {
  self.hits_max()
}
