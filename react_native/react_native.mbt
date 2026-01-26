///| React Native FFI bindings
/// https://www.npmjs.com/package/react-native

// ============================================================================
// Types
// ============================================================================

///|
/// Style type for React Native components
pub struct Style {
  priv inner : @core.Any
}

///|
pub fn Style::as_any(self : Style) -> @core.Any {
  self.inner
}

///|
/// Create Style from @core.Any
pub fn Style::from_any(any : @core.Any) -> Style {
  { inner: any }
}

///|
/// StyleProp - can be a single style, array of styles, or undefined
pub struct StyleProp {
  priv inner : @core.Any
}

///|
pub fn StyleProp::as_any(self : StyleProp) -> @core.Any {
  self.inner
}

///|
/// Create StyleProp from Style
pub fn StyleProp::from_style(style : Style) -> StyleProp {
  { inner: style.as_any() }
}

///|
/// Create StyleProp from array of Styles
pub fn StyleProp::from_styles(styles : Array[Style]) -> StyleProp {
  { inner: @core.any(styles.map(Style::as_any)) }
}

///|
/// Native event type
#external
pub type NativeEvent

///|
pub fn NativeEvent::as_any(self : NativeEvent) -> @core.Any = "%identity"

///|
/// GestureResponderEvent for touch handling
#external
pub type GestureResponderEvent

///|
pub fn GestureResponderEvent::as_any(self : GestureResponderEvent) -> @core.Any = "%identity"

///|
/// Get nativeEvent from GestureResponderEvent
pub fn GestureResponderEvent::native_event(
  self : GestureResponderEvent,
) -> NativeEvent {
  self.as_any()["nativeEvent"].cast()
}

///|
/// LayoutChangeEvent
#external
pub type LayoutChangeEvent

///|
pub fn LayoutChangeEvent::as_any(self : LayoutChangeEvent) -> @core.Any = "%identity"

///|
/// Get layout from LayoutChangeEvent
pub fn LayoutChangeEvent::layout(self : LayoutChangeEvent) -> Layout {
  self.as_any()["nativeEvent"]["layout"].cast()
}

///|
/// Layout information
#external
pub type Layout

///|
pub fn Layout::as_any(self : Layout) -> @core.Any = "%identity"

///|
pub fn Layout::x(self : Layout) -> Double {
  self.as_any()["x"].cast()
}

///|
pub fn Layout::y(self : Layout) -> Double {
  self.as_any()["y"].cast()
}

///|
pub fn Layout::width(self : Layout) -> Double {
  self.as_any()["width"].cast()
}

///|
pub fn Layout::height(self : Layout) -> Double {
  self.as_any()["height"].cast()
}

///|
/// NativeScrollEvent
#external
pub type NativeScrollEvent

///|
pub fn NativeScrollEvent::as_any(self : NativeScrollEvent) -> @core.Any = "%identity"

///|
pub fn NativeScrollEvent::content_offset(
  self : NativeScrollEvent,
) -> (Double, Double) {
  let offset = self.as_any()["contentOffset"]
  (offset["x"].cast(), offset["y"].cast())
}

///|
pub fn NativeScrollEvent::content_size(
  self : NativeScrollEvent,
) -> (Double, Double) {
  let size = self.as_any()["contentSize"]
  (size["width"].cast(), size["height"].cast())
}

///|
/// ScrollEvent wrapper
#external
pub type ScrollEvent

///|
pub fn ScrollEvent::as_any(self : ScrollEvent) -> @core.Any = "%identity"

///|
pub fn ScrollEvent::native_event(self : ScrollEvent) -> NativeScrollEvent {
  self.as_any()["nativeEvent"].cast()
}

///|
/// TextInputChangeEvent
#external
pub type TextInputChangeEvent

///|
pub fn TextInputChangeEvent::as_any(self : TextInputChangeEvent) -> @core.Any = "%identity"

///|
pub fn TextInputChangeEvent::text(self : TextInputChangeEvent) -> String {
  self.as_any()["nativeEvent"]["text"].cast()
}

///|
/// TextInputSubmitEvent
#external
pub type TextInputSubmitEvent

///|
pub fn TextInputSubmitEvent::as_any(self : TextInputSubmitEvent) -> @core.Any = "%identity"

///|
pub fn TextInputSubmitEvent::text(self : TextInputSubmitEvent) -> String {
  self.as_any()["nativeEvent"]["text"].cast()
}

// ============================================================================
// Event Handler Type Aliases (for documentation purposes)
// ============================================================================
// PressEventHandler = (GestureResponderEvent) -> Unit
// LayoutEventHandler = (LayoutChangeEvent) -> Unit
// ScrollEventHandler = (ScrollEvent) -> Unit
// TextChangeHandler = (String) -> Unit
// TextSubmitHandler = (TextInputSubmitEvent) -> Unit

// ============================================================================
// Component Imports (using inline JS for class/component imports)
// ============================================================================

///|
extern "js" fn ffi_view() -> @core.Any =
  #| () => require("react-native").View

///|
extern "js" fn ffi_text() -> @core.Any =
  #| () => require("react-native").Text

///|
extern "js" fn ffi_image() -> @core.Any =
  #| () => require("react-native").Image

