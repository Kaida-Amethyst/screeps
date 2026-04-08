///|
pub extern "js" fn JsStructureContainer::my(
  self : JsStructureContainer,
) -> @core.Nullish[Bool] =
  #| (self) => self.my

///|
pub extern "js" fn JsStructureContainer::store(
  self : JsStructureContainer,
) -> JsStore =
  #| (self) => self.store

///|
pub extern "js" fn JsStructureContainer::hits(
  self : JsStructureContainer,
) -> Int =
  #| (self) => self.hits ?? 0

///|
pub extern "js" fn JsStructureContainer::hits_max(
  self : JsStructureContainer,
) -> Int =
  #| (self) => self.hitsMax ?? 0
