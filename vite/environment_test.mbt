///|
/// Tests for Environment API

///|
test "EnvironmentOptions::to_any with all fields" {
  let resolve = @core.new_object()
  resolve["alias"] = @core.any({ "/src": "/source" })
  let options = EnvironmentOptions::{
    consumer: Some("server"),
    resolve: Some(resolve),
    dev: None,
    build: None,
  }
  let obj = options.to_any()
  let consumer : String = obj["consumer"].cast()
  inspect(consumer, content="server")
  assert_false(@core.is_nullish(obj["resolve"]))
}

///|
test "EnvironmentOptions::to_any with minimal fields" {
  let options = EnvironmentOptions::{
    consumer: None,
    resolve: None,
    dev: None,
    build: None,
  }
  let obj = options.to_any()
  assert_true(@core.is_nullish(obj["consumer"]))
  assert_true(@core.is_nullish(obj["resolve"]))
}

///|
test "EnvironmentOptions::to_any client consumer" {
  let options = EnvironmentOptions::{
    consumer: Some("client"),
    resolve: None,
    dev: None,
    build: None,
  }
  let obj = options.to_any()
  let consumer : String = obj["consumer"].cast()
  inspect(consumer, content="client")
}