///|
extern "js" fn ffi_scroll_view() -> @core.Any =
  #| () => require("react-native").ScrollView

///|
extern "js" fn ffi_flat_list() -> @core.Any =
  #| () => require("react-native").FlatList

///|
extern "js" fn ffi_section_list() -> @core.Any =
  #| () => require("react-native").SectionList

///|
extern "js" fn ffi_touchable_opacity() -> @core.Any =
  #| () => require("react-native").TouchableOpacity

///|
extern "js" fn ffi_touchable_highlight() -> @core.Any =
  #| () => require("react-native").TouchableHighlight

///|
extern "js" fn ffi_touchable_without_feedback() -> @core.Any =
  #| () => require("react-native").TouchableWithoutFeedback

///|
extern "js" fn ffi_pressable() -> @core.Any =
  #| () => require("react-native").Pressable

///|
extern "js" fn ffi_text_input() -> @core.Any =
  #| () => require("react-native").TextInput

///|
extern "js" fn ffi_button() -> @core.Any =
  #| () => require("react-native").Button

///|
extern "js" fn ffi_switch() -> @core.Any =
  #| () => require("react-native").Switch

///|
extern "js" fn ffi_activity_indicator() -> @core.Any =
  #| () => require("react-native").ActivityIndicator

///|
extern "js" fn ffi_modal() -> @core.Any =
  #| () => require("react-native").Modal

///|
extern "js" fn ffi_safe_area_view() -> @core.Any =
  #| () => require("react-native").SafeAreaView

///|
extern "js" fn ffi_status_bar() -> @core.Any =
  #| () => require("react-native").StatusBar

///|
extern "js" fn ffi_keyboard_avoiding_view() -> @core.Any =
  #| () => require("react-native").KeyboardAvoidingView

///|
extern "js" fn ffi_refresh_control() -> @core.Any =
  #| () => require("react-native").RefreshControl

///|
extern "js" fn ffi_virtual_list() -> @core.Any =
  #| () => require("react-native").VirtualizedList

///|
extern "js" fn ffi_image_background() -> @core.Any =
  #| () => require("react-native").ImageBackground

///|
extern "js" fn ffi_touchable_native_feedback() -> @core.Any =
  #| () => require("react-native").TouchableNativeFeedback

///|
extern "js" fn ffi_drawer_layout_android() -> @core.Any =
  #| () => require("react-native").DrawerLayoutAndroid

///|
extern "js" fn ffi_input_accessory_view() -> @core.Any =
  #| () => require("react-native").InputAccessoryView

// ============================================================================
// Helper function
// ============================================================================

///|
fn create_element(
  component : @core.Any,
  props : @core.Any,
  children? : Array[&@react.ReactNode] = [],
  key? : String? = None,
) -> @react.Element {
  let children_count = children.length()
  if children_count > 0 {
    if children_count == 1 {
      props._set("children", children[0].to_react_node())
    } else {
      let children_js : @core.Any = @core.any(children.map(_.to_react_node()))
      props._set("children", children_js)
    }
  }
  @react.createElementWithKey(component, props, key, children_count~)
}

///|
fn set_style(props : @core.Any, style : StyleProp?) -> Unit {
  if style is Some(s) {
    props._set("style", s.as_any())
  }
}

///|
fn set_test_id(props : @core.Any, test_id : String?) -> Unit {
  if test_id is Some(id) {
    props._set("testID", @core.any(id))
  }
}

// ============================================================================
// View Component
// ============================================================================

///|
/// View - The most fundamental component for building UI
pub fn view(
  children? : Array[&@react.ReactNode] = [],
  style? : StyleProp? = None,
  on_layout? : ((LayoutChangeEvent) -> Unit)? = None,
  on_press? : ((GestureResponderEvent) -> Unit)? = None,
  accessible? : Bool? = None,
  accessibility_label? : String? = None,
  test_id? : String? = None,
  key? : String? = None,
) -> @react.Element {
  let props = @core.new_object()
  set_style(props, style)
  set_test_id(props, test_id)
  if on_layout is Some(f) {
    props._set("onLayout", @js.from_fn1(f))
  }
  if on_press is Some(f) {
    props._set("onPress", @js.from_fn1(f))
  }
  if accessible is Some(v) {
    props._set("accessible", @core.any(v))
  }
  if accessibility_label is Some(v) {
    props._set("accessibilityLabel", @core.any(v))
  }
  create_element(ffi_view(), props, children~, key~)
}

// ============================================================================
// Text Component
// ============================================================================

