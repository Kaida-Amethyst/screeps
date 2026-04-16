///|
/// creep 身上的一个 body part 视图。
pub struct BodyPart {
  priv kind : BodyPartKind
  priv hits : Int
}

///|
/// 从 raw body part 构造高层视图。
pub fn BodyPart::create(raw : @raw.JsCreepBodyPart) -> BodyPart {
  BodyPart::{ kind: body_part_kind_from_raw(raw.kind()), hits: raw.hits() }
}

///|
/// 返回 body part 的种类。
pub fn BodyPart::kind(self : BodyPart) -> BodyPartKind {
  self.kind
}

///|
/// 返回该 body part 当前剩余的生命值。
pub fn BodyPart::hits(self : BodyPart) -> Int {
  self.hits
}
