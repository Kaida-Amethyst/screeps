///|
/// Store 的 MoonBit wrapper。
pub struct Store {
  priv raw : @raw.JsStore
}

///|
pub fn Store::create(raw : @raw.JsStore) -> Store {
  Store::{ raw, }
}

///|
pub fn Store::to_raw(self : Store) -> @raw.JsStore {
  self.raw
}
