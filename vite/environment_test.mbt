///|
/// Tests for Environment API

///|
test "environmentOptions with all fields" {
  let resolve = @core.new_object()
  resolve["alias"] = @core.any({ "/src": "/source" })
  let obj = @vite.environmentOptions(consumer="server", resolve~)
  let consumer : String = obj["consumer"].cast()
  inspect(consumer, content="server")
  assert_false(@core.is_nullish(obj["resolve"]))
}

///|
test "environmentOptions with minimal fields" {
  let obj = @vite.environmentOptions()
  assert_true(@core.is_nullish(obj["consumer"]))
  assert_true(@core.is_nullish(obj["resolve"]))
}

///|
test "environmentOptions client consumer" {
  let obj = @vite.environmentOptions(consumer="client")
  let consumer : String = obj["consumer"].cast()
  inspect(consumer, content="client")
}
