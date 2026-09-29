///|
pub extern "js" fn JsGameObject::find_closest_by_path_raw_ffi(
  self : JsGameObject,
  candidates : FixedArray[JsGameObject],
) -> @core.Nullish[JsGameObject] =
  #| (self, candidates) => self.findClosestByPath(candidates)

pub fn JsGameObject::find_closest_by_path_raw(
  self : JsGameObject,
  candidates : Array[JsGameObject],
) -> @core.Nullish[JsGameObject] {
  JsGameObject::find_closest_by_path_raw_ffi(self, FixedArray::from_array(candidates))
}

///|
pub extern "js" fn JsGameObject::find_closest_by_range_raw_ffi(
  self : JsGameObject,
  candidates : FixedArray[JsGameObject],
) -> @core.Nullish[JsGameObject] =
  #| (self, candidates) => self.findClosestByRange(candidates)

pub fn JsGameObject::find_closest_by_range_raw(
  self : JsGameObject,
  candidates : Array[JsGameObject],
) -> @core.Nullish[JsGameObject] {
  JsGameObject::find_closest_by_range_raw_ffi(self, FixedArray::from_array(candidates))
}

///|
pub extern "js" fn JsGameObject::find_in_range_raw_ffi(
  self : JsGameObject,
  candidates : FixedArray[JsGameObject],
  range : Int,
) -> FixedArray[JsGameObject] =
  #| (self, candidates, range) => self.findInRange(candidates, range)

pub fn JsGameObject::find_in_range_raw(
  self : JsGameObject,
  candidates : Array[JsGameObject],
  range : Int,
) -> Array[JsGameObject] {
  Array::from_fixed_array(JsGameObject::find_in_range_raw_ffi(self, FixedArray::from_array(candidates), range))
}

///|
pub extern "js" fn JsGameObject::get_range_to_raw(
  self : JsGameObject,
  target : JsGameObject,
) -> Int =
  #| (self, target) => self.getRangeTo(target)
