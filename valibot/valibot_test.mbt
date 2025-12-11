///|
test "string_ - creates string schema" {
  let schema = @valibot.string_()
  inspect(@core.typeof_(schema.to_any()), content="object")
}

///|
test "number - creates number schema" {
  let schema = @valibot.number()
  inspect(@core.typeof_(schema.to_any()), content="object")
}

///|
test "boolean - creates boolean schema" {
  let schema = @valibot.boolean()
  inspect(@core.typeof_(schema.to_any()), content="object")
}

///|
test "object - creates object schema" {
  let shape = @valibot.shape()
  shape["name"] = @valibot.string_().to_any()
  shape["age"] = @valibot.number().to_any()
  let schema = @valibot.object(shape)
  inspect(@core.typeof_(schema.to_any()), content="object")
}

///|
test "array - creates array schema" {
  let schema = @valibot.array(@valibot.string_())
  inspect(@core.typeof_(schema.to_any()), content="object")
}

///|
test "optional - creates optional schema" {
  let schema = @valibot.optional(@valibot.string_())
  inspect(@core.typeof_(schema.to_any()), content="object")
}

///|
test "nullable - creates nullable schema" {
  let schema = @valibot.nullable(@valibot.string_())
  inspect(@core.typeof_(schema.to_any()), content="object")
}

///|
test "literal - creates literal schema" {
  let schema = @valibot.literal(@core.any("hello"))
  inspect(@core.typeof_(schema.to_any()), content="object")
}

///|
test "union - creates union schema" {
  let opts = @valibot.options()
  opts._call("push", [@valibot.string_().to_any()]) |> ignore
  opts._call("push", [@valibot.number().to_any()]) |> ignore
  let schema = @valibot.union(opts)
  inspect(@core.typeof_(schema.to_any()), content="object")
}

///|
test "parse - parses valid string" {
  let schema = @valibot.string_()
  let result = @valibot.parse(schema, @core.any("hello"))
  inspect(result.cast() |> String::to_string, content="hello")
}

///|
test "parse - parses valid number" {
  let schema = @valibot.number()
  let result = @valibot.parse(schema, @core.any(42))
  inspect(result.cast() |> Int::to_string, content="42")
}

///|
test "safeParse - returns success for valid input" {
  let schema = @valibot.string_()
  let result = @valibot.safeParse(schema, @core.any("hello"))
  inspect(result.success(), content="true")
  inspect(result.output().cast() |> String::to_string, content="hello")
}

///|
test "safeParse - returns failure for invalid input" {
  let schema = @valibot.string_()
  let result = @valibot.safeParse(schema, @core.any(123))
  inspect(result.success(), content="false")
  inspect(@core.typeof_(result.issues()), content="object")
}

///|
test "is_ - type guard returns true for valid" {
  let schema = @valibot.string_()
  let result = @valibot.is_(schema, @core.any("hello"))
  inspect(result, content="true")
}

///|
test "is_ - type guard returns false for invalid" {
  let schema = @valibot.string_()
  let result = @valibot.is_(schema, @core.any(123))
  inspect(result, content="false")
}

///|
test "email - validation action" {
  let action = @valibot.email()
  inspect(@core.typeof_(action), content="object")
}

///|
test "minLength - validation action" {
  let action = @valibot.minLength(5)
  inspect(@core.typeof_(action), content="object")
}

///|
test "maxLength - validation action" {
  let action = @valibot.maxLength(10)
  inspect(@core.typeof_(action), content="object")
}

///|
test "minValue - validation action" {
  let action = @valibot.minValue(0.0)
  inspect(@core.typeof_(action), content="object")
}

///|
test "maxValue - validation action" {
  let action = @valibot.maxValue(100.0)
  inspect(@core.typeof_(action), content="object")
}

///|
test "shape helper - creates empty object" {
  let s = @valibot.shape()
  inspect(@core.typeof_(s), content="object")
}

///|
test "options helper - creates empty array" {
  let o = @valibot.options()
  inspect(@core.typeof_(o), content="object")
}
