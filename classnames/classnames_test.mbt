///|
test "classNames - strings" {
  let result = @classnames.classNames(["foo", "bar"])
  inspect(result, content="foo bar")
}

///|
test "classNames - with conditional" {
  let is_active = true
  let result = @classnames.classNames([
    "foo",
    if is_active {
      "bar"
    } else {
      ""
    },
    "baz",
  ])
  inspect(result, content="foo bar baz")
}

///|
test "classNames_raw - mixed types" {
  let result = @classnames.classNames_raw([@core.any("foo"), @core.any("bar")])
  inspect(result, content="foo bar")
}

///|
test "classNames - object" {
  let obj = @core.new_object()
  obj["active"] = @core.any(true)
  obj["disabled"] = @core.any(false)
  let result = @classnames.classNames_obj(obj)
  inspect(result, content="active")
}

///|
test "classNames - mixed strings and object" {
  let obj = @core.new_object()
  obj["active"] = @core.any(true)
  obj["hidden"] = @core.any(false)
  let result = @classnames.classNames_with("btn", obj)
  inspect(result, content="btn active")
}

///|
test "classNames - single string" {
  let result = @classnames.classNames(["hello"])
  inspect(result, content="hello")
}

///|
test "classNames - multiple strings" {
  let result = @classnames.classNames(["foo", "bar", "baz"])
  inspect(result, content="foo bar baz")
}