///|
/// Text - A component for displaying text
pub fn text(
  children? : Array[&@react.ReactNode] = [],
  style? : StyleProp? = None,
  number_of_lines? : Int? = None,
  ellipsize_mode? : String? = None,
  selectable? : Bool? = None,
  on_press? : ((GestureResponderEvent) -> Unit)? = None,
  on_long_press? : ((GestureResponderEvent) -> Unit)? = None,
  accessible? : Bool? = None,
  accessibility_label? : String? = None,
  test_id? : String? = None,
  key? : String? = None,
) -> @react.Element {
  let props = @core.new_object()
  set_style(props, style)
  set_test_id(props, test_id)
  if number_of_lines is Some(n) {
    props._set("numberOfLines", @core.any(n))
  }
  if ellipsize_mode is Some(mode) {
    props._set("ellipsizeMode", @core.any(mode))
  }
  if selectable is Some(v) {
    props._set("selectable", @core.any(v))
  }
  if on_press is Some(f) {
    props._set("onPress", @js.from_fn1(f))
  }
  if on_long_press is Some(f) {
    props._set("onLongPress", @js.from_fn1(f))
  }
  if accessible is Some(v) {
    props._set("accessible", @core.any(v))
  }
  if accessibility_label is Some(v) {
    props._set("accessibilityLabel", @core.any(v))
  }
  create_element(ffi_text(), props, children~, key~)
}

// ============================================================================
// Image Component
// ============================================================================

///|
/// ImageSource type for Image component
pub struct ImageSource {
  priv inner : @core.Any
}

///|
pub fn ImageSource::as_any(self : ImageSource) -> @core.Any {
  self.inner
}

///|
pub fn ImageSource::uri(
  uri : String,
  width? : Int? = None,
  height? : Int? = None,
) -> ImageSource {
  let obj = @core.new_object()
  obj._set("uri", @core.any(uri))
  if width is Some(w) {
    obj._set("width", @core.any(w))
  }
  if height is Some(h) {
    obj._set("height", @core.any(h))
  }
  { inner: obj }
}

///|
pub fn ImageSource::from_require(id : Int) -> ImageSource {
  { inner: @core.any(id) }
}

///|
/// Image - A component for displaying images
pub fn image(
  source~ : ImageSource,
  style? : StyleProp? = None,
  resize_mode? : String? = None,
  on_load? : (() -> Unit)? = None,
  on_error? : (() -> Unit)? = None,
  on_load_start? : (() -> Unit)? = None,
  on_load_end? : (() -> Unit)? = None,
  accessible? : Bool? = None,
  accessibility_label? : String? = None,
  test_id? : String? = None,
  key? : String? = None,
) -> @react.Element {
  let props = @core.new_object()
  props._set("source", source.as_any())
  set_style(props, style)
  set_test_id(props, test_id)
  if resize_mode is Some(mode) {
    props._set("resizeMode", @core.any(mode))
  }
  if on_load is Some(f) {
    props._set("onLoad", @js.from_fn0(f))
  }
  if on_error is Some(f) {
    props._set("onError", @js.from_fn0(f))
  }
  if on_load_start is Some(f) {
    props._set("onLoadStart", @js.from_fn0(f))
  }
  if on_load_end is Some(f) {
    props._set("onLoadEnd", @js.from_fn0(f))
  }
  if accessible is Some(v) {
    props._set("accessible", @core.any(v))
  }
  if accessibility_label is Some(v) {
    props._set("accessibilityLabel", @core.any(v))
  }
  create_element(ffi_image(), props, key~)
}

// ============================================================================
// ScrollView Component
// ============================================================================

///|
/// ScrollView - Scrollable container component
pub fn scroll_view(
  children? : Array[&@react.ReactNode] = [],
  style? : StyleProp? = None,
  content_container_style? : StyleProp? = None,
  horizontal? : Bool? = None,
  shows_vertical_scroll_indicator? : Bool? = None,
  shows_horizontal_scroll_indicator? : Bool? = None,
  scroll_enabled? : Bool? = None,
  paging_enabled? : Bool? = None,
  bounces? : Bool? = None,
  keyboard_should_persist_taps? : String? = None,
  keyboard_dismiss_mode? : String? = None,
  on_scroll? : ((ScrollEvent) -> Unit)? = None,
  on_scroll_begin_drag? : ((ScrollEvent) -> Unit)? = None,
  on_scroll_end_drag? : ((ScrollEvent) -> Unit)? = None,
  on_momentum_scroll_begin? : ((ScrollEvent) -> Unit)? = None,
  on_momentum_scroll_end? : ((ScrollEvent) -> Unit)? = None,
  refresh_control? : @react.Element? = None,
  test_id? : String? = None,
  key? : String? = None,
) -> @react.Element {
  let props = @core.new_object()
  set_style(props, style)
  set_test_id(props, test_id)
  if content_container_style is Some(s) {
    props._set("contentContainerStyle", s.as_any())
  }
  if horizontal is Some(v) {
    props._set("horizontal", @core.any(v))
  }
  if shows_vertical_scroll_indicator is Some(v) {
    props._set("showsVerticalScrollIndicator", @core.any(v))
  }
  if shows_horizontal_scroll_indicator is Some(v) {
    props._set("showsHorizontalScrollIndicator", @core.any(v))
  }
  if scroll_enabled is Some(v) {
    props._set("scrollEnabled", @core.any(v))
  }
  if paging_enabled is Some(v) {
    props._set("pagingEnabled", @core.any(v))
  }
  if bounces is Some(v) {
    props._set("bounces", @core.any(v))
  }
  if keyboard_should_persist_taps is Some(v) {
    props._set("keyboardShouldPersistTaps", @core.any(v))
  }
  if keyboard_dismiss_mode is Some(v) {
    props._set("keyboardDismissMode", @core.any(v))
  }
  if on_scroll is Some(f) {
    props._set("onScroll", @js.from_fn1(f))
  }
  if on_scroll_begin_drag is Some(f) {
    props._set("onScrollBeginDrag", @js.from_fn1(f))
  }
  if on_scroll_end_drag is Some(f) {
    props._set("onScrollEndDrag", @js.from_fn1(f))
  }
  if on_momentum_scroll_begin is Some(f) {
    props._set("onMomentumScrollBegin", @js.from_fn1(f))
  }
  if on_momentum_scroll_end is Some(f) {
    props._set("onMomentumScrollEnd", @js.from_fn1(f))
  }
  if refresh_control is Some(rc) {
    props._set("refreshControl", rc.as_any())
  }
  create_element(ffi_scroll_view(), props, children~, key~)
}

