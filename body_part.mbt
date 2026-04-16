///|
/// creep 身上的一个 body part 视图。
pub struct BodyPart {
  priv kind : BodyPartKind
  priv hits : Int
}

///|
pub fn BodyPart::create(raw : @raw.JsCreepBodyPart) -> BodyPart {
  BodyPart::{ kind: body_part_kind_from_raw(raw.kind()), hits: raw.hits() }
}

///|
pub fn BodyPart::kind(self : BodyPart) -> BodyPartKind {
  self.kind
}

///|
pub fn BodyPart::hits(self : BodyPart) -> Int {
  self.hits
}
