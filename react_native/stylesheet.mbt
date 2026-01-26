///| StyleSheet API for React Native
/// https://reactnative.dev/docs/stylesheet

// ============================================================================
// StyleSheet FFI
// ============================================================================

///|
extern "js" fn ffi_stylesheet_create(styles : @core.Any) -> @core.Any =
  #| (styles) => require("react-native").StyleSheet.create(styles)

///|
extern "js" fn ffi_stylesheet_flatten(styles : @core.Any) -> @core.Any =
  #| (styles) => require("react-native").StyleSheet.flatten(styles)

///|
extern "js" fn ffi_stylesheet_absolute_fill() -> @core.Any =
  #| () => require("react-native").StyleSheet.absoluteFill

///|
extern "js" fn ffi_stylesheet_absolute_fill_object() -> @core.Any =
  #| () => require("react-native").StyleSheet.absoluteFillObject

///|
extern "js" fn ffi_stylesheet_hairline_width() -> Double =
  #| () => require("react-native").StyleSheet.hairlineWidth

// ============================================================================
// StyleSheet Module
// ============================================================================

///|
/// StyleSheet namespace type
pub struct StyleSheet {}

///|
/// StyleSheet.create - Create optimized style objects
pub fn StyleSheet::create(
  styles : Map[String, Map[String, @core.Any]],
) -> Map[String, Style] {
  let styles_obj = @core.new_object()
  for name, props in styles {
    let style_obj = @core.new_object()
    for key, value in props {
      style_obj._set(key, value)
    }
    styles_obj._set(name, style_obj)
  }
  let result = ffi_stylesheet_create(styles_obj)
  let output : Map[String, Style] = {}
  for name, _ in styles {
    output[name] = Style::from_any(result[name])
  }
  output
}

///|
/// StyleSheet.flatten - Flatten an array of styles into a single style object
pub fn StyleSheet::flatten(styles : Array[Style]) -> Style {
  let arr : @core.Any = @core.any(styles.map(Style::as_any))
  Style::from_any(ffi_stylesheet_flatten(arr))
}

///|
/// StyleSheet.absolute_fill - A registered style that fills the entire parent view
pub fn StyleSheet::absolute_fill() -> Style {
  Style::from_any(ffi_stylesheet_absolute_fill())
}

///|
/// StyleSheet.absolute_fill_object - An object containing the style properties for absoluteFill
pub fn StyleSheet::absolute_fill_object() -> Style {
  Style::from_any(ffi_stylesheet_absolute_fill_object())
}

///|
/// StyleSheet.hairline_width - The smallest logical pixel width (1px on most devices)
pub fn StyleSheet::hairline_width() -> Double {
  ffi_stylesheet_hairline_width()
}

///|
/// StyleSheet.create_typed - Create optimized style objects with type-safe Style inputs
/// Use this with the style() function for type-safe style definitions
pub fn StyleSheet::create_typed(
  styles : Map[String, Style],
) -> Map[String, Style] {
  let styles_obj = @core.new_object()
  for name, style in styles {
    styles_obj._set(name, style.as_any())
  }
  let result = ffi_stylesheet_create(styles_obj)
  let output : Map[String, Style] = {}
  for name, _ in styles {
    output[name] = Style::from_any(result[name])
  }
  output
}
