///|
pub extern "js" fn JsGameObject::find_closest_by_path_raw(
  self : JsGameObject,
  candidates : Array[JsGameObject],
) -> @core.Nullish[JsGameObject] =
  #| (self, candidates) => self.findClosestByPath(candidates)

///|
pub extern "js" fn JsGameObject::find_closest_by_range_raw(
  self : JsGameObject,
  candidates : Array[JsGameObject],
) -> @core.Nullish[JsGameObject] =
  #| (self, candidates) => self.findClosestByRange(candidates)

///|
pub extern "js" fn JsGameObject::find_in_range_raw(
  self : JsGameObject,
  candidates : Array[JsGameObject],
  range : Int,
) -> Array[JsGameObject] =
  #| (self, candidates, range) => self.findInRange(candidates, range)

///|
pub extern "js" fn JsGameObject::get_range_to_raw(
  self : JsGameObject,
  target : JsGameObject,
) -> Int =
  #| (self, target) => self.getRangeTo(target)
