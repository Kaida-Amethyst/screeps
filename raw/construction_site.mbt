///|
pub extern "js" fn JsConstructionSite::my(
  self : JsConstructionSite,
) -> @core.Nullish[Bool] =
  #| (self) => self.my

///|
pub extern "js" fn JsConstructionSite::progress(
  self : JsConstructionSite,
) -> @core.Nullish[Int] =
  #| (self) => self.progress

///|
pub extern "js" fn JsConstructionSite::progress_total(
  self : JsConstructionSite,
) -> @core.Nullish[Int] =
  #| (self) => self.progressTotal

///|
pub extern "js" fn JsConstructionSite::remove_raw(
  self : JsConstructionSite,
) -> Unit =
  #| (self) => self.remove()
