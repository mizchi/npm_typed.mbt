///|
test "clsx - strings" {
  let result = @clsx.clsx(["foo", "bar"])
  inspect(result, content="foo bar")
}

///|
test "clsx - with conditional" {
  let is_active = true
  let result = @clsx.clsx([
    "foo",
    if is_active { "bar" } else { "" },
    "baz",
  ])
  inspect(result, content="foo bar baz")
}

///|
test "clsx_raw - mixed types" {
  let result = @clsx.clsx_raw([@core.any("foo"), @core.any("bar")])
  inspect(result, content="foo bar")
}

///|
test "clsx - object" {
  let obj = @core.new_object()
  obj["active"] = @core.any(true)
  obj["disabled"] = @core.any(false)
  let result = @clsx.clsx_obj(obj)
  inspect(result, content="active")
}

///|
test "clsx - mixed strings and object" {
  let obj = @core.new_object()
  obj["active"] = @core.any(true)
  obj["hidden"] = @core.any(false)
  let result = @clsx.clsx_with("btn", obj)
  inspect(result, content="btn active")
}

///|
test "clsx - single string" {
  let result = @clsx.clsx(["hello"])
  inspect(result, content="hello")
}

///|
test "clsx - multiple strings" {
  let result = @clsx.clsx(["foo", "bar", "baz"])
  inspect(result, content="foo bar baz")
}

///|
test "clsx_raw - falsey values discarded" {
  let result = @clsx.clsx_raw([
    @core.any(true),
    @core.any(false),
    @core.any(""),
    @core.null(),
    @core.undefined(),
    @core.any(0),
  ])
  inspect(result, content="")
}
