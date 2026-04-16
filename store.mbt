///|
/// Store 的 MoonBit wrapper。
pub struct Store {
  priv raw : @raw.JsStore
}

///|
/// 从 raw store 构造高层视图。通常下游无需直接调用。
pub fn Store::create(raw : @raw.JsStore) -> Store {
  Store::{ raw, }
}

///|
/// 返回底层 raw store 句柄。通常下游无需直接调用。
pub fn Store::to_raw(self : Store) -> @raw.JsStore {
  self.raw
}
