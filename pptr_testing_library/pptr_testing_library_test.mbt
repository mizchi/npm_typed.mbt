///|
/// Tests for pptr-testing-library bindings
/// Note: These are type-checking tests only, as actual tests require a browser

///|
test "Queries type exists" {
  // Queries type should be available
  fn(_q : @pptr_testing_library.Queries) -> Unit {
    ()
  }
  |> ignore
  inspect(true, content="true")
}
