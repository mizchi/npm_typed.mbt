///|
/// classnames - A simple JavaScript utility for conditionally joining classNames together
/// https://github.com/JedWatson/classnames

///| Main classnames function

///|
extern "js" fn ffi_classNames(args : Array[@core.Any]) -> String =
  #| (args) => require('classnames')(...args)

///|
/// Construct className string from multiple strings
///
/// Example:
/// ```moonbit
/// let class_name = classNames(["foo", "bar", "baz"])
/// // => "foo bar baz"
/// ```
pub fn classNames(class_names : Array[String]) -> String {
  ffi_classNames(class_names.map(fn(s) { @core.any(s) }))
}

///|
/// Raw version - accepts strings, objects, arrays, and booleans
///
/// Example:
/// ```moonbit
/// let class_name = classNames_raw([@core.any("foo"), @core.any("bar")])
/// // => "foo bar"
/// ```
pub fn classNames_raw(args : Array[@core.Any]) -> String {
  ffi_classNames(args)
}

///|
/// Construct className string from an object mapping class names to booleans
///
/// Example:
/// ```moonbit
/// let obj = @core.new_object()
/// obj["active"] = @core.any(true)
/// obj["disabled"] = @core.any(false)
/// let class_name = classNames_obj(obj)
/// // => "active"
/// ```
pub fn classNames_obj(obj : @core.Any) -> String {
  ffi_classNames([obj])
}

///|
/// Construct className string combining strings and conditional object
///
/// Example:
/// ```moonbit
/// let obj = @core.new_object()
/// obj["active"] = @core.any(true)
/// let class_name = classNames_with("btn", obj)
/// // => "btn active"
/// ```
pub fn classNames_with(base : String, conditions : @core.Any) -> String {
  ffi_classNames([@core.any(base), conditions])
}
