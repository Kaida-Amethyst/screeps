///|
fn nullish_int_or_zero(value : @core.Nullish[Int]) -> Int {
  match value.to_option() {
    Some(value) => value
    None => 0
  }
}

///|
pub fn store_capacity(store : @model.Store, resource : ResourceKind) -> Int {
  nullish_int_or_zero(store.to_raw().get_capacity_by(resource.to_raw()))
}

///|
pub fn store_used(store : @model.Store, resource : ResourceKind) -> Int {
  nullish_int_or_zero(store.to_raw().get_used_capacity_by(resource.to_raw()))
}

///|
pub fn store_free(store : @model.Store, resource : ResourceKind) -> Int {
  nullish_int_or_zero(store.to_raw().get_free_capacity_by(resource.to_raw()))
}

///|
pub fn store_amount(store : @model.Store, resource : ResourceKind) -> Int {
  store.to_raw().resource_amount(resource.to_raw())
}

///|
pub fn store_energy(store : @model.Store) -> Int {
  store_amount(store, Energy)
}

///|
pub fn store_free_energy(store : @model.Store) -> Int {
  store_free(store, Energy)
}
