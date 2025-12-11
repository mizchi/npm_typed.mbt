///|
/// clsx - A tiny (239B) utility for constructing className strings conditionally
/// https://github.com/lukeed/clsx

///| Main clsx function - using #module (supports arrays natively)

///|
#module("clsx")
extern "js" fn ffi_clsx(args : Array[@core.Any]) -> String = "clsx"

///|
/// Construct className string from multiple strings
///
/// Example:
/// ```moonbit
/// let class_name = clsx(["foo", "bar", "baz"])
/// // => "foo bar baz"
/// ```
pub fn clsx(class_names : Array[String]) -> String {
  ffi_clsx(class_names.map(fn(s) { @core.any(s) }))
}

///|
/// Raw version - accepts strings, objects, arrays, and booleans
///
/// Example:
/// ```moonbit
/// let class_name = clsx_raw([@core.any("foo"), @core.any("bar")])
/// // => "foo bar"
/// ```
pub fn clsx_raw(args : Array[@core.Any]) -> String {
  ffi_clsx(args)
}

///|
/// Construct className string from an object mapping class names to booleans
///
/// Example:
/// ```moonbit
/// let obj = @core.new_object()
/// obj["active"] = @core.any(true)
/// obj["disabled"] = @core.any(false)
/// let class_name = clsx_obj(obj)
/// // => "active"
/// ```
pub fn clsx_obj(obj : @core.Any) -> String {
  ffi_clsx([obj])
}

///|
/// Construct className string combining strings and conditional object
///
/// Example:
/// ```moonbit
/// let obj = @core.new_object()
/// obj["active"] = @core.any(true)
/// let class_name = clsx_with("btn", obj)
/// // => "btn active"
/// ```
pub fn clsx_with(base : String, conditions : @core.Any) -> String {
  ffi_clsx([@core.any(base), conditions])
}
