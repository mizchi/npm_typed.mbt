///|
/// Valibot - The modular and type safe schema library
/// https://valibot.dev/

///| Types

///|
/// Schema - base schema type for validation
#external
pub type Schema

///|
pub fn Schema::to_any(self : Schema) -> @core.Any = "%identity"

///|
/// SafeParseResult - result of safeParse
#external
pub type SafeParseResult

///|
pub fn SafeParseResult::to_any(self : SafeParseResult) -> @core.Any = "%identity"

///|
/// ValiError - validation error
#external
pub type ValiError

///|
pub fn ValiError::to_any(self : ValiError) -> @core.Any = "%identity"

///|
/// Issue - a single validation issue
#external
pub type Issue

///|
pub fn Issue::to_any(self : Issue) -> @core.Any = "%identity"

///| Schema creators

///|
/// Create a string schema
#module("valibot")
pub extern "js" fn string_() -> Schema = "string"

///|
/// Create a number schema
#module("valibot")
pub extern "js" fn number() -> Schema = "number"

///|
/// Create a boolean schema
#module("valibot")
pub extern "js" fn boolean() -> Schema = "boolean"

///|
/// Create a bigint schema
#module("valibot")
pub extern "js" fn bigint() -> Schema = "bigint"

///|
/// Create a date schema
#module("valibot")
pub extern "js" fn date() -> Schema = "date"

///|
/// Create a null schema
#module("valibot")
pub extern "js" fn null_() -> Schema = "null_"

///|
/// Create an undefined schema
#module("valibot")
pub extern "js" fn undefined_() -> Schema = "undefined_"

///|
/// Create an any schema
#module("valibot")
pub extern "js" fn any_() -> Schema = "any"

///|
/// Create an unknown schema
#module("valibot")
pub extern "js" fn unknown() -> Schema = "unknown"

///|
/// Create a literal schema
#module("valibot")
pub extern "js" fn literal(value : @core.Any) -> Schema = "literal"

///|
/// Create an object schema
#module("valibot")
pub extern "js" fn object(shape : @core.Any) -> Schema = "object"

///|
/// Create an array schema
#module("valibot")
pub extern "js" fn array(item : Schema) -> Schema = "array"

///|
/// Create a tuple schema
#module("valibot")
pub extern "js" fn tuple(items : @core.Any) -> Schema = "tuple"

///|
/// Create a union schema
#module("valibot")
pub extern "js" fn union(options : @core.Any) -> Schema = "union"

///|
/// Create an intersection schema
#module("valibot")
pub extern "js" fn intersect(options : @core.Any) -> Schema = "intersect"

///|
/// Create an optional schema
#module("valibot")
pub extern "js" fn optional(schema : Schema) -> Schema = "optional"

///|
/// Create a nullable schema
#module("valibot")
pub extern "js" fn nullable(schema : Schema) -> Schema = "nullable"

///|
/// Create a nullish schema (null or undefined)
#module("valibot")
pub extern "js" fn nullish(schema : Schema) -> Schema = "nullish"

///|
/// Create a record schema
#module("valibot")
pub extern "js" fn record(key : Schema, value : Schema) -> Schema = "record"

///|
/// Create a picklist schema (enum-like)
#module("valibot")
pub extern "js" fn picklist(options : @core.Any) -> Schema = "picklist"

///| Validation methods

///|
/// Chain schema with validation actions using pipe
#module("valibot")
pub extern "js" fn pipe(schema : Schema, actions : @core.Any) -> Schema = "pipe"

///|
/// Parse input and throw on validation error
#module("valibot")
pub extern "js" fn parse(schema : Schema, input : @core.Any) -> @core.Any = "parse"

///|
/// Parse input and return result object (never throws)
#module("valibot")
pub extern "js" fn safeParse(
  schema : Schema,
  input : @core.Any,
) -> SafeParseResult = "safeParse"

///|
/// Check if input matches schema (type guard)
#module("valibot")
pub extern "js" fn is_(schema : Schema, input : @core.Any) -> Bool = "is"

///| String validation actions

///|
/// Validate email format
#module("valibot")
pub extern "js" fn email() -> @core.Any = "email"

///|
/// Validate URL format
#module("valibot")
pub extern "js" fn url() -> @core.Any = "url"

///|
/// Validate UUID format
#module("valibot")
pub extern "js" fn uuid() -> @core.Any = "uuid"

///|
/// Validate against regex pattern
#module("valibot")
pub extern "js" fn regex(pattern : @core.Any) -> @core.Any = "regex"

///|
/// Validate minimum length
#module("valibot")
pub extern "js" fn minLength(length : Int) -> @core.Any = "minLength"

///|
/// Validate maximum length
#module("valibot")
pub extern "js" fn maxLength(length : Int) -> @core.Any = "maxLength"

///|
/// Validate exact length
#module("valibot")
pub extern "js" fn length(length : Int) -> @core.Any = "length"

///|
/// Validate starts with prefix
#module("valibot")
pub extern "js" fn startsWith(prefix : String) -> @core.Any = "startsWith"

///|
/// Validate ends with suffix
#module("valibot")
pub extern "js" fn endsWith(suffix : String) -> @core.Any = "endsWith"

///|
/// Validate includes substring
#module("valibot")
pub extern "js" fn includes(search : String) -> @core.Any = "includes"

///|
/// Transform: trim whitespace
#module("valibot")
pub extern "js" fn trim() -> @core.Any = "trim"

///|
/// Transform: convert to lowercase
#module("valibot")
pub extern "js" fn toLowerCase() -> @core.Any = "toLowerCase"

///|
/// Transform: convert to uppercase
#module("valibot")
pub extern "js" fn toUpperCase() -> @core.Any = "toUpperCase"

///| Number validation actions

///|
/// Validate minimum value
#module("valibot")
pub extern "js" fn minValue(value : Double) -> @core.Any = "minValue"

///|
/// Validate maximum value
#module("valibot")
pub extern "js" fn maxValue(value : Double) -> @core.Any = "maxValue"

///|
/// Validate integer
#module("valibot")
pub extern "js" fn integer() -> @core.Any = "integer"

///|
/// Validate finite number
#module("valibot")
pub extern "js" fn finite() -> @core.Any = "finite"

///| SafeParseResult methods

///|
/// Check if parsing was successful
pub fn SafeParseResult::success(self : SafeParseResult) -> Bool {
  self.to_any()["success"].cast()
}

///|
/// Get the parsed output (only valid if success is true)
pub fn SafeParseResult::output(self : SafeParseResult) -> @core.Any {
  self.to_any()["output"]
}

///|
/// Get validation issues (only valid if success is false)
pub fn SafeParseResult::issues(self : SafeParseResult) -> @core.Any {
  self.to_any()["issues"]
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

///| Helper functions

///|
/// Create an object schema shape
pub fn shape() -> @core.Any {
  @core.new_object()
}

///|
/// Create an array for union/tuple options
pub fn options() -> @core.Any {
  @core.new_array()
}
