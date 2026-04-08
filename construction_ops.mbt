///|
pub fn create_construction_site(
  x : Int,
  y : Int,
  kind : StructureKind,
) -> CreateConstructionSiteResult {
  let result = @raw.create_construction_site_by_name(
    x,
    y,
    kind.to_prototype_name(),
  )
  match result.object().to_option() {
    Some(site) => Created(ConstructionSite::create(site))
    None =>
      match result.error().to_option() {
        Some(code) => CreateFailed(create_construction_site_failure_of(code))
        None => CreateFailed(CreateUnknownRawError(-9998))
      }
  }
}
