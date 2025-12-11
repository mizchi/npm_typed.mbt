///|
/// Valibot - The modular and type safe schema library
/// https://valibot.dev/

///| Types

///|
/// Schema - generic schema type parameterized by output type T
#external
pub type Schema[_]

///|
/// Convert schema to Any for use in object shapes
pub fn[T] Schema::to_any(self : Schema[T]) -> @core.Any = "%identity"

///|
/// Action - validation/transformation action for pipe
#external
pub type Action

///|
pub fn Action::to_any(self : Action) -> @core.Any = "%identity"

///|
/// SafeParseResult - result of safeParse, parameterized by output type T
#external
pub type SafeParseResult[_]

///|
pub fn[T] SafeParseResult::to_any(self : SafeParseResult[T]) -> @core.Any = "%identity"

///|
/// Issue - a single validation issue
#external
pub type Issue

///|
pub fn Issue::to_any(self : Issue) -> @core.Any = "%identity"

///| Schema creators - primitives

///|
/// Create a string schema
#module("valibot")
extern "js" fn ffi_string() -> @core.Any = "string"

///|
pub fn string_() -> Schema[String] {
  @core.identity(ffi_string())
}

///|
/// Create a number schema (Int in MoonBit)
#module("valibot")
extern "js" fn ffi_number() -> @core.Any = "number"

///|
pub fn number() -> Schema[Int] {
  @core.identity(ffi_number())
}

///|
/// Create a number schema for Double
pub fn number_double() -> Schema[Double] {
  @core.identity(ffi_number())
}

///|
/// Create a boolean schema
#module("valibot")
extern "js" fn ffi_boolean() -> @core.Any = "boolean"

///|
pub fn boolean() -> Schema[Bool] {
  @core.identity(ffi_boolean())
}

///| Schema creators - compound types

///|
/// Create an array schema
#module("valibot")
extern "js" fn ffi_array(item : @core.Any) -> @core.Any = "array"

///|
pub fn[T] array(item : Schema[T]) -> Schema[Array[T]] {
  @core.identity(ffi_array(item.to_any()))
}

///|
/// Create an optional schema
#module("valibot")
extern "js" fn ffi_optional(schema : @core.Any) -> @core.Any = "optional"

///|
pub fn[T] optional(schema : Schema[T]) -> Schema[T?] {
  @core.identity(ffi_optional(schema.to_any()))
}

///|
/// Create a nullable schema
#module("valibot")
extern "js" fn ffi_nullable(schema : @core.Any) -> @core.Any = "nullable"

///|
pub fn[T] nullable(schema : Schema[T]) -> Schema[T?] {
  @core.identity(ffi_nullable(schema.to_any()))
}

///|
/// Create a record schema (Map-like)
#module("valibot")
extern "js" fn ffi_record(key : @core.Any, value : @core.Any) -> @core.Any = "record"

///|
pub fn[V] record(value : Schema[V]) -> Schema[@core.Any] {
  @core.identity(ffi_record(ffi_string(), value.to_any()))
}

///| Schema creators - special types

///|
/// Create a literal schema
#module("valibot")
extern "js" fn ffi_literal(value : @core.Any) -> @core.Any = "literal"

///|
pub fn literal_string(value : String) -> Schema[String] {
  @core.identity(ffi_literal(@core.any(value)))
}

///|
pub fn literal_int(value : Int) -> Schema[Int] {
  @core.identity(ffi_literal(@core.any(value)))
}

///|
pub fn literal_bool(value : Bool) -> Schema[Bool] {
  @core.identity(ffi_literal(@core.any(value)))
}

///|
/// Create an any schema
#module("valibot")
extern "js" fn ffi_any() -> @core.Any = "any"

///|
pub fn any_() -> Schema[@core.Any] {
  @core.identity(ffi_any())
}

///|
/// Create an unknown schema
#module("valibot")
extern "js" fn ffi_unknown() -> @core.Any = "unknown"

