///|
fn nullish_int_or_zero(value : @core.Nullish[Int]) -> Int {
  match value.to_option() {
    Some(value) => value
    None => 0
  }
}

///|
/// 返回指定资源的总容量。
pub fn Store::capacity(self : Store, resource : ResourceKind) -> Int {
  nullish_int_or_zero(self.to_raw().get_capacity_by(resource.to_raw()))
}

///|
/// 返回指定资源当前已使用的容量。
pub fn Store::used(self : Store, resource : ResourceKind) -> Int {
  nullish_int_or_zero(self.to_raw().get_used_capacity_by(resource.to_raw()))
}

///|
/// 返回指定资源当前剩余可用容量。
pub fn Store::free(self : Store, resource : ResourceKind) -> Int {
  nullish_int_or_zero(self.to_raw().get_free_capacity_by(resource.to_raw()))
}

///|
/// 返回指定资源当前实际存量。
pub fn Store::amount(self : Store, resource : ResourceKind) -> Int {
  self.to_raw().resource_amount(resource.to_raw())
}

///|
/// 返回当前存储中的能量数量。
pub fn Store::energy(self : Store) -> Int {
  self.amount(Energy)
}

///|
/// 返回当前还能容纳多少能量。
pub fn Store::free_energy(self : Store) -> Int {
  self.free(Energy)
}