// ============================================================================
// TouchableOpacity Component
// ============================================================================

///|
/// TouchableOpacity - Touchable wrapper with opacity feedback
pub fn touchable_opacity(
  children? : Array[&@react.ReactNode] = [],
  style? : StyleProp? = None,
  on_press? : ((GestureResponderEvent) -> Unit)? = None,
  on_long_press? : ((GestureResponderEvent) -> Unit)? = None,
  on_press_in? : ((GestureResponderEvent) -> Unit)? = None,
  on_press_out? : ((GestureResponderEvent) -> Unit)? = None,
  active_opacity? : Double? = None,
  disabled? : Bool? = None,
  accessible? : Bool? = None,
  accessibility_label? : String? = None,
  test_id? : String? = None,
  key? : String? = None,
) -> @react.Element {
  let props = @core.new_object()
  set_style(props, style)
  set_test_id(props, test_id)
  if on_press is Some(f) {
    props._set("onPress", @js.from_fn1(f))
  }
  if on_long_press is Some(f) {
    props._set("onLongPress", @js.from_fn1(f))
  }
  if on_press_in is Some(f) {
    props._set("onPressIn", @js.from_fn1(f))
  }
  if on_press_out is Some(f) {
    props._set("onPressOut", @js.from_fn1(f))
  }
  if active_opacity is Some(v) {
    props._set("activeOpacity", @core.any(v))
  }
  if disabled is Some(v) {
    props._set("disabled", @core.any(v))
  }
  if accessible is Some(v) {
    props._set("accessible", @core.any(v))
  }
  if accessibility_label is Some(v) {
    props._set("accessibilityLabel", @core.any(v))
  }
  create_element(ffi_touchable_opacity(), props, children~, key~)
}

// ============================================================================
// Pressable Component
// ============================================================================

///|
/// Pressable - Core component for handling press interactions
pub fn pressable(
  children? : Array[&@react.ReactNode] = [],
  style? : StyleProp? = None,
  on_press? : ((GestureResponderEvent) -> Unit)? = None,
  on_long_press? : ((GestureResponderEvent) -> Unit)? = None,
  on_press_in? : ((GestureResponderEvent) -> Unit)? = None,
  on_press_out? : ((GestureResponderEvent) -> Unit)? = None,
  disabled? : Bool? = None,
  accessible? : Bool? = None,
  accessibility_label? : String? = None,
  test_id? : String? = None,
  key? : String? = None,
) -> @react.Element {
  let props = @core.new_object()
  set_style(props, style)
  set_test_id(props, test_id)
  if on_press is Some(f) {
    props._set("onPress", @js.from_fn1(f))
  }
  if on_long_press is Some(f) {
    props._set("onLongPress", @js.from_fn1(f))
  }
  if on_press_in is Some(f) {
    props._set("onPressIn", @js.from_fn1(f))
  }
  if on_press_out is Some(f) {
    props._set("onPressOut", @js.from_fn1(f))
  }
  if disabled is Some(v) {
    props._set("disabled", @core.any(v))
  }
  if accessible is Some(v) {
    props._set("accessible", @core.any(v))
  }
  if accessibility_label is Some(v) {
    props._set("accessibilityLabel", @core.any(v))
  }
  create_element(ffi_pressable(), props, children~, key~)
}

// ============================================================================
// TextInput Component
// ============================================================================

