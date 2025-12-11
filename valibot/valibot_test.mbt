///|
test "string_ - creates typed string schema" {
  let schema : @valibot.Schema[String] = @valibot.string_()
  let result : String = @valibot.parse(schema, @core.any("hello"))
  inspect(result, content="hello")
}

///|
test "number - creates typed number schema" {
  let schema : @valibot.Schema[Int] = @valibot.number()
  let result : Int = @valibot.parse(schema, @core.any(42))
  inspect(result, content="42")
}

///|
test "number_double - creates typed double schema" {
  let schema : @valibot.Schema[Double] = @valibot.number_double()
  let result : Double = @valibot.parse(schema, @core.any(3.14))
  inspect(result, content="3.14")
}

///|
test "boolean - creates typed boolean schema" {
  let schema : @valibot.Schema[Bool] = @valibot.boolean()
  let result : Bool = @valibot.parse(schema, @core.any(true))
  inspect(result, content="true")
}

///|
test "array - creates typed array schema" {
  let schema : @valibot.Schema[Array[String]] = @valibot.array(
    @valibot.string_(),
  )
  let result : Array[String] = @valibot.parse(
    schema,
    @core.any(["a", "b", "c"]),
  )
  inspect(result.length(), content="3")
  inspect(result[0], content="a")
}

///|
test "optional - creates optional schema" {
  let schema : @valibot.Schema[String?] = @valibot.optional(@valibot.string_())
  // Valid with value
  let result1 = @valibot.safeParse(schema, @core.any("hello"))
  inspect(result1.success(), content="true")
  // Valid with undefined
  let result2 = @valibot.safeParse(schema, @core.undefined())
  inspect(result2.success(), content="true")
}

///|
test "nullable - creates nullable schema" {
  let schema : @valibot.Schema[String?] = @valibot.nullable(@valibot.string_())
  // Valid with value
  let result1 = @valibot.safeParse(schema, @core.any("hello"))
  inspect(result1.success(), content="true")
  // Valid with null
  let result2 = @valibot.safeParse(schema, @core.null())
  inspect(result2.success(), content="true")
}

///|
test "literal_string - creates string literal schema" {
  let schema : @valibot.Schema[String] = @valibot.literal_string("hello")
  let result = @valibot.safeParse(schema, @core.any("hello"))
  inspect(result.success(), content="true")
  let result_fail = @valibot.safeParse(schema, @core.any("world"))
  inspect(result_fail.success(), content="false")
}

///|
test "literal_int - creates int literal schema" {
  let schema : @valibot.Schema[Int] = @valibot.literal_int(42)
  let result = @valibot.safeParse(schema, @core.any(42))
  inspect(result.success(), content="true")
  let result_fail = @valibot.safeParse(schema, @core.any(43))
  inspect(result_fail.success(), content="false")
}

///|
test "picklist - creates enum-like schema" {
  let schema : @valibot.Schema[String] = @valibot.picklist([
    "red", "green", "blue",
  ])
  let result = @valibot.safeParse(schema, @core.any("red"))
  inspect(result.success(), content="true")
  let result_fail = @valibot.safeParse(schema, @core.any("yellow"))
  inspect(result_fail.success(), content="false")
}

///|
test "safeParse - returns typed output on success" {
  let schema : @valibot.Schema[String] = @valibot.string_()
  let result : @valibot.SafeParseResult[String] = @valibot.safeParse(
    schema,
    @core.any("hello"),
  )
  inspect(result.success(), content="true")
  let output : String = result.output()
  inspect(output, content="hello")
}

///|
test "safeParse - returns issues on failure" {
  let schema : @valibot.Schema[String] = @valibot.string_()
  let result : @valibot.SafeParseResult[String] = @valibot.safeParse(
    schema,
    @core.any(123),
  )
  inspect(result.success(), content="false")
  let issues : Array[@valibot.Issue] = result.issues()
  inspect(issues.length() > 0, content="true")
  inspect(issues[0].message().length() > 0, content="true")
}

///|
test "is_ - type guard returns true for valid" {
  let schema : @valibot.Schema[String] = @valibot.string_()
  inspect(@valibot.is_(schema, @core.any("hello")), content="true")
}

///|
test "is_ - type guard returns false for invalid" {
  let schema : @valibot.Schema[String] = @valibot.string_()
  inspect(@valibot.is_(schema, @core.any(123)), content="false")
}

