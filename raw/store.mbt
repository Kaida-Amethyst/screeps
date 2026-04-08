///|
pub extern "js" fn JsStore::get_capacity(self : JsStore) -> @core.Nullish[Int] =
  #| (self) => self.getCapacity()

///|
pub extern "js" fn JsStore::get_capacity_by(
  self : JsStore,
  resource : String,
) -> @core.Nullish[Int] =
  #| (self, resource) => self.getCapacity(resource)

///|
pub extern "js" fn JsStore::get_used_capacity(
  self : JsStore,
) -> @core.Nullish[Int] =
  #| (self) => self.getUsedCapacity()

///|
pub extern "js" fn JsStore::get_used_capacity_by(
  self : JsStore,
  resource : String,
) -> @core.Nullish[Int] =
  #| (self, resource) => self.getUsedCapacity(resource)

///|
pub extern "js" fn JsStore::get_free_capacity(
  self : JsStore,
) -> @core.Nullish[Int] =
  #| (self) => self.getFreeCapacity()

///|
pub extern "js" fn JsStore::get_free_capacity_by(
  self : JsStore,
  resource : String,
) -> @core.Nullish[Int] =
  #| (self, resource) => self.getFreeCapacity(resource)

///|
pub extern "js" fn JsStore::resource_amount(
  self : JsStore,
  resource : String,
) -> Int =
  #| (self, resource) => self[resource] ?? 0