///|
/// TextInput - Component for text input
pub fn text_input(
  style? : StyleProp? = None,
  value? : String? = None,
  default_value? : String? = None,
  placeholder? : String? = None,
  placeholder_text_color? : String? = None,
  keyboard_type? : String? = None,
  return_key_type? : String? = None,
  auto_capitalize? : String? = None,
  auto_correct? : Bool? = None,
  auto_focus? : Bool? = None,
  secure_text_entry? : Bool? = None,
  multiline? : Bool? = None,
  number_of_lines? : Int? = None,
  max_length? : Int? = None,
  editable? : Bool? = None,
  on_change_text? : ((String) -> Unit)? = None,
  on_submit_editing? : ((TextInputSubmitEvent) -> Unit)? = None,
  on_focus? : (() -> Unit)? = None,
  on_blur? : (() -> Unit)? = None,
  accessible? : Bool? = None,
  accessibility_label? : String? = None,
  test_id? : String? = None,
  key? : String? = None,
) -> @react.Element {
  let props = @core.new_object()
  set_style(props, style)
  set_test_id(props, test_id)
  if value is Some(v) {
    props._set("value", @core.any(v))
  }
  if default_value is Some(v) {
    props._set("defaultValue", @core.any(v))
  }
  if placeholder is Some(v) {
    props._set("placeholder", @core.any(v))
  }
  if placeholder_text_color is Some(v) {
    props._set("placeholderTextColor", @core.any(v))
  }
  if keyboard_type is Some(v) {
    props._set("keyboardType", @core.any(v))
  }
  if return_key_type is Some(v) {
    props._set("returnKeyType", @core.any(v))
  }
  if auto_capitalize is Some(v) {
    props._set("autoCapitalize", @core.any(v))
  }
  if auto_correct is Some(v) {
    props._set("autoCorrect", @core.any(v))
  }
  if auto_focus is Some(v) {
    props._set("autoFocus", @core.any(v))
  }
  if secure_text_entry is Some(v) {
    props._set("secureTextEntry", @core.any(v))
  }
  if multiline is Some(v) {
    props._set("multiline", @core.any(v))
  }
  if number_of_lines is Some(n) {
    props._set("numberOfLines", @core.any(n))
  }
  if max_length is Some(n) {
    props._set("maxLength", @core.any(n))
  }
  if editable is Some(v) {
    props._set("editable", @core.any(v))
  }
  if on_change_text is Some(f) {
    props._set("onChangeText", @js.from_fn1(f))
  }
  if on_submit_editing is Some(f) {
    props._set("onSubmitEditing", @js.from_fn1(f))
  }
  if on_focus is Some(f) {
    props._set("onFocus", @js.from_fn0(f))
  }
  if on_blur is Some(f) {
    props._set("onBlur", @js.from_fn0(f))
  }
  if accessible is Some(v) {
    props._set("accessible", @core.any(v))
  }
  if accessibility_label is Some(v) {
    props._set("accessibilityLabel", @core.any(v))
  }
  create_element(ffi_text_input(), props, key~)
}

// ============================================================================
// Button Component
// ============================================================================

///|
/// Button - A basic button component
pub fn button(
  title~ : String,
  on_press? : (() -> Unit)? = None,
  color? : String? = None,
  disabled? : Bool? = None,
  accessible? : Bool? = None,
  accessibility_label? : String? = None,
  test_id? : String? = None,
  key? : String? = None,
) -> @react.Element {
  let props = @core.new_object()
  props._set("title", @core.any(title))
  set_test_id(props, test_id)
  if on_press is Some(f) {
    props._set("onPress", @js.from_fn0(f))
  }
  if color is Some(c) {
    props._set("color", @core.any(c))
  }
  if disabled is Some(v) {
    props._set("disabled", @core.any(v))
  }
  if accessible is Some(v) {
    props._set("accessible", @core.any(v))
  }
  if accessibility_label is Some(v) {
    props._set("accessibilityLabel", @core.any(v))
  }
  create_element(ffi_button(), props, key~)
}

// ============================================================================
// Switch Component
// ============================================================================

///|
/// Switch - A toggle switch component
pub fn switch_(
  value? : Bool? = None,
  on_value_change? : ((Bool) -> Unit)? = None,
  disabled? : Bool? = None,
  track_color? : (String, String)? = None,
  thumb_color? : String? = None,
  ios_background_color? : String? = None,
  accessible? : Bool? = None,
  accessibility_label? : String? = None,
  test_id? : String? = None,
  key? : String? = None,
) -> @react.Element {
  let props = @core.new_object()
  set_test_id(props, test_id)
  if value is Some(v) {
    props._set("value", @core.any(v))
  }
  if on_value_change is Some(f) {
    props._set("onValueChange", @js.from_fn1(f))
  }
  if disabled is Some(v) {
    props._set("disabled", @core.any(v))
  }
  if track_color is Some((false_color, true_color)) {
    let track_obj = @core.new_object()
    track_obj._set("false", @core.any(false_color))
    track_obj._set("true", @core.any(true_color))
    props._set("trackColor", track_obj)
  }
  if thumb_color is Some(c) {
    props._set("thumbColor", @core.any(c))
  }
  if ios_background_color is Some(c) {
    props._set("ios_backgroundColor", @core.any(c))
  }
  if accessible is Some(v) {
    props._set("accessible", @core.any(v))
  }
  if accessibility_label is Some(v) {
    props._set("accessibilityLabel", @core.any(v))
  }
  create_element(ffi_switch(), props, key~)
}

// ============================================================================
// ActivityIndicator Component
// ============================================================================

///|
/// ActivityIndicator - Displays a circular loading indicator
pub fn activity_indicator(
  animating? : Bool? = None,
  color? : String? = None,
  size? : String? = None,
  hidesWhenStopped? : Bool? = None,
  accessible? : Bool? = None,
  accessibility_label? : String? = None,
  test_id? : String? = None,
  key? : String? = None,
) -> @react.Element {
  let props = @core.new_object()
  set_test_id(props, test_id)
  if animating is Some(v) {
    props._set("animating", @core.any(v))
  }
  if color is Some(c) {
    props._set("color", @core.any(c))
  }
  if size is Some(s) {
    props._set("size", @core.any(s))
  }
  if hidesWhenStopped is Some(v) {
    props._set("hidesWhenStopped", @core.any(v))
  }
  if accessible is Some(v) {
    props._set("accessible", @core.any(v))
  }
  if accessibility_label is Some(v) {
    props._set("accessibilityLabel", @core.any(v))
  }
  create_element(ffi_activity_indicator(), props, key~)
}