///|
test "pipe - chain actions with schema" {
  let schema : @valibot.Schema[String] = @valibot.pipe(@valibot.string_(), [
    @valibot.minLength(3),
    @valibot.maxLength(10),
  ])
  // Valid
  let result1 = @valibot.safeParse(schema, @core.any("hello"))
  inspect(result1.success(), content="true")
  // Too short
  let result2 = @valibot.safeParse(schema, @core.any("ab"))
  inspect(result2.success(), content="false")
  // Too long
  let result3 = @valibot.safeParse(schema, @core.any("12345678901"))
  inspect(result3.success(), content="false")
}

///|
test "email action - validates email format" {
  let schema : @valibot.Schema[String] = @valibot.pipe(@valibot.string_(), [
    @valibot.email(),
  ])
  let result1 = @valibot.safeParse(schema, @core.any("test@example.com"))
  inspect(result1.success(), content="true")
  let result2 = @valibot.safeParse(schema, @core.any("invalid"))
  inspect(result2.success(), content="false")
}

///|
test "minValue/maxValue - validates number range" {
  let schema : @valibot.Schema[Int] = @valibot.pipe(@valibot.number(), [
    @valibot.minValue(0.0),
    @valibot.maxValue(100.0),
  ])
  let result1 = @valibot.safeParse(schema, @core.any(50))
  inspect(result1.success(), content="true")
  let result2 = @valibot.safeParse(schema, @core.any(-1))
  inspect(result2.success(), content="false")
  let result3 = @valibot.safeParse(schema, @core.any(101))
  inspect(result3.success(), content="false")
}

///|
test "object - untyped object schema" {
  let s = @valibot.shape()
  s["name"] = @valibot.string_().to_any()
  s["age"] = @valibot.number().to_any()
  let schema : @valibot.Schema[@core.Any] = @valibot.object(s)
  let input = @core.new_object()
  input["name"] = @core.any("Alice")
  input["age"] = @core.any(30)
  let result = @valibot.safeParse(schema, input)
  inspect(result.success(), content="true")
}

///|
priv struct User {
  name : String
  age : Int
}

///|
test "object_typed - typed object schema" {
  let s = @valibot.shape()
  s["name"] = @valibot.string_().to_any()
  s["age"] = @valibot.number().to_any()
  let schema : @valibot.Schema[User] = @valibot.object_typed(s)
  let input = @core.new_object()
  input["name"] = @core.any("Alice")
  input["age"] = @core.any(30)
  let result : @valibot.SafeParseResult[User] = @valibot.safeParse(
    schema, input,
  )
  inspect(result.success(), content="true")
  let user : User = result.output()
  inspect(user.name, content="Alice")
  inspect(user.age, content="30")
}

///|
test "Issue - access issue details" {
  let schema : @valibot.Schema[String] = @valibot.string_()
  let result = @valibot.safeParse(schema, @core.any(123))
  let issues = result.issues()
  let issue = issues[0]
  // Check issue has required fields
  inspect(issue.kind().length() > 0, content="true")
  inspect(issue.type_().length() > 0, content="true")
  inspect(issue.message().length() > 0, content="true")
}

///|
test "SafeParseResult - typed property" {
  let schema : @valibot.Schema[String] = @valibot.string_()
  // Valid input - typed is true
  let result1 = @valibot.safeParse(schema, @core.any("hello"))
  inspect(result1.typed(), content="true")
  inspect(result1.success(), content="true")
  // Invalid input - typed is false
  let result2 = @valibot.safeParse(schema, @core.any(123))
  inspect(result2.typed(), content="false")
  inspect(result2.success(), content="false")
}

///|
test "SafeParseResult - output_option" {
  let schema : @valibot.Schema[String] = @valibot.string_()
  // Valid input - returns Some
  let result1 = @valibot.safeParse(schema, @core.any("hello"))
  match result1.output_option() {
    Some(v) => inspect(v, content="hello")
    None => panic()
  }
  // Invalid input - returns None
  let result2 = @valibot.safeParse(schema, @core.any(123))
  match result2.output_option() {
    Some(_) => panic()
    None => inspect(true, content="true")
  }
}

///|
test "SafeParseResult - issues empty when success" {
  let schema : @valibot.Schema[String] = @valibot.string_()
  let result = @valibot.safeParse(schema, @core.any("hello"))
  inspect(result.success(), content="true")
  inspect(result.issues().length(), content="0")
}
