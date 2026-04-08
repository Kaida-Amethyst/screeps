///|
fn nullish_int_or_zero(value : @core.Nullish[Int]) -> Int {
  match value.to_option() {
    Some(value) => value
    None => 0
  }
}

///|
pub fn Store::capacity(self : Store, resource : ResourceKind) -> Int {
  nullish_int_or_zero(self.to_raw().get_capacity_by(resource.to_raw()))
}

///|
pub fn Store::used(self : Store, resource : ResourceKind) -> Int {
  nullish_int_or_zero(self.to_raw().get_used_capacity_by(resource.to_raw()))
}

///|
pub fn Store::free(self : Store, resource : ResourceKind) -> Int {
  nullish_int_or_zero(self.to_raw().get_free_capacity_by(resource.to_raw()))
}

///|
pub fn Store::amount(self : Store, resource : ResourceKind) -> Int {
  self.to_raw().resource_amount(resource.to_raw())
}

///|
pub fn Store::energy(self : Store) -> Int {
  self.amount(Energy)
}

///|
pub fn Store::free_energy(self : Store) -> Int {
  self.free(Energy)
}
