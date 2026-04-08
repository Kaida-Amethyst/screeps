///|
pub extern "js" fn JsCreep::my(self : JsCreep) -> Bool =
  #| (self) => self.my

///|
pub extern "js" fn JsCreep::store(self : JsCreep) -> JsStore =
  #| (self) => self.store

///|
pub extern "js" fn JsCreep::hits(self : JsCreep) -> Int =
  #| (self) => self.hits

///|
pub extern "js" fn JsCreep::hits_max(self : JsCreep) -> Int =
  #| (self) => self.hitsMax

///|
pub extern "js" fn JsCreep::spawning(self : JsCreep) -> Bool =
  #| (self) => self.spawning

///|
pub extern "js" fn JsCreep::move_to_raw(
  self : JsCreep,
  target : JsGameObject,
) -> Int =
  #| (self, target) => self.moveTo(target)

///|
pub extern "js" fn JsCreep::harvest_raw(
  self : JsCreep,
  target : JsSource,
) -> Int =
  #| (self, target) => self.harvest(target)

///|
pub extern "js" fn JsCreep::transfer_raw(
  self : JsCreep,
  target : JsGameObject,
  resource : String,
) -> Int =
  #| (self, target, resource) => self.transfer(target, resource)

///|
pub extern "js" fn JsCreep::withdraw_raw(
  self : JsCreep,
  target : JsGameObject,
  resource : String,
) -> Int =
  #| (self, target, resource) => self.withdraw(target, resource)

///|
pub extern "js" fn JsCreep::build_raw(
  self : JsCreep,
  target : JsConstructionSite,
) -> Int =
  #| (self, target) => self.build(target)

///|
pub extern "js" fn JsCreep::attack_raw(
  self : JsCreep,
  target : JsGameObject,
) -> Int =
  #| (self, target) => self.attack(target)

///|
pub extern "js" fn JsCreep::ranged_attack_raw(
  self : JsCreep,
  target : JsGameObject,
) -> Int =
  #| (self, target) => self.rangedAttack(target)

///|
pub extern "js" fn JsCreep::heal_raw(
  self : JsCreep,
  target : JsGameObject,
) -> Int =
  #| (self, target) => self.heal(target)