// ============================================================================
// Modal Component
// ============================================================================

///|
/// Modal - A component to present content above an enclosing view
pub fn modal(
  children? : Array[&@react.ReactNode] = [],
  visible? : Bool? = None,
  animation_type? : String? = None,
  transparent? : Bool? = None,
  presentation_style? : String? = None,
  on_request_close? : (() -> Unit)? = None,
  on_show? : (() -> Unit)? = None,
  on_dismiss? : (() -> Unit)? = None,
  status_bar_translucent? : Bool? = None,
  test_id? : String? = None,
  key? : String? = None,
) -> @react.Element {
  let props = @core.new_object()
  set_test_id(props, test_id)
  if visible is Some(v) {
    props._set("visible", @core.any(v))
  }
  if animation_type is Some(t) {
    props._set("animationType", @core.any(t))
  }
  if transparent is Some(v) {
    props._set("transparent", @core.any(v))
  }
  if presentation_style is Some(s) {
    props._set("presentationStyle", @core.any(s))
  }
  if on_request_close is Some(f) {
    props._set("onRequestClose", @js.from_fn0(f))
  }
  if on_show is Some(f) {
    props._set("onShow", @js.from_fn0(f))
  }
  if on_dismiss is Some(f) {
    props._set("onDismiss", @js.from_fn0(f))
  }
  if status_bar_translucent is Some(v) {
    props._set("statusBarTranslucent", @core.any(v))
  }
  create_element(ffi_modal(), props, children~, key~)
}

// ============================================================================
// SafeAreaView Component
// ============================================================================

///|
/// SafeAreaView - Renders content within the safe area boundaries
pub fn safe_area_view(
  children? : Array[&@react.ReactNode] = [],
  style? : StyleProp? = None,
  test_id? : String? = None,
  key? : String? = None,
) -> @react.Element {
  let props = @core.new_object()
  set_style(props, style)
  set_test_id(props, test_id)
  create_element(ffi_safe_area_view(), props, children~, key~)
}

// ============================================================================
// StatusBar Component
// ============================================================================

///|
/// StatusBar - Component to control the app status bar
pub fn status_bar(
  bar_style? : String? = None,
  hidden? : Bool? = None,
  background_color? : String? = None,
  translucent? : Bool? = None,
  animated? : Bool? = None,
  key? : String? = None,
) -> @react.Element {
  let props = @core.new_object()
  if bar_style is Some(s) {
    props._set("barStyle", @core.any(s))
  }
  if hidden is Some(v) {
    props._set("hidden", @core.any(v))
  }
  if background_color is Some(c) {
    props._set("backgroundColor", @core.any(c))
  }
  if translucent is Some(v) {
    props._set("translucent", @core.any(v))
  }
  if animated is Some(v) {
    props._set("animated", @core.any(v))
  }
  create_element(ffi_status_bar(), props, key~)
}

// ============================================================================
// KeyboardAvoidingView Component
// ============================================================================

///|
/// KeyboardAvoidingView - View that moves out of the way of the keyboard
pub fn keyboard_avoiding_view(
  children? : Array[&@react.ReactNode] = [],
  style? : StyleProp? = None,
  behavior? : String? = None,
  keyboard_vertical_offset? : Int? = None,
  enabled? : Bool? = None,
  test_id? : String? = None,
  key? : String? = None,
) -> @react.Element {
  let props = @core.new_object()
  set_style(props, style)
  set_test_id(props, test_id)
  if behavior is Some(b) {
    props._set("behavior", @core.any(b))
  }
  if keyboard_vertical_offset is Some(o) {
    props._set("keyboardVerticalOffset", @core.any(o))
  }
  if enabled is Some(v) {
    props._set("enabled", @core.any(v))
  }
  create_element(ffi_keyboard_avoiding_view(), props, children~, key~)
}

// ============================================================================
// RefreshControl Component
// ============================================================================

///|
/// RefreshControl - Used inside ScrollView for pull-to-refresh
pub fn refresh_control(
  refreshing~ : Bool,
  on_refresh? : (() -> Unit)? = None,
  colors? : Array[String]? = None,
  progress_background_color? : String? = None,
  tint_color? : String? = None,
  title? : String? = None,
  title_color? : String? = None,
  key? : String? = None,
) -> @react.Element {
  let props = @core.new_object()
  props._set("refreshing", @core.any(refreshing))
  if on_refresh is Some(f) {
    props._set("onRefresh", @js.from_fn0(f))
  }
  if colors is Some(c) {
    props._set("colors", @core.any(c))
  }
  if progress_background_color is Some(c) {
    props._set("progressBackgroundColor", @core.any(c))
  }
  if tint_color is Some(c) {
    props._set("tintColor", @core.any(c))
  }
  if title is Some(t) {
    props._set("title", @core.any(t))
  }
  if title_color is Some(c) {
    props._set("titleColor", @core.any(c))
  }
  create_element(ffi_refresh_control(), props, key~)
}

