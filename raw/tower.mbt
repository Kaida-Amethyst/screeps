///|
pub extern "js" fn JsStructureTower::my(
  self : JsStructureTower,
) -> @core.Nullish[Bool] =
  #| (self) => self.my

///|
pub extern "js" fn JsStructureTower::store(self : JsStructureTower) -> JsStore =
  #| (self) => self.store

///|
pub extern "js" fn JsStructureTower::hits(self : JsStructureTower) -> Int =
  #| (self) => self.hits ?? 0

///|
pub extern "js" fn JsStructureTower::hits_max(self : JsStructureTower) -> Int =
  #| (self) => self.hitsMax ?? 0

///|
pub extern "js" fn JsStructureTower::cooldown(self : JsStructureTower) -> Int =
  #| (self) => self.cooldown ?? 0

///|
pub extern "js" fn JsStructureTower::attack_raw(
  self : JsStructureTower,
  target : JsGameObject,
) -> Int =
  #| (self, target) => self.attack(target)

///|
pub extern "js" fn JsStructureTower::heal_raw(
  self : JsStructureTower,
  target : JsGameObject,
) -> Int =
  #| (self, target) => self.heal(target)
