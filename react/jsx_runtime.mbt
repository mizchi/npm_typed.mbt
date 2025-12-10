///|
/// JSX Runtime - Modern React JSX transform
/// See: https://reactjs.org/blog/2020/09/22/introducing-the-new-jsx-transform.html

///|
/// jsx - for elements with 0 or 1 child
#module("react/jsx-runtime")
extern "js" fn ffi_jsx(
  tag : @core.Any,
  props : @core.Any,
  key : @core.Any,
) -> @core.Any = "jsx"

///|
/// jsxs - for elements with multiple children
#module("react/jsx-runtime")
extern "js" fn ffi_jsxs(
  tag : @core.Any,
  props : @core.Any,
  key : @core.Any,
) -> @core.Any = "jsxs"

///|
/// Get Fragment - use the existing ffi_react_fragment from ffi.mbt
fn get_jsx_fragment() -> @core.Any {
  ffi_react_fragment()
}

///|
/// Create element using jsx runtime - automatically chooses jsx or jsxs
pub fn jsx(
  tag : @core.Any,
  children : Array[&ReactNode],
  props? : Map[String, @core.Any],
  style? : Map[String, String],
  ref_? : ReactRef[@dom.Element],
  key? : String,
) -> Element {
  let val = @core.new_object()
  if props is Some(props) {
    for k, v in props {
      val[k] = v
    }
  }
  if ref_ is Some(ref_) {
    val["ref"] = ref_.as_any()
  }
  if style is Some(style) {
    let style_obj = @core.new_object()
    for k, v in style {
      style_obj[k] = @core.any(v)
    }
    val["style"] = style_obj
  }
  // Set children in props - cache length to avoid multiple calls
  let children_count = children.length()
  if children_count > 0 {
    if children_count == 1 {
      // Single child - pass directly, not as array (no map needed)
      val["children"] = children[0].to_react_node()
    } else {
      // Multiple children - need array
      val["children"] = @core.any(children.map(_.to_react_node()))
    }
  }
  // key is passed as 3rd argument, not in props
  let key_val : @core.Any = match key {
    Some(k) => @core.any(k)
    None => @core.undefined()
  }
  // Choose jsx or jsxs based on children count
  if children_count <= 1 {
    ffi_jsx(tag, val, key_val).cast()
  } else {
    ffi_jsxs(tag, val, key_val).cast()
  }
}

///|
/// Create element with string tag using jsx runtime
pub fn jsx_tag(
  tag : String,
  children : Array[&ReactNode],
  props? : Map[String, @core.Any],
  style? : Map[String, String],
  ref_? : ReactRef[@dom.Element],
  key? : String,
) -> Element {
  jsx(@core.any(tag), children, props?, style?, ref_?, key?)
}

///|
/// Fragment using jsx runtime
pub fn jsx_fragment(children : Array[&ReactNode], key? : String) -> Element {
  let val = @core.new_object()
  let children_count = children.length()
  if children_count > 0 {
    if children_count == 1 {
      val["children"] = children[0].to_react_node()
    } else {
      val["children"] = @core.any(children.map(_.to_react_node()))
    }
  }
  let key_val : @core.Any = match key {
    Some(k) => @core.any(k)
    None => @core.undefined()
  }
  if children_count <= 1 {
    ffi_jsx(get_jsx_fragment(), val, key_val).cast()
  } else {
    ffi_jsxs(get_jsx_fragment(), val, key_val).cast()
  }
}
