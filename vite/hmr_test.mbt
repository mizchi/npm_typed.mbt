///|
/// Tests for HMR payload helpers

///|
test "createFullReloadPayload without path" {
  let payload = createFullReloadPayload()
  let type_ : String = payload["type"].cast()
  inspect(type_, content="full-reload")
}

///|
test "createFullReloadPayload with path" {
  let payload = createFullReloadPayload(path="/src/app.ts")
  let type_ : String = payload["type"].cast()
  let path : String = payload["path"].cast()
  inspect(type_, content="full-reload")
  inspect(path, content="/src/app.ts")
}

///|
test "createUpdatePayload" {
  let update1 = @core.new_object()
  update1["type"] = @core.any("js-update")
  update1["path"] = @core.any("/src/foo.ts")
  let payload = createUpdatePayload([update1])
  let type_ : String = payload["type"].cast()
  inspect(type_, content="update")
  let updates : Array[@core.Any] = payload["updates"].cast()
  inspect(updates.length(), content="1")
}

///|
test "createPrunePayload" {
  let payload = createPrunePayload(["/src/old.ts", "/src/deprecated.ts"])
  let type_ : String = payload["type"].cast()
  inspect(type_, content="prune")
  let paths : Array[String] = payload["paths"].cast()
  inspect(paths.length(), content="2")
}

///|
test "createCustomPayload without data" {
  let payload = createCustomPayload("my-event")
  let type_ : String = payload["type"].cast()
  let event : String = payload["event"].cast()
  inspect(type_, content="custom")
  inspect(event, content="my-event")
}

///|
test "createCustomPayload with data" {
  let data = @core.new_object()
  data["key"] = @core.any("value")
  let payload = createCustomPayload("my-event", data~)
  let type_ : String = payload["type"].cast()
  let event : String = payload["event"].cast()
  inspect(type_, content="custom")
  inspect(event, content="my-event")
  let payload_data : @core.Any = payload["data"]
  let key : String = payload_data["key"].cast()
  inspect(key, content="value")
}
