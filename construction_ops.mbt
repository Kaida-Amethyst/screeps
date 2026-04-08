///|
pub fn create_construction_site(
  x : Int,
  y : Int,
  kind : StructureKind,
) -> ConstructionSite raise ActionError {
  let result = @raw.create_construction_site_by_name(
    x,
    y,
    kind.to_prototype_name(),
  )
  match result.object().to_option() {
    Some(site) => ConstructionSite::create(site)
    None =>
      match result.error().to_option() {
        Some(code) => raise action_error_of(code)
        None => raise UnknownRawError(-9998)
      }
  }
}