// ============================================================================
// TouchableHighlight Component
// ============================================================================

///|
/// TouchableHighlight - Touchable wrapper with underlay color feedback
pub fn touchable_highlight(
  children? : Array[&@react.ReactNode] = [],
  style? : StyleProp? = None,
  on_press? : ((GestureResponderEvent) -> Unit)? = None,
  on_long_press? : ((GestureResponderEvent) -> Unit)? = None,
  on_press_in? : ((GestureResponderEvent) -> Unit)? = None,
  on_press_out? : ((GestureResponderEvent) -> Unit)? = None,
  active_opacity? : Double? = None,
  underlay_color? : String? = None,
  on_hide_underlay? : (() -> Unit)? = None,
  on_show_underlay? : (() -> Unit)? = None,
  disabled? : Bool? = None,
  accessible? : Bool? = None,
  accessibility_label? : String? = None,
  test_id? : String? = None,
  key? : String? = None,
) -> @react.Element {
  let props = @core.new_object()
  set_style(props, style)
  set_test_id(props, test_id)
  if on_press is Some(f) {
    props._set("onPress", @js.from_fn1(f))
  }
  if on_long_press is Some(f) {
    props._set("onLongPress", @js.from_fn1(f))
  }
  if on_press_in is Some(f) {
    props._set("onPressIn", @js.from_fn1(f))
  }
  if on_press_out is Some(f) {
    props._set("onPressOut", @js.from_fn1(f))
  }
  if active_opacity is Some(v) {
    props._set("activeOpacity", @core.any(v))
  }
  if underlay_color is Some(c) {
    props._set("underlayColor", @core.any(c))
  }
  if on_hide_underlay is Some(f) {
    props._set("onHideUnderlay", @js.from_fn0(f))
  }
  if on_show_underlay is Some(f) {
    props._set("onShowUnderlay", @js.from_fn0(f))
  }
  if disabled is Some(v) {
    props._set("disabled", @core.any(v))
  }
  if accessible is Some(v) {
    props._set("accessible", @core.any(v))
  }
  if accessibility_label is Some(v) {
    props._set("accessibilityLabel", @core.any(v))
  }
  create_element(ffi_touchable_highlight(), props, children~, key~)
}

// ============================================================================
// TouchableWithoutFeedback Component
// ============================================================================

///|
/// TouchableWithoutFeedback - Touchable wrapper with no visual feedback
pub fn touchable_without_feedback(
  children? : Array[&@react.ReactNode] = [],
  on_press? : ((GestureResponderEvent) -> Unit)? = None,
  on_long_press? : ((GestureResponderEvent) -> Unit)? = None,
  on_press_in? : ((GestureResponderEvent) -> Unit)? = None,
  on_press_out? : ((GestureResponderEvent) -> Unit)? = None,
  disabled? : Bool? = None,
  accessible? : Bool? = None,
  accessibility_label? : String? = None,
  test_id? : String? = None,
  key? : String? = None,
) -> @react.Element {
  let props = @core.new_object()
  set_test_id(props, test_id)
  if on_press is Some(f) {
    props._set("onPress", @js.from_fn1(f))
  }
  if on_long_press is Some(f) {
    props._set("onLongPress", @js.from_fn1(f))
  }
  if on_press_in is Some(f) {
    props._set("onPressIn", @js.from_fn1(f))
  }
  if on_press_out is Some(f) {
    props._set("onPressOut", @js.from_fn1(f))
  }
  if disabled is Some(v) {
    props._set("disabled", @core.any(v))
  }
  if accessible is Some(v) {
    props._set("accessible", @core.any(v))
  }
  if accessibility_label is Some(v) {
    props._set("accessibilityLabel", @core.any(v))
  }
  create_element(ffi_touchable_without_feedback(), props, children~, key~)
}

// ============================================================================
// ImageBackground Component
// ============================================================================

///|
/// ImageBackground - Container component with a background image
pub fn image_background(
  children? : Array[&@react.ReactNode] = [],
  source~ : ImageSource,
  style? : StyleProp? = None,
  image_style? : StyleProp? = None,
  resize_mode? : String? = None,
  on_load? : (() -> Unit)? = None,
  on_error? : (() -> Unit)? = None,
  on_load_start? : (() -> Unit)? = None,
  on_load_end? : (() -> Unit)? = None,
  accessible? : Bool? = None,
  accessibility_label? : String? = None,
  test_id? : String? = None,
  key? : String? = None,
) -> @react.Element {
  let props = @core.new_object()
  props._set("source", source.as_any())
  set_style(props, style)
  set_test_id(props, test_id)
  if image_style is Some(s) {
    props._set("imageStyle", s.as_any())
  }
  if resize_mode is Some(mode) {
    props._set("resizeMode", @core.any(mode))
  }
  if on_load is Some(f) {
    props._set("onLoad", @js.from_fn0(f))
  }
  if on_error is Some(f) {
    props._set("onError", @js.from_fn0(f))
  }
  if on_load_start is Some(f) {
    props._set("onLoadStart", @js.from_fn0(f))
  }
  if on_load_end is Some(f) {
    props._set("onLoadEnd", @js.from_fn0(f))
  }
  if accessible is Some(v) {
    props._set("accessible", @core.any(v))
  }
  if accessibility_label is Some(v) {
    props._set("accessibilityLabel", @core.any(v))
  }
  create_element(ffi_image_background(), props, children~, key~)
}