///|
pub fn unknown() -> Schema[@core.Any] {
  @core.identity(ffi_unknown())
}

///| Schema creators - object (untyped, returns Any)

///|
/// Create an object schema
#module("valibot")
extern "js" fn ffi_object(shape : @core.Any) -> @core.Any = "object"

///|
/// Create an object schema - returns Schema[@core.Any] as MoonBit can't express object shapes
pub fn object(shape : @core.Any) -> Schema[@core.Any] {
  @core.identity(ffi_object(shape))
}

///|
/// Create a typed object schema using a builder function
pub fn[T] object_typed(shape : @core.Any) -> Schema[T] {
  @core.identity(ffi_object(shape))
}

///|
/// Create an object schema shape
pub fn shape() -> @core.Any {
  @core.new_object()
}

///| Schema creators - union/tuple (untyped)

///|
/// Create a union schema
#module("valibot")
extern "js" fn ffi_union(options : @core.Any) -> @core.Any = "union"

///|
pub fn union(options : Array[@core.Any]) -> Schema[@core.Any] {
  @core.identity(ffi_union(@core.any(options)))
}

///|
/// Create a tuple schema
#module("valibot")
extern "js" fn ffi_tuple(items : @core.Any) -> @core.Any = "tuple"

///|
pub fn tuple(items : Array[@core.Any]) -> Schema[@core.Any] {
  @core.identity(ffi_tuple(@core.any(items)))
}

///|
/// Create a picklist schema (enum-like)
#module("valibot")
extern "js" fn ffi_picklist(options : @core.Any) -> @core.Any = "picklist"

///|
pub fn picklist(options : Array[String]) -> Schema[String] {
  @core.identity(ffi_picklist(@core.any(options)))
}

///| Validation methods

///|
/// Chain schema with validation actions using pipe
extern "js" fn ffi_pipe(schema : @core.Any, actions : @core.Any) -> @core.Any =
  #| (schema, actions) => require("valibot").pipe(schema, ...actions)

///|
pub fn[T] pipe(schema : Schema[T], actions : Array[Action]) -> Schema[T] {
  @core.identity(ffi_pipe(schema.to_any(), @core.any(actions)))
}

///|
/// Parse input and throw on validation error
#module("valibot")
extern "js" fn ffi_parse(schema : @core.Any, input : @core.Any) -> @core.Any = "parse"

///|
pub fn[T] parse(schema : Schema[T], input : @core.Any) -> T {
  @core.identity(ffi_parse(schema.to_any(), input))
}

///|
/// Parse input and return result object (never throws)
#module("valibot")
extern "js" fn ffi_safeParse(
  schema : @core.Any,
  input : @core.Any,
) -> @core.Any = "safeParse"

///|
pub fn[T] safeParse(
  schema : Schema[T],
  input : @core.Any,
) -> SafeParseResult[T] {
  @core.identity(ffi_safeParse(schema.to_any(), input))
}

///|
/// Check if input matches schema (type guard)
#module("valibot")
extern "js" fn ffi_is(schema : @core.Any, input : @core.Any) -> Bool = "is"

///|
pub fn[T] is_(schema : Schema[T], input : @core.Any) -> Bool {
  ffi_is(schema.to_any(), input)
}

///| String validation actions

///|
/// Validate email format
#module("valibot")
pub extern "js" fn email() -> Action = "email"

///|
/// Validate URL format
#module("valibot")
pub extern "js" fn url() -> Action = "url"

///|
/// Validate UUID format
#module("valibot")
pub extern "js" fn uuid() -> Action = "uuid"

///|
/// Validate against regex pattern
#module("valibot")
extern "js" fn ffi_regex(pattern : @core.Any) -> Action = "regex"

///|
pub fn regex(pattern : @core.Any) -> Action {
  ffi_regex(pattern)
}

