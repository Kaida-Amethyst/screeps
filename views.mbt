///|
pub impl GameObjectLike for GameObject with as_game_object(self) -> GameObject {
  self
}

///|
pub impl GameObjectLike for GameObject with id(self) -> String {
  self.id()
}

///|
pub impl GameObjectLike for GameObject with x(self) -> Int {
  self.x()
}

///|
pub impl GameObjectLike for GameObject with y(self) -> Int {
  self.y()
}

///|
pub impl GameObjectLike for GameObject with exists(self) -> Bool {
  self.exists()
}

///|
pub impl GameObjectLike for Creep with as_game_object(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl GameObjectLike for Creep with id(self) -> String {
  self.id()
}

///|
pub impl GameObjectLike for Creep with x(self) -> Int {
  self.x()
}

///|
pub impl GameObjectLike for Creep with y(self) -> Int {
  self.y()
}

///|
pub impl GameObjectLike for Creep with exists(self) -> Bool {
  self.exists()
}

///|
pub impl GameObjectLike for OwnedCreep with as_game_object(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl GameObjectLike for OwnedCreep with id(self) -> String {
  self.id()
}

///|
pub impl GameObjectLike for OwnedCreep with x(self) -> Int {
  self.x()
}

///|
pub impl GameObjectLike for OwnedCreep with y(self) -> Int {
  self.y()
}

///|
pub impl GameObjectLike for OwnedCreep with exists(self) -> Bool {
  self.exists()
}

///|
pub impl GameObjectLike for EnemyCreep with as_game_object(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl GameObjectLike for EnemyCreep with id(self) -> String {
  self.id()
}

///|
pub impl GameObjectLike for EnemyCreep with x(self) -> Int {
  self.x()
}

///|
pub impl GameObjectLike for EnemyCreep with y(self) -> Int {
  self.y()
}

///|
pub impl GameObjectLike for EnemyCreep with exists(self) -> Bool {
  self.exists()
}

///|
pub impl GameObjectLike for Source with as_game_object(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl GameObjectLike for Source with id(self) -> String {
  self.id()
}

///|
pub impl GameObjectLike for Source with x(self) -> Int {
  self.x()
}

///|
pub impl GameObjectLike for Source with y(self) -> Int {
  self.y()
}

///|
pub impl GameObjectLike for Source with exists(self) -> Bool {
  self.exists()
}

///|
pub impl GameObjectLike for StructureSpawn with as_game_object(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl GameObjectLike for StructureSpawn with id(self) -> String {
  self.id()
}

///|
pub impl GameObjectLike for StructureSpawn with x(self) -> Int {
  self.x()
}

///|
pub impl GameObjectLike for StructureSpawn with y(self) -> Int {
  self.y()
}

///|
pub impl GameObjectLike for StructureSpawn with exists(self) -> Bool {
  self.exists()
}

///|
pub impl GameObjectLike for OwnedSpawn with as_game_object(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl GameObjectLike for OwnedSpawn with id(self) -> String {
  self.id()
}

///|
pub impl GameObjectLike for OwnedSpawn with x(self) -> Int {
  self.x()
}

///|
pub impl GameObjectLike for OwnedSpawn with y(self) -> Int {
  self.y()
}

///|
pub impl GameObjectLike for OwnedSpawn with exists(self) -> Bool {
  self.exists()
}

///|
pub impl GameObjectLike for EnemySpawn with as_game_object(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl GameObjectLike for EnemySpawn with id(self) -> String {
  self.id()
}

///|
pub impl GameObjectLike for EnemySpawn with x(self) -> Int {
  self.x()
}

///|
pub impl GameObjectLike for EnemySpawn with y(self) -> Int {
  self.y()
}

///|
pub impl GameObjectLike for EnemySpawn with exists(self) -> Bool {
  self.exists()
}

///|
pub impl GameObjectLike for StructureTower with as_game_object(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl GameObjectLike for StructureTower with id(self) -> String {
  self.id()
}

///|
pub impl GameObjectLike for StructureTower with x(self) -> Int {
  self.x()
}

///|
pub impl GameObjectLike for StructureTower with y(self) -> Int {
  self.y()
}

///|
pub impl GameObjectLike for StructureTower with exists(self) -> Bool {
  self.exists()
}

///|
pub impl GameObjectLike for OwnedTower with as_game_object(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl GameObjectLike for OwnedTower with id(self) -> String {
  self.id()
}

///|
pub impl GameObjectLike for OwnedTower with x(self) -> Int {
  self.x()
}

///|
pub impl GameObjectLike for OwnedTower with y(self) -> Int {
  self.y()
}

///|
pub impl GameObjectLike for OwnedTower with exists(self) -> Bool {
  self.exists()
}

///|
pub impl GameObjectLike for EnemyTower with as_game_object(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl GameObjectLike for EnemyTower with id(self) -> String {
  self.id()
}

///|
pub impl GameObjectLike for EnemyTower with x(self) -> Int {
  self.x()
}

///|
pub impl GameObjectLike for EnemyTower with y(self) -> Int {
  self.y()
}

///|
pub impl GameObjectLike for EnemyTower with exists(self) -> Bool {
  self.exists()
}

///|
pub impl GameObjectLike for StructureContainer with as_game_object(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl GameObjectLike for StructureContainer with id(self) -> String {
  self.id()
}

///|
pub impl GameObjectLike for StructureContainer with x(self) -> Int {
  self.x()
}

///|
pub impl GameObjectLike for StructureContainer with y(self) -> Int {
  self.y()
}

///|
pub impl GameObjectLike for StructureContainer with exists(self) -> Bool {
  self.exists()
}

///|
pub impl GameObjectLike for ConstructionSite with as_game_object(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl GameObjectLike for ConstructionSite with id(self) -> String {
  self.id()
}

///|
pub impl GameObjectLike for ConstructionSite with x(self) -> Int {
  self.x()
}

///|
pub impl GameObjectLike for ConstructionSite with y(self) -> Int {
  self.y()
}

///|
pub impl GameObjectLike for ConstructionSite with exists(self) -> Bool {
  self.exists()
}

///|
pub impl OwnedLike for Creep with relation(self) -> Relation {
  self.relation()
}

///|
pub impl OwnedLike for Creep with is_owned(self) -> Bool {
  self.is_owned()
}

///|
pub impl OwnedLike for Creep with is_enemy(self) -> Bool {
  self.is_enemy()
}

///|
pub impl OwnedLike for OwnedCreep with relation(self) -> Relation {
  self.relation()
}

///|
pub impl OwnedLike for OwnedCreep with is_owned(self) -> Bool {
  self.is_owned()
}

///|
pub impl OwnedLike for OwnedCreep with is_enemy(self) -> Bool {
  self.is_enemy()
}

///|
pub impl OwnedLike for EnemyCreep with relation(self) -> Relation {
  self.relation()
}

///|
pub impl OwnedLike for EnemyCreep with is_owned(self) -> Bool {
  self.is_owned()
}

///|
pub impl OwnedLike for EnemyCreep with is_enemy(self) -> Bool {
  self.is_enemy()
}

///|
pub impl OwnedLike for StructureSpawn with relation(self) -> Relation {
  self.relation()
}

///|
pub impl OwnedLike for StructureSpawn with is_owned(self) -> Bool {
  self.is_owned()
}

///|
pub impl OwnedLike for StructureSpawn with is_enemy(self) -> Bool {
  self.is_enemy()
}

///|
pub impl OwnedLike for OwnedSpawn with relation(self) -> Relation {
  self.relation()
}

///|
pub impl OwnedLike for OwnedSpawn with is_owned(self) -> Bool {
  self.is_owned()
}

///|
pub impl OwnedLike for OwnedSpawn with is_enemy(self) -> Bool {
  self.is_enemy()
}

///|
pub impl OwnedLike for EnemySpawn with relation(self) -> Relation {
  self.relation()
}

///|
pub impl OwnedLike for EnemySpawn with is_owned(self) -> Bool {
  self.is_owned()
}

///|
pub impl OwnedLike for EnemySpawn with is_enemy(self) -> Bool {
  self.is_enemy()
}

///|
pub impl OwnedLike for StructureTower with relation(self) -> Relation {
  self.relation()
}

///|
pub impl OwnedLike for StructureTower with is_owned(self) -> Bool {
  self.is_owned()
}

///|
pub impl OwnedLike for StructureTower with is_enemy(self) -> Bool {
  self.is_enemy()
}

///|
pub impl OwnedLike for OwnedTower with relation(self) -> Relation {
  self.relation()
}

///|
pub impl OwnedLike for OwnedTower with is_owned(self) -> Bool {
  self.is_owned()
}

///|
pub impl OwnedLike for OwnedTower with is_enemy(self) -> Bool {
  self.is_enemy()
}

///|
pub impl OwnedLike for EnemyTower with relation(self) -> Relation {
  self.relation()
}

///|
pub impl OwnedLike for EnemyTower with is_owned(self) -> Bool {
  self.is_owned()
}

///|
pub impl OwnedLike for EnemyTower with is_enemy(self) -> Bool {
  self.is_enemy()
}

///|
pub impl OwnedLike for StructureContainer with relation(self) -> Relation {
  self.relation()
}

///|
pub impl OwnedLike for StructureContainer with is_owned(self) -> Bool {
  self.is_owned()
}

///|
pub impl OwnedLike for StructureContainer with is_enemy(self) -> Bool {
  self.is_enemy()
}

///|
pub impl OwnedLike for ConstructionSite with relation(self) -> Relation {
  self.relation()
}

///|
pub impl OwnedLike for ConstructionSite with is_owned(self) -> Bool {
  self.is_owned()
}

///|
pub impl OwnedLike for ConstructionSite with is_enemy(self) -> Bool {
  self.is_enemy()
}

///|
pub impl HasStore for Creep with store(self) -> Store {
  self.store()
}

///|
pub impl HasStore for OwnedCreep with store(self) -> Store {
  self.store()
}

///|
pub impl HasStore for EnemyCreep with store(self) -> Store {
  self.store()
}

///|
pub impl HasStore for StructureSpawn with store(self) -> Store {
  self.store()
}

///|
pub impl HasStore for OwnedSpawn with store(self) -> Store {
  self.store()
}

///|
pub impl HasStore for EnemySpawn with store(self) -> Store {
  self.store()
}

///|
pub impl HasStore for StructureTower with store(self) -> Store {
  self.store()
}

///|
pub impl HasStore for OwnedTower with store(self) -> Store {
  self.store()
}

///|
pub impl HasStore for EnemyTower with store(self) -> Store {
  self.store()
}

///|
pub impl HasStore for StructureContainer with store(self) -> Store {
  self.store()
}

///|
pub impl HasHits for Creep with hits(self) -> Int {
  self.hits()
}

///|
pub impl HasHits for Creep with hits_max(self) -> Int {
  self.hits_max()
}

///|
pub impl HasHits for OwnedCreep with hits(self) -> Int {
  self.hits()
}

///|
pub impl HasHits for OwnedCreep with hits_max(self) -> Int {
  self.hits_max()
}

///|
pub impl HasHits for EnemyCreep with hits(self) -> Int {
  self.hits()
}

///|
pub impl HasHits for EnemyCreep with hits_max(self) -> Int {
  self.hits_max()
}

///|
pub impl HasHits for StructureSpawn with hits(self) -> Int {
  self.hits()
}

///|
pub impl HasHits for StructureSpawn with hits_max(self) -> Int {
  self.hits_max()
}

///|
pub impl HasHits for OwnedSpawn with hits(self) -> Int {
  self.hits()
}

///|
pub impl HasHits for OwnedSpawn with hits_max(self) -> Int {
  self.hits_max()
}

///|
pub impl HasHits for EnemySpawn with hits(self) -> Int {
  self.hits()
}

///|
pub impl HasHits for EnemySpawn with hits_max(self) -> Int {
  self.hits_max()
}

///|
pub impl HasHits for StructureTower with hits(self) -> Int {
  self.hits()
}

///|
pub impl HasHits for StructureTower with hits_max(self) -> Int {
  self.hits_max()
}

///|
pub impl HasHits for OwnedTower with hits(self) -> Int {
  self.hits()
}

///|
pub impl HasHits for OwnedTower with hits_max(self) -> Int {
  self.hits_max()
}

///|
pub impl HasHits for EnemyTower with hits(self) -> Int {
  self.hits()
}

///|
pub impl HasHits for EnemyTower with hits_max(self) -> Int {
  self.hits_max()
}

///|
pub impl HasHits for StructureContainer with hits(self) -> Int {
  self.hits()
}

///|
pub impl HasHits for StructureContainer with hits_max(self) -> Int {
  self.hits_max()
}

///|
pub impl MoveTarget for GameObject with as_move_target(self) -> GameObject {
  self
}

///|
pub impl MoveTarget for Creep with as_move_target(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl MoveTarget for OwnedCreep with as_move_target(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl MoveTarget for EnemyCreep with as_move_target(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl MoveTarget for Source with as_move_target(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl MoveTarget for StructureSpawn with as_move_target(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl MoveTarget for OwnedSpawn with as_move_target(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl MoveTarget for EnemySpawn with as_move_target(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl MoveTarget for StructureTower with as_move_target(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl MoveTarget for OwnedTower with as_move_target(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl MoveTarget for EnemyTower with as_move_target(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl MoveTarget for StructureContainer with as_move_target(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl MoveTarget for ConstructionSite with as_move_target(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl AttackTarget for Creep with as_attack_target(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl AttackTarget for OwnedCreep with as_attack_target(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl AttackTarget for EnemyCreep with as_attack_target(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl AttackTarget for StructureSpawn with as_attack_target(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl AttackTarget for OwnedSpawn with as_attack_target(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl AttackTarget for EnemySpawn with as_attack_target(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl AttackTarget for StructureTower with as_attack_target(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl AttackTarget for OwnedTower with as_attack_target(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl AttackTarget for EnemyTower with as_attack_target(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl AttackTarget for StructureContainer with as_attack_target(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl RangedAttackTarget for Creep with as_ranged_attack_target(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl RangedAttackTarget for OwnedCreep with as_ranged_attack_target(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl RangedAttackTarget for EnemyCreep with as_ranged_attack_target(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl RangedAttackTarget for StructureSpawn with as_ranged_attack_target(
  self,
) -> GameObject {
  self.as_game_object()
}

///|
pub impl RangedAttackTarget for OwnedSpawn with as_ranged_attack_target(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl RangedAttackTarget for EnemySpawn with as_ranged_attack_target(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl RangedAttackTarget for StructureTower with as_ranged_attack_target(
  self,
) -> GameObject {
  self.as_game_object()
}

///|
pub impl RangedAttackTarget for OwnedTower with as_ranged_attack_target(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl RangedAttackTarget for EnemyTower with as_ranged_attack_target(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl RangedAttackTarget for StructureContainer with as_ranged_attack_target(
  self,
) -> GameObject {
  self.as_game_object()
}

///|
pub impl HealTarget for Creep with as_heal_target(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl HealTarget for OwnedCreep with as_heal_target(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl HealTarget for EnemyCreep with as_heal_target(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl TowerAttackTarget for Creep with as_tower_attack_target(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl TowerAttackTarget for OwnedCreep with as_tower_attack_target(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl TowerAttackTarget for EnemyCreep with as_tower_attack_target(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl TowerAttackTarget for StructureSpawn with as_tower_attack_target(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl TowerAttackTarget for OwnedSpawn with as_tower_attack_target(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl TowerAttackTarget for EnemySpawn with as_tower_attack_target(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl TowerAttackTarget for StructureTower with as_tower_attack_target(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl TowerAttackTarget for OwnedTower with as_tower_attack_target(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl TowerAttackTarget for EnemyTower with as_tower_attack_target(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl TowerAttackTarget for StructureContainer with as_tower_attack_target(
  self,
) -> GameObject {
  self.as_game_object()
}

///|
pub impl HarvestTarget for Source with as_harvest_target(self) -> Source {
  self
}

///|
pub impl TransferTarget for Creep with as_transfer_target(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl TransferTarget for OwnedCreep with as_transfer_target(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl TransferTarget for EnemyCreep with as_transfer_target(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl TransferTarget for StructureSpawn with as_transfer_target(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl TransferTarget for OwnedSpawn with as_transfer_target(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl TransferTarget for EnemySpawn with as_transfer_target(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl TransferTarget for StructureTower with as_transfer_target(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl TransferTarget for OwnedTower with as_transfer_target(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl TransferTarget for EnemyTower with as_transfer_target(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl TransferTarget for StructureContainer with as_transfer_target(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl WithdrawTarget for StructureSpawn with as_withdraw_target(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl WithdrawTarget for OwnedSpawn with as_withdraw_target(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl WithdrawTarget for EnemySpawn with as_withdraw_target(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl WithdrawTarget for StructureTower with as_withdraw_target(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl WithdrawTarget for OwnedTower with as_withdraw_target(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl WithdrawTarget for EnemyTower with as_withdraw_target(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl WithdrawTarget for StructureContainer with as_withdraw_target(self) -> GameObject {
  self.as_game_object()
}

///|
pub impl BuildTarget for ConstructionSite with as_build_target(self) -> ConstructionSite {
  self
}