// ============================================================================
// TouchableNativeFeedback Component (Android only)
// ============================================================================

///|
/// TouchableNativeFeedback - Android native feedback touchable wrapper
pub fn touchable_native_feedback(
  children? : Array[&@react.ReactNode] = [],
  on_press? : ((GestureResponderEvent) -> Unit)? = None,
  on_long_press? : ((GestureResponderEvent) -> Unit)? = None,
  on_press_in? : ((GestureResponderEvent) -> Unit)? = None,
  on_press_out? : ((GestureResponderEvent) -> Unit)? = None,
  background? : @core.Any? = None,
  use_foreground? : Bool? = None,
  disabled? : Bool? = None,
  accessible? : Bool? = None,
  accessibility_label? : String? = None,
  test_id? : String? = None,
  key? : String? = None,
) -> @react.Element {
  let props = @core.new_object()
  set_test_id(props, test_id)
  if on_press is Some(f) {
    props._set("onPress", @js.from_fn1(f))
  }
  if on_long_press is Some(f) {
    props._set("onLongPress", @js.from_fn1(f))
  }
  if on_press_in is Some(f) {
    props._set("onPressIn", @js.from_fn1(f))
  }
  if on_press_out is Some(f) {
    props._set("onPressOut", @js.from_fn1(f))
  }
  if background is Some(b) {
    props._set("background", b)
  }
  if use_foreground is Some(v) {
    props._set("useForeground", @core.any(v))
  }
  if disabled is Some(v) {
    props._set("disabled", @core.any(v))
  }
  if accessible is Some(v) {
    props._set("accessible", @core.any(v))
  }
  if accessibility_label is Some(v) {
    props._set("accessibilityLabel", @core.any(v))
  }
  create_element(ffi_touchable_native_feedback(), props, children~, key~)
}

// ============================================================================
// DrawerLayoutAndroid Component (Android only)
// ============================================================================

///|
/// DrawerLayoutAndroid - Android drawer layout component
pub fn drawer_layout_android(
  children? : Array[&@react.ReactNode] = [],
  render_navigation_view~ : () -> @react.Element,
  drawer_width? : Int? = None,
  drawer_position? : String? = None,
  drawer_lock_mode? : String? = None,
  drawer_background_color? : String? = None,
  on_drawer_open? : (() -> Unit)? = None,
  on_drawer_close? : (() -> Unit)? = None,
  on_drawer_slide? : ((Double) -> Unit)? = None,
  on_drawer_state_changed? : ((String) -> Unit)? = None,
  keyboard_dismiss_mode? : String? = None,
  status_bar_background_color? : String? = None,
  test_id? : String? = None,
  key? : String? = None,
) -> @react.Element {
  let props = @core.new_object()
  set_test_id(props, test_id)
  props._set("renderNavigationView", @js.from_fn0(render_navigation_view))
  if drawer_width is Some(w) {
    props._set("drawerWidth", @core.any(w))
  }
  if drawer_position is Some(p) {
    props._set("drawerPosition", @core.any(p))
  }
  if drawer_lock_mode is Some(m) {
    props._set("drawerLockMode", @core.any(m))
  }
  if drawer_background_color is Some(c) {
    props._set("drawerBackgroundColor", @core.any(c))
  }
  if on_drawer_open is Some(f) {
    props._set("onDrawerOpen", @js.from_fn0(f))
  }
  if on_drawer_close is Some(f) {
    props._set("onDrawerClose", @js.from_fn0(f))
  }
  if on_drawer_slide is Some(f) {
    props._set("onDrawerSlide", @js.from_fn1(f))
  }
  if on_drawer_state_changed is Some(f) {
    props._set("onDrawerStateChanged", @js.from_fn1(f))
  }
  if keyboard_dismiss_mode is Some(m) {
    props._set("keyboardDismissMode", @core.any(m))
  }
  if status_bar_background_color is Some(c) {
    props._set("statusBarBackgroundColor", @core.any(c))
  }
  create_element(ffi_drawer_layout_android(), props, children~, key~)
}

// ============================================================================
// InputAccessoryView Component (iOS only)
// ============================================================================

///|
/// InputAccessoryView - iOS input accessory view component
pub fn input_accessory_view(
  children? : Array[&@react.ReactNode] = [],
  native_id~ : String,
  style? : StyleProp? = None,
  background_color? : String? = None,
  key? : String? = None,
) -> @react.Element {
  let props = @core.new_object()
  props._set("nativeID", @core.any(native_id))
  set_style(props, style)
  if background_color is Some(c) {
    props._set("backgroundColor", @core.any(c))
  }
  create_element(ffi_input_accessory_view(), props, children~, key~)
}