///|
/// Validate minimum length
#module("valibot")
pub extern "js" fn minLength(length : Int) -> Action = "minLength"

///|
/// Validate maximum length
#module("valibot")
pub extern "js" fn maxLength(length : Int) -> Action = "maxLength"

///|
/// Validate exact length
#module("valibot")
pub extern "js" fn length(length : Int) -> Action = "length"

///|
/// Validate starts with prefix
#module("valibot")
pub extern "js" fn startsWith(prefix : String) -> Action = "startsWith"

///|
/// Validate ends with suffix
#module("valibot")
pub extern "js" fn endsWith(suffix : String) -> Action = "endsWith"

///|
/// Validate includes substring
#module("valibot")
pub extern "js" fn includes(search : String) -> Action = "includes"

///|
/// Transform: trim whitespace
#module("valibot")
pub extern "js" fn trim() -> Action = "trim"

///|
/// Transform: convert to lowercase
#module("valibot")
pub extern "js" fn toLowerCase() -> Action = "toLowerCase"

///|
/// Transform: convert to uppercase
#module("valibot")
pub extern "js" fn toUpperCase() -> Action = "toUpperCase"

///| Number validation actions

///|
/// Validate minimum value
#module("valibot")
pub extern "js" fn minValue(value : Double) -> Action = "minValue"

///|
/// Validate maximum value
#module("valibot")
pub extern "js" fn maxValue(value : Double) -> Action = "maxValue"

///|
/// Validate integer
#module("valibot")
pub extern "js" fn integer() -> Action = "integer"

///|
/// Validate finite number
#module("valibot")
pub extern "js" fn finite() -> Action = "finite"

///| SafeParseResult methods

///|
/// Check if parsing was successful
pub fn[T] SafeParseResult::success(self : SafeParseResult[T]) -> Bool {
  self.to_any()["success"].cast()
}

///|
/// Check if the output is typed (passed type coercion)
pub fn[T] SafeParseResult::typed(self : SafeParseResult[T]) -> Bool {
  self.to_any()["typed"].cast()
}

///|
/// Get the parsed output (only valid if success is true)
pub fn[T] SafeParseResult::output(self : SafeParseResult[T]) -> T {
  @core.identity(self.to_any()["output"])
}

///|
/// Get the parsed output as Option (None if failed)
pub fn[T] SafeParseResult::output_option(self : SafeParseResult[T]) -> T? {
  if self.success() {
    Some(self.output())
  } else {
    None
  }
}

///|
/// Get validation issues (only valid if success is false)
pub fn[T] SafeParseResult::issues(self : SafeParseResult[T]) -> Array[Issue] {
  let arr = self.to_any()["issues"]
  if @core.is_nullish(arr) {
    []
  } else {
    @core.array_from(arr).map(@core.identity)
  }
}

///| Issue methods

///|
/// Get issue message
pub fn Issue::message(self : Issue) -> String {
  self.to_any()["message"].cast()
}

///|
/// Get issue path
pub fn Issue::path(self : Issue) -> @core.Any {
  self.to_any()["path"]
}

///|
/// Get issue kind
pub fn Issue::kind(self : Issue) -> String {
  self.to_any()["kind"].cast()
}

///|
/// Get issue type
pub fn Issue::type_(self : Issue) -> String {
  self.to_any()["type"].cast()
}

///|
/// Get issue input
pub fn Issue::input(self : Issue) -> @core.Any {
  self.to_any()["input"]
}

///|
/// Get issue expected value/type
pub fn Issue::expected(self : Issue) -> String? {
  let v = self.to_any()["expected"]
  if @core.is_nullish(v) {
    None
  } else {
    Some(v.cast())
  }
}

///|
/// Get issue received value/type
pub fn Issue::received(self : Issue) -> String? {
  let v = self.to_any()["received"]
  if @core.is_nullish(v) {
    None
  } else {
    Some(v.cast())
  }
}
