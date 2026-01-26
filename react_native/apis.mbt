///| React Native APIs
/// Dimensions, Alert, Linking, Keyboard, AppState, PixelRatio, Appearance

// ============================================================================
// Dimensions API
// https://reactnative.dev/docs/dimensions
// ============================================================================

///|
extern "js" fn ffi_dimensions_get(dim : String) -> @core.Any =
  #| (dim) => require("react-native").Dimensions.get(dim)

///|
extern "js" fn ffi_dimensions_add_event_listener(
  event_type : String,
  handler : @core.Any,
) -> @core.Any =
  #| (type, handler) => require("react-native").Dimensions.addEventListener(type, handler)

///|
/// ScaledSize type for Dimensions
pub(all) struct ScaledSize {
  width : Double
  height : Double
  scale : Double
  font_scale : Double
}

///|
fn ScaledSize::from_any(any : @core.Any) -> ScaledSize {
  {
    width: any["width"].cast(),
    height: any["height"].cast(),
    scale: any["scale"].cast(),
    font_scale: any["fontScale"].cast(),
  }
}

///|
/// Get the dimensions of the window
pub fn get_window_dimensions() -> ScaledSize {
  ScaledSize::from_any(ffi_dimensions_get("window"))
}

///|
/// Get the dimensions of the screen
pub fn get_screen_dimensions() -> ScaledSize {
  ScaledSize::from_any(ffi_dimensions_get("screen"))
}

///|
/// Subscription type for event listeners
#external
pub type Subscription

///|
pub fn Subscription::as_any(self : Subscription) -> @core.Any = "%identity"

///|
extern "js" fn ffi_subscription_remove(sub : Subscription) -> Unit =
  #| (sub) => sub.remove()

///|
/// Remove the subscription
pub fn Subscription::remove(self : Subscription) -> Unit {
  ffi_subscription_remove(self)
}

///|
/// DimensionsChangeEvent
pub struct DimensionsChangeEvent {
  window : ScaledSize
  screen : ScaledSize
}

///|
/// Add an event listener for dimension changes
pub fn add_dimensions_change_listener(
  handler : (DimensionsChangeEvent) -> Unit,
) -> Subscription {
  let wrapped : (@core.Any) -> Unit = fn(event) {
    let change_event : DimensionsChangeEvent = {
      window: ScaledSize::from_any(event["window"]),
      screen: ScaledSize::from_any(event["screen"]),
    }
    handler(change_event)
  }
  ffi_dimensions_add_event_listener("change", @js.from_fn1(wrapped)).cast()
}

// ============================================================================
// Alert API
// https://reactnative.dev/docs/alert
// ============================================================================

///|
extern "js" fn ffi_alert(
  title : String,
  message : @core.Any,
  buttons : @core.Any,
  options : @core.Any,
) -> Unit =
  #| (title, message, buttons, options) => require("react-native").Alert.alert(title, message, buttons, options)

///|
extern "js" fn ffi_alert_prompt(
  title : String,
  message : @core.Any,
  callback : @core.Any,
  default_value : @core.Any,
  keyboard_type : @core.Any,
) -> Unit =
  #| (title, message, callback, defaultValue, keyboardType) => require("react-native").Alert.prompt(title, message, callback, "plain-text", defaultValue, keyboardType)

///|
/// Alert button style
pub(all) enum AlertButtonStyle {
  Default
  Cancel
  Destructive
}

///|
pub fn AlertButtonStyle::to_string(self : AlertButtonStyle) -> String {
  match self {
    Default => "default"
    Cancel => "cancel"
    Destructive => "destructive"
  }
}

///|
/// Alert button configuration
pub struct AlertButton {
  text : String
  on_press : (() -> Unit)?
  style : AlertButtonStyle
  is_preferred : Bool
}

///|
pub fn AlertButton::new(
  text~ : String,
  on_press? : (() -> Unit)? = None,
  style? : AlertButtonStyle = Default,
  is_preferred? : Bool = false,
) -> AlertButton {
  { text, on_press, style, is_preferred }
}

///|
pub fn AlertButton::to_any(self : AlertButton) -> @core.Any {
  let obj = @core.new_object()
  obj._set("text", @core.any(self.text))
  if self.on_press is Some(f) {
    obj._set("onPress", @js.from_fn0(f))
  }
  obj._set("style", @core.any(self.style.to_string()))
  if self.is_preferred {
    obj._set("isPreferred", @core.any(true))
  }
  obj
}

///|
/// Show an alert dialog
pub fn alert(
  title~ : String,
  message? : String? = None,
  buttons? : Array[AlertButton] = [],
  cancelable? : Bool = true,
  user_interface_style? : String? = None,
) -> Unit {
  let message_any : @core.Any = match message {
    Some(m) => @core.any(m)
    None => @core.undefined()
  }
  let buttons_any : @core.Any = if buttons.length() > 0 {
    @core.any(buttons.map(AlertButton::to_any))
  } else {
    @core.undefined()
  }
  let options = @core.new_object()
  options._set("cancelable", @core.any(cancelable))
  if user_interface_style is Some(style) {
    options._set("userInterfaceStyle", @core.any(style))
  }
  ffi_alert(title, message_any, buttons_any, options)
}

///|
/// Show a simple alert with just OK button
pub fn alert_simple(title : String, message? : String? = None) -> Unit {
  alert(title~, message~)
}

///|
/// Show an alert prompt (iOS only)
pub fn alert_prompt(
  title~ : String,
  message? : String? = None,
  callback? : ((String) -> Unit)? = None,
  default_value? : String? = None,
  keyboard_type? : String? = None,
) -> Unit {
  let message_any : @core.Any = match message {
    Some(m) => @core.any(m)
    None => @core.undefined()
  }
  let callback_any : @core.Any = match callback {
    Some(f) => @js.from_fn1(f)
    None => @core.undefined()
  }
  let default_value_any : @core.Any = match default_value {
    Some(v) => @core.any(v)
    None => @core.undefined()
  }
  let keyboard_type_any : @core.Any = match keyboard_type {
    Some(t) => @core.any(t)
    None => @core.undefined()
  }
  ffi_alert_prompt(
    title, message_any, callback_any, default_value_any, keyboard_type_any,
  )
}

// ============================================================================
// Linking API
// https://reactnative.dev/docs/linking
// ============================================================================

///|
extern "js" fn ffi_linking_open_url(url : String) -> @core.Promise[@core.Any] =
  #| (url) => require("react-native").Linking.openURL(url)

///|
extern "js" fn ffi_linking_can_open_url(
  url : String,
) -> @core.Promise[@core.Any] =
  #| (url) => require("react-native").Linking.canOpenURL(url)

///|
extern "js" fn ffi_linking_get_initial_url() -> @core.Promise[@core.Any] =
  #| () => require("react-native").Linking.getInitialURL()

///|
extern "js" fn ffi_linking_open_settings() -> @core.Promise[@core.Any] =
  #| () => require("react-native").Linking.openSettings()

///|
extern "js" fn ffi_linking_send_intent(
  action : String,
  extras : @core.Any,
) -> @core.Promise[@core.Any] =
  #| (action, extras) => require("react-native").Linking.sendIntent(action, extras)

///|
extern "js" fn ffi_linking_add_event_listener(
  event_type : String,
  handler : @core.Any,
) -> @core.Any =
  #| (type, handler) => require("react-native").Linking.addEventListener(type, handler)

///|
/// Open a URL
pub async fn open_url(url : String) -> Unit {
  let _ = ffi_linking_open_url(url).wait()

}

///|
/// Check if the app can open a URL
pub async fn can_open_url(url : String) -> Bool {
  ffi_linking_can_open_url(url).wait().cast()
}

///|
/// Get the URL that opened the app
pub async fn get_initial_url() -> String? {
  let result = ffi_linking_get_initial_url().wait()
  if @core.is_null(result) || @core.is_undefined(result) {
    None
  } else {
    Some(result.cast())
  }
}

///|
/// Open the device settings
pub async fn open_settings() -> Unit {
  let _ = ffi_linking_open_settings().wait()

}

///|
/// Send an Android intent (Android only)
pub async fn send_intent(
  action : String,
  extras? : Array[(String, @core.Any)] = [],
) -> Unit {
  let extras_array = @core.any(
    extras.map(fn(pair) {
      let obj = @core.new_object()
      obj._set("key", @core.any(pair.0))
      obj._set("value", pair.1)
      obj
    }),
  )
  let _ = ffi_linking_send_intent(action, extras_array).wait()

}

///|
/// URL event for Linking
pub struct URLEvent {
  url : String
}

///|
/// Add a listener for URL events
pub fn add_url_listener(handler : (URLEvent) -> Unit) -> Subscription {
  let wrapped : (@core.Any) -> Unit = fn(event) {
    let url_event : URLEvent = { url: event["url"].cast() }
    handler(url_event)
  }
  ffi_linking_add_event_listener("url", @js.from_fn1(wrapped)).cast()
}

// ============================================================================
// Keyboard API
// https://reactnative.dev/docs/keyboard
// ============================================================================

///|
extern "js" fn ffi_keyboard_dismiss() -> Unit =
  #| () => require("react-native").Keyboard.dismiss()

///|
extern "js" fn ffi_keyboard_add_listener(
  event_type : String,
  handler : @core.Any,
) -> @core.Any =
  #| (type, handler) => require("react-native").Keyboard.addListener(type, handler)

///|
extern "js" fn ffi_keyboard_schedule_layout_animation(
  event : @core.Any,
) -> Unit =
  #| (event) => require("react-native").Keyboard.scheduleLayoutAnimation(event)

///|
extern "js" fn ffi_keyboard_is_visible() -> Bool =
  #| () => require("react-native").Keyboard.isVisible()

///|
extern "js" fn ffi_keyboard_metrics() -> @core.Any =
  #| () => require("react-native").Keyboard.metrics()

///|
/// Keyboard event
pub struct KeyboardEvent {
  end_coordinates : KeyboardCoordinates
  start_coordinates : KeyboardCoordinates?
  duration : Double
  easing : String
}

///|
/// Keyboard coordinates
pub(all) struct KeyboardCoordinates {
  screen_x : Double
  screen_y : Double
  width : Double
  height : Double
}

///|
fn KeyboardCoordinates::from_any(any : @core.Any) -> KeyboardCoordinates {
  {
    screen_x: any["screenX"].cast(),
    screen_y: any["screenY"].cast(),
    width: any["width"].cast(),
    height: any["height"].cast(),
  }
}

///|
fn KeyboardEvent::from_any(any : @core.Any) -> KeyboardEvent {
  let start = any["startCoordinates"]
  let start_coords : KeyboardCoordinates? = if @core.is_undefined(start) ||
    @core.is_null(start) {
    None
  } else {
    Some(KeyboardCoordinates::from_any(start))
  }
  {
    end_coordinates: KeyboardCoordinates::from_any(any["endCoordinates"]),
    start_coordinates: start_coords,
    duration: any["duration"].cast(),
    easing: any["easing"].cast(),
  }
}

///|
/// Dismiss the keyboard
pub fn keyboard_dismiss() -> Unit {
  ffi_keyboard_dismiss()
}

///|
/// Check if keyboard is visible
pub fn keyboard_is_visible() -> Bool {
  ffi_keyboard_is_visible()
}

///|
/// Get keyboard metrics
pub fn keyboard_metrics() -> KeyboardCoordinates? {
  let metrics = ffi_keyboard_metrics()
  if @core.is_undefined(metrics) || @core.is_null(metrics) {
    None
  } else {
    Some(KeyboardCoordinates::from_any(metrics))
  }
}

///|
/// Add a keyboard show listener
pub fn add_keyboard_did_show_listener(
  handler : (KeyboardEvent) -> Unit,
) -> Subscription {
  let wrapped : (@core.Any) -> Unit = fn(event) {
    handler(KeyboardEvent::from_any(event))
  }
  ffi_keyboard_add_listener("keyboardDidShow", @js.from_fn1(wrapped)).cast()
}

///|
/// Add a keyboard hide listener
pub fn add_keyboard_did_hide_listener(
  handler : (KeyboardEvent) -> Unit,
) -> Subscription {
  let wrapped : (@core.Any) -> Unit = fn(event) {
    handler(KeyboardEvent::from_any(event))
  }
  ffi_keyboard_add_listener("keyboardDidHide", @js.from_fn1(wrapped)).cast()
}

///|
/// Add a keyboard will show listener
pub fn add_keyboard_will_show_listener(
  handler : (KeyboardEvent) -> Unit,
) -> Subscription {
  let wrapped : (@core.Any) -> Unit = fn(event) {
    handler(KeyboardEvent::from_any(event))
  }
  ffi_keyboard_add_listener("keyboardWillShow", @js.from_fn1(wrapped)).cast()
}

///|
/// Add a keyboard will hide listener
pub fn add_keyboard_will_hide_listener(
  handler : (KeyboardEvent) -> Unit,
) -> Subscription {
  let wrapped : (@core.Any) -> Unit = fn(event) {
    handler(KeyboardEvent::from_any(event))
  }
  ffi_keyboard_add_listener("keyboardWillHide", @js.from_fn1(wrapped)).cast()
}

// ============================================================================
// AppState API
// https://reactnative.dev/docs/appstate
// ============================================================================

///|
extern "js" fn ffi_app_state_current_state() -> String =
  #| () => require("react-native").AppState.currentState

///|
extern "js" fn ffi_app_state_is_available() -> Bool =
  #| () => require("react-native").AppState.isAvailable

///|
extern "js" fn ffi_app_state_add_event_listener(
  event_type : String,
  handler : @core.Any,
) -> @core.Any =
  #| (type, handler) => require("react-native").AppState.addEventListener(type, handler)

///|
/// App state enum
pub(all) enum AppStateStatus {
  Active
  Background
  Inactive
  Unknown
  Extension
}

///|
fn AppStateStatus::from_string(s : String) -> AppStateStatus {
  match s {
    "active" => Active
    "background" => Background
    "inactive" => Inactive
    "extension" => Extension
    _ => Unknown
  }
}

///|
pub fn AppStateStatus::to_string(self : AppStateStatus) -> String {
  match self {
    Active => "active"
    Background => "background"
    Inactive => "inactive"
    Unknown => "unknown"
    Extension => "extension"
  }
}

///|
/// Get current app state
pub fn app_state_current() -> AppStateStatus {
  AppStateStatus::from_string(ffi_app_state_current_state())
}

///|
/// Check if AppState is available
pub fn app_state_is_available() -> Bool {
  ffi_app_state_is_available()
}

///|
/// Add an app state change listener
pub fn add_app_state_change_listener(
  handler : (AppStateStatus) -> Unit,
) -> Subscription {
  let wrapped : (String) -> Unit = fn(state) {
    handler(AppStateStatus::from_string(state))
  }
  ffi_app_state_add_event_listener("change", @js.from_fn1(wrapped)).cast()
}

///|
/// Add a memory warning listener (iOS only)
pub fn add_memory_warning_listener(handler : () -> Unit) -> Subscription {
  ffi_app_state_add_event_listener("memoryWarning", @js.from_fn0(handler)).cast()
}

///|
/// Add a focus listener
pub fn add_focus_listener(handler : () -> Unit) -> Subscription {
  ffi_app_state_add_event_listener("focus", @js.from_fn0(handler)).cast()
}

///|
/// Add a blur listener
pub fn add_blur_listener(handler : () -> Unit) -> Subscription {
  ffi_app_state_add_event_listener("blur", @js.from_fn0(handler)).cast()
}

// ============================================================================
// PixelRatio API
// https://reactnative.dev/docs/pixelratio
// ============================================================================

///|
extern "js" fn ffi_pixel_ratio_get() -> Double =
  #| () => require("react-native").PixelRatio.get()

///|
extern "js" fn ffi_pixel_ratio_get_font_scale() -> Double =
  #| () => require("react-native").PixelRatio.getFontScale()

///|
extern "js" fn ffi_pixel_ratio_get_pixel_size_for_layout_size(
  layout_size : Double,
) -> Double =
  #| (layoutSize) => require("react-native").PixelRatio.getPixelSizeForLayoutSize(layoutSize)

///|
extern "js" fn ffi_pixel_ratio_round_to_nearest_pixel(
  layout_size : Double,
) -> Double =
  #| (layoutSize) => require("react-native").PixelRatio.roundToNearestPixel(layoutSize)

///|
/// Get the device pixel ratio
pub fn pixel_ratio() -> Double {
  ffi_pixel_ratio_get()
}

///|
/// Get the font scale
pub fn font_scale() -> Double {
  ffi_pixel_ratio_get_font_scale()
}

///|
/// Get the pixel size for a layout size
pub fn pixel_size_for_layout(layout_size : Double) -> Double {
  ffi_pixel_ratio_get_pixel_size_for_layout_size(layout_size)
}

///|
/// Round a layout size to the nearest pixel
pub fn round_to_nearest_pixel(layout_size : Double) -> Double {
  ffi_pixel_ratio_round_to_nearest_pixel(layout_size)
}

// ============================================================================
// Appearance API
// https://reactnative.dev/docs/appearance
// ============================================================================

///|
extern "js" fn ffi_appearance_get_color_scheme() -> @core.Any =
  #| () => require("react-native").Appearance.getColorScheme()

///|
extern "js" fn ffi_appearance_set_color_scheme(scheme : @core.Any) -> Unit =
  #| (scheme) => require("react-native").Appearance.setColorScheme(scheme)

///|
extern "js" fn ffi_appearance_add_change_listener(
  handler : @core.Any,
) -> @core.Any =
  #| (handler) => require("react-native").Appearance.addChangeListener(handler)

///|
/// Color scheme enum
pub(all) enum ColorScheme {
  Light
  Dark
  Unspecified
}

///|
fn ColorScheme::from_any(any : @core.Any) -> ColorScheme {
  if @core.is_null(any) || @core.is_undefined(any) {
    Unspecified
  } else {
    let s : String = any.cast()
    match s {
      "light" => Light
      "dark" => Dark
      _ => Unspecified
    }
  }
}

///|
pub fn ColorScheme::to_string(self : ColorScheme) -> String {
  match self {
    Light => "light"
    Dark => "dark"
    Unspecified => "null"
  }
}

///|
/// Get the current color scheme
pub fn get_color_scheme() -> ColorScheme {
  ColorScheme::from_any(ffi_appearance_get_color_scheme())
}

///|
/// Set the color scheme (override)
pub fn set_color_scheme(scheme : ColorScheme?) -> Unit {
  let scheme_any : @core.Any = match scheme {
    Some(Light) => @core.any("light")
    Some(Dark) => @core.any("dark")
    _ => @core.null()
  }
  ffi_appearance_set_color_scheme(scheme_any)
}

///|
/// Appearance change event
pub struct AppearanceChangeEvent {
  color_scheme : ColorScheme
}

///|
/// Add an appearance change listener
pub fn add_appearance_change_listener(
  handler : (AppearanceChangeEvent) -> Unit,
) -> Subscription {
  let wrapped : (@core.Any) -> Unit = fn(event) {
    let change_event : AppearanceChangeEvent = {
      color_scheme: ColorScheme::from_any(event["colorScheme"]),
    }
    handler(change_event)
  }
  ffi_appearance_add_change_listener(@js.from_fn1(wrapped)).cast()
}

// ============================================================================
// BackHandler API (Android only)
// https://reactnative.dev/docs/backhandler
// ============================================================================

///|
extern "js" fn ffi_back_handler_exit_app() -> Unit =
  #| () => require("react-native").BackHandler.exitApp()

///|
extern "js" fn ffi_back_handler_add_event_listener(
  event_type : String,
  handler : @core.Any,
) -> @core.Any =
  #| (type, handler) => require("react-native").BackHandler.addEventListener(type, handler)

///|
/// Exit the app (Android only)
pub fn back_handler_exit_app() -> Unit {
  ffi_back_handler_exit_app()
}

///|
/// Add a hardware back press listener (Android only)
/// Return true to prevent default back behavior
pub fn add_back_handler_listener(handler : () -> Bool) -> Subscription {
  ffi_back_handler_add_event_listener(
    "hardwareBackPress",
    @js.from_fn0(handler),
  ).cast()
}

// ============================================================================
// ToastAndroid API (Android only)
// https://reactnative.dev/docs/toastandroid
// ============================================================================

///|
extern "js" fn ffi_toast_android_show(message : String, duration : Int) -> Unit =
  #| (message, duration) => require("react-native").ToastAndroid.show(message, duration)

///|
extern "js" fn ffi_toast_android_show_with_gravity(
  message : String,
  duration : Int,
  gravity : Int,
) -> Unit =
  #| (message, duration, gravity) => require("react-native").ToastAndroid.showWithGravity(message, duration, gravity)

///|
extern "js" fn ffi_toast_android_show_with_gravity_and_offset(
  message : String,
  duration : Int,
  gravity : Int,
  x_offset : Int,
  y_offset : Int,
) -> Unit =
  #| (message, duration, gravity, xOffset, yOffset) => require("react-native").ToastAndroid.showWithGravityAndOffset(message, duration, gravity, xOffset, yOffset)

///|
extern "js" fn ffi_toast_android_short() -> Int =
  #| () => require("react-native").ToastAndroid.SHORT

///|
extern "js" fn ffi_toast_android_long() -> Int =
  #| () => require("react-native").ToastAndroid.LONG

///|
extern "js" fn ffi_toast_android_top() -> Int =
  #| () => require("react-native").ToastAndroid.TOP

///|
extern "js" fn ffi_toast_android_bottom() -> Int =
  #| () => require("react-native").ToastAndroid.BOTTOM

///|
extern "js" fn ffi_toast_android_center() -> Int =
  #| () => require("react-native").ToastAndroid.CENTER

///|
/// Toast duration
pub(all) enum ToastDuration {
  Short
  Long
}

///|
fn ToastDuration::to_int(self : ToastDuration) -> Int {
  match self {
    Short => ffi_toast_android_short()
    Long => ffi_toast_android_long()
  }
}

///|
/// Toast gravity
pub(all) enum ToastGravity {
  Top
  Bottom
  Center
}

///|
fn ToastGravity::to_int(self : ToastGravity) -> Int {
  match self {
    Top => ffi_toast_android_top()
    Bottom => ffi_toast_android_bottom()
    Center => ffi_toast_android_center()
  }
}

///|
/// Show a toast message (Android only)
pub fn toast_show(message : String, duration? : ToastDuration = Short) -> Unit {
  ffi_toast_android_show(message, duration.to_int())
}

///|
/// Show a toast message with gravity (Android only)
pub fn toast_show_with_gravity(
  message : String,
  duration? : ToastDuration = Short,
  gravity? : ToastGravity = Bottom,
) -> Unit {
  ffi_toast_android_show_with_gravity(
    message,
    duration.to_int(),
    gravity.to_int(),
  )
}

///|
/// Show a toast message with gravity and offset (Android only)
pub fn toast_show_with_gravity_and_offset(
  message : String,
  duration? : ToastDuration = Short,
  gravity? : ToastGravity = Bottom,
  x_offset? : Int = 0,
  y_offset? : Int = 0,
) -> Unit {
  ffi_toast_android_show_with_gravity_and_offset(
    message,
    duration.to_int(),
    gravity.to_int(),
    x_offset,
    y_offset,
  )
}

// ============================================================================
// PermissionsAndroid API (Android only)
// https://reactnative.dev/docs/permissionsandroid
// ============================================================================

///|
extern "js" fn ffi_permissions_android_check(
  permission : String,
) -> @core.Promise[@core.Any] =
  #| (permission) => require("react-native").PermissionsAndroid.check(permission)

///|
extern "js" fn ffi_permissions_android_request(
  permission : String,
  rationale : @core.Any,
) -> @core.Promise[@core.Any] =
  #| (permission, rationale) => require("react-native").PermissionsAndroid.request(permission, rationale)

///|
extern "js" fn ffi_permissions_android_request_multiple(
  permissions : @core.Any,
) -> @core.Promise[@core.Any] =
  #| (permissions) => require("react-native").PermissionsAndroid.requestMultiple(permissions)

///|
/// Permission result
pub(all) enum PermissionResult {
  Granted
  Denied
  NeverAskAgain
}

///|
fn PermissionResult::from_string(s : String) -> PermissionResult {
  match s {
    "granted" => Granted
    "never_ask_again" => NeverAskAgain
    _ => Denied
  }
}

///|
/// Permission rationale
pub struct PermissionRationale {
  title : String
  message : String
  button_positive : String?
  button_negative : String?
  button_neutral : String?
}

///|
pub fn PermissionRationale::new(
  title~ : String,
  message~ : String,
  button_positive? : String? = None,
  button_negative? : String? = None,
  button_neutral? : String? = None,
) -> PermissionRationale {
  { title, message, button_positive, button_negative, button_neutral }
}

///|
fn PermissionRationale::to_any(self : PermissionRationale) -> @core.Any {
  let obj = @core.new_object()
  obj._set("title", @core.any(self.title))
  obj._set("message", @core.any(self.message))
  if self.button_positive is Some(v) {
    obj._set("buttonPositive", @core.any(v))
  }
  if self.button_negative is Some(v) {
    obj._set("buttonNegative", @core.any(v))
  }
  if self.button_neutral is Some(v) {
    obj._set("buttonNeutral", @core.any(v))
  }
  obj
}

///|
/// Check if a permission is granted (Android only)
pub async fn permission_check(permission : String) -> Bool {
  ffi_permissions_android_check(permission).wait().cast()
}

///|
/// Request a permission (Android only)
pub async fn permission_request(
  permission : String,
  rationale? : PermissionRationale? = None,
) -> PermissionResult {
  let rationale_any : @core.Any = match rationale {
    Some(r) => r.to_any()
    None => @core.undefined()
  }
  let result : String = ffi_permissions_android_request(
      permission, rationale_any,
    )
    .wait()
    .cast()
  PermissionResult::from_string(result)
}

///|
/// Request multiple permissions (Android only)
pub async fn permissions_request_multiple(
  permissions : Array[String],
) -> Map[String, PermissionResult] {
  let result = ffi_permissions_android_request_multiple(@core.any(permissions)).wait()
  let map : Map[String, PermissionResult] = {}
  for permission in permissions {
    let status : String = result[permission].cast()
    map[permission] = PermissionResult::from_string(status)
  }
  map
}

// ============================================================================
// ActionSheetIOS API (iOS only)
// https://reactnative.dev/docs/actionsheetios
// ============================================================================

///|
extern "js" fn ffi_action_sheet_ios_show_action_sheet_with_options(
  options : @core.Any,
  callback : @core.Any,
) -> Unit =
  #| (options, callback) => require("react-native").ActionSheetIOS.showActionSheetWithOptions(options, callback)

///|
extern "js" fn ffi_action_sheet_ios_show_share_action_sheet_with_options(
  options : @core.Any,
  failure_callback : @core.Any,
  success_callback : @core.Any,
) -> Unit =
  #| (options, failureCallback, successCallback) => require("react-native").ActionSheetIOS.showShareActionSheetWithOptions(options, failureCallback, successCallback)

///|
extern "js" fn ffi_action_sheet_ios_dismiss_action_sheet() -> Unit =
  #| () => require("react-native").ActionSheetIOS.dismissActionSheet()

///|
/// Action sheet options
pub struct ActionSheetOptions {
  options : Array[String]
  cancel_button_index : Int?
  destructive_button_index : Int?
  title : String?
  message : String?
  anchor : Int?
  tint_color : String?
  cancel_button_tint_color : String?
  user_interface_style : String?
  disabled_button_indices : Array[Int]?
}

///|
pub fn ActionSheetOptions::new(
  options~ : Array[String],
  cancel_button_index? : Int? = None,
  destructive_button_index? : Int? = None,
  title? : String? = None,
  message? : String? = None,
  anchor? : Int? = None,
  tint_color? : String? = None,
  cancel_button_tint_color? : String? = None,
  user_interface_style? : String? = None,
  disabled_button_indices? : Array[Int]? = None,
) -> ActionSheetOptions {
  {
    options,
    cancel_button_index,
    destructive_button_index,
    title,
    message,
    anchor,
    tint_color,
    cancel_button_tint_color,
    user_interface_style,
    disabled_button_indices,
  }
}

///|
fn ActionSheetOptions::to_any(self : ActionSheetOptions) -> @core.Any {
  let obj = @core.new_object()
  obj._set("options", @core.any(self.options))
  if self.cancel_button_index is Some(v) {
    obj._set("cancelButtonIndex", @core.any(v))
  }
  if self.destructive_button_index is Some(v) {
    obj._set("destructiveButtonIndex", @core.any(v))
  }
  if self.title is Some(v) {
    obj._set("title", @core.any(v))
  }
  if self.message is Some(v) {
    obj._set("message", @core.any(v))
  }
  if self.anchor is Some(v) {
    obj._set("anchor", @core.any(v))
  }
  if self.tint_color is Some(v) {
    obj._set("tintColor", @core.any(v))
  }
  if self.cancel_button_tint_color is Some(v) {
    obj._set("cancelButtonTintColor", @core.any(v))
  }
  if self.user_interface_style is Some(v) {
    obj._set("userInterfaceStyle", @core.any(v))
  }
  if self.disabled_button_indices is Some(v) {
    obj._set("disabledButtonIndices", @core.any(v))
  }
  obj
}

///|
/// Show an action sheet (iOS only)
pub fn show_action_sheet(
  options : ActionSheetOptions,
  callback : (Int) -> Unit,
) -> Unit {
  ffi_action_sheet_ios_show_action_sheet_with_options(
    options.to_any(),
    @js.from_fn1(callback),
  )
}

///|
/// Share options
pub struct ShareActionSheetOptions {
  url : String?
  message : String?
  subject : String?
  excluded_activity_types : Array[String]?
}

///|
pub fn ShareActionSheetOptions::new(
  url? : String? = None,
  message? : String? = None,
  subject? : String? = None,
  excluded_activity_types? : Array[String]? = None,
) -> ShareActionSheetOptions {
  { url, message, subject, excluded_activity_types }
}

///|
fn ShareActionSheetOptions::to_any(self : ShareActionSheetOptions) -> @core.Any {
  let obj = @core.new_object()
  if self.url is Some(v) {
    obj._set("url", @core.any(v))
  }
  if self.message is Some(v) {
    obj._set("message", @core.any(v))
  }
  if self.subject is Some(v) {
    obj._set("subject", @core.any(v))
  }
  if self.excluded_activity_types is Some(v) {
    obj._set("excludedActivityTypes", @core.any(v))
  }
  obj
}

///|
/// Show a share action sheet (iOS only)
pub fn show_share_action_sheet(
  options : ShareActionSheetOptions,
  on_failure : (String) -> Unit,
  on_success : (Bool, String) -> Unit,
) -> Unit {
  let failure_fn : (@core.Any) -> Unit = fn(error) {
    on_failure(error["message"].cast())
  }
  let success_fn : (@core.Any, @core.Any) -> Unit = fn(
    completed,
    activity_method,
  ) {
    on_success(completed.cast(), activity_method.cast())
  }
  ffi_action_sheet_ios_show_share_action_sheet_with_options(
    options.to_any(),
    @js.from_fn1(failure_fn),
    @js.from_fn2(success_fn),
  )
}

///|
/// Dismiss the action sheet (iOS only)
pub fn dismiss_action_sheet() -> Unit {
  ffi_action_sheet_ios_dismiss_action_sheet()
}

// ============================================================================
// Share API
// https://reactnative.dev/docs/share
// ============================================================================

///|
extern "js" fn ffi_share(
  content : @core.Any,
  options : @core.Any,
) -> @core.Promise[@core.Any] =
  #| (content, options) => require("react-native").Share.share(content, options)

///|
/// Share content
pub struct ShareContent {
  message : String?
  url : String?
  title : String?
}

///|
pub fn ShareContent::new(
  message? : String? = None,
  url? : String? = None,
  title? : String? = None,
) -> ShareContent {
  { message, url, title }
}

///|
fn ShareContent::to_any(self : ShareContent) -> @core.Any {
  let obj = @core.new_object()
  if self.message is Some(v) {
    obj._set("message", @core.any(v))
  }
  if self.url is Some(v) {
    obj._set("url", @core.any(v))
  }
  if self.title is Some(v) {
    obj._set("title", @core.any(v))
  }
  obj
}

///|
/// Share options
pub struct ShareOptions {
  dialog_title : String?
  exclude_activity_types : Array[String]?
  tint_color : String?
  subject : String?
  anchor : Int?
}

///|
pub fn ShareOptions::new(
  dialog_title? : String? = None,
  exclude_activity_types? : Array[String]? = None,
  tint_color? : String? = None,
  subject? : String? = None,
  anchor? : Int? = None,
) -> ShareOptions {
  { dialog_title, exclude_activity_types, tint_color, subject, anchor }
}

///|
fn ShareOptions::to_any(self : ShareOptions) -> @core.Any {
  let obj = @core.new_object()
  if self.dialog_title is Some(v) {
    obj._set("dialogTitle", @core.any(v))
  }
  if self.exclude_activity_types is Some(v) {
    obj._set("excludeActivityTypes", @core.any(v))
  }
  if self.tint_color is Some(v) {
    obj._set("tintColor", @core.any(v))
  }
  if self.subject is Some(v) {
    obj._set("subject", @core.any(v))
  }
  if self.anchor is Some(v) {
    obj._set("anchor", @core.any(v))
  }
  obj
}

///|
/// Share result
pub struct ShareResult {
  action : String
  activity_type : String?
}

///|
/// Share content
pub async fn share(
  content : ShareContent,
  options? : ShareOptions? = None,
) -> ShareResult {
  let options_any : @core.Any = match options {
    Some(o) => o.to_any()
    None => @core.new_object()
  }
  let result = ffi_share(content.to_any(), options_any).wait()
  let activity = result["activityType"]
  let activity_type : String? = if @core.is_null(activity) ||
    @core.is_undefined(activity) {
    None
  } else {
    Some(activity.cast())
  }
  { action: result["action"].cast(), activity_type }
}

// ============================================================================
// Vibration API
// https://reactnative.dev/docs/vibration
// ============================================================================

///|
extern "js" fn ffi_vibration_vibrate(
  pattern : @core.Any,
  repeat : Bool,
) -> Unit =
  #| (pattern, repeat) => require("react-native").Vibration.vibrate(pattern, repeat)

///|
extern "js" fn ffi_vibration_cancel() -> Unit =
  #| () => require("react-native").Vibration.cancel()

///|
/// Vibrate with a single duration
pub fn vibrate(duration? : Int? = None, repeat? : Bool = false) -> Unit {
  let pattern : @core.Any = match duration {
    Some(d) => @core.any(d)
    None => @core.undefined()
  }
  ffi_vibration_vibrate(pattern, repeat)
}

///|
/// Vibrate with a pattern
pub fn vibrate_pattern(pattern : Array[Int], repeat? : Bool = false) -> Unit {
  ffi_vibration_vibrate(@core.any(pattern), repeat)
}

///|
/// Cancel any ongoing vibration
pub fn vibration_cancel() -> Unit {
  ffi_vibration_cancel()
}

// ============================================================================
// AccessibilityInfo API
// https://reactnative.dev/docs/accessibilityinfo
// ============================================================================

///|
extern "js" fn ffi_accessibility_info_is_bold_text_enabled() -> @core.Promise[
  @core.Any,
] =
  #| () => require("react-native").AccessibilityInfo.isBoldTextEnabled()

///|
extern "js" fn ffi_accessibility_info_is_grayscale_enabled() -> @core.Promise[
  @core.Any,
] =
  #| () => require("react-native").AccessibilityInfo.isGrayscaleEnabled()

///|
extern "js" fn ffi_accessibility_info_is_invert_colors_enabled() -> @core.Promise[
  @core.Any,
] =
  #| () => require("react-native").AccessibilityInfo.isInvertColorsEnabled()

///|
extern "js" fn ffi_accessibility_info_is_reduce_motion_enabled() -> @core.Promise[
  @core.Any,
] =
  #| () => require("react-native").AccessibilityInfo.isReduceMotionEnabled()

///|
extern "js" fn ffi_accessibility_info_is_reduce_transparency_enabled() -> @core.Promise[
  @core.Any,
] =
  #| () => require("react-native").AccessibilityInfo.isReduceTransparencyEnabled()

///|
extern "js" fn ffi_accessibility_info_is_screen_reader_enabled() -> @core.Promise[
  @core.Any,
] =
  #| () => require("react-native").AccessibilityInfo.isScreenReaderEnabled()

///|
extern "js" fn ffi_accessibility_info_is_accessibility_service_enabled() -> @core.Promise[
  @core.Any,
] =
  #| () => require("react-native").AccessibilityInfo.isAccessibilityServiceEnabled()

///|
extern "js" fn ffi_accessibility_info_add_event_listener(
  event_type : String,
  handler : @core.Any,
) -> @core.Any =
  #| (type, handler) => require("react-native").AccessibilityInfo.addEventListener(type, handler)

///|
extern "js" fn ffi_accessibility_info_announce_for_accessibility(
  announcement : String,
) -> Unit =
  #| (announcement) => require("react-native").AccessibilityInfo.announceForAccessibility(announcement)

///|
extern "js" fn ffi_accessibility_info_announce_for_accessibility_with_options(
  announcement : String,
  options : @core.Any,
) -> Unit =
  #| (announcement, options) => require("react-native").AccessibilityInfo.announceForAccessibilityWithOptions(announcement, options)

///|
extern "js" fn ffi_accessibility_info_set_accessibility_focus(
  react_tag : Int,
) -> Unit =
  #| (reactTag) => require("react-native").AccessibilityInfo.setAccessibilityFocus(reactTag)

///|
extern "js" fn ffi_accessibility_info_get_recommended_timeout_millis(
  original_timeout : Int,
) -> @core.Promise[@core.Any] =
  #| (originalTimeout) => require("react-native").AccessibilityInfo.getRecommendedTimeoutMillis(originalTimeout)

///|
/// Check if bold text is enabled
pub async fn is_bold_text_enabled() -> Bool {
  ffi_accessibility_info_is_bold_text_enabled().wait().cast()
}

///|
/// Check if grayscale is enabled
pub async fn is_grayscale_enabled() -> Bool {
  ffi_accessibility_info_is_grayscale_enabled().wait().cast()
}

///|
/// Check if invert colors is enabled
pub async fn is_invert_colors_enabled() -> Bool {
  ffi_accessibility_info_is_invert_colors_enabled().wait().cast()
}

///|
/// Check if reduce motion is enabled
pub async fn is_reduce_motion_enabled() -> Bool {
  ffi_accessibility_info_is_reduce_motion_enabled().wait().cast()
}

///|
/// Check if reduce transparency is enabled
pub async fn is_reduce_transparency_enabled() -> Bool {
  ffi_accessibility_info_is_reduce_transparency_enabled().wait().cast()
}

///|
/// Check if screen reader is enabled
pub async fn is_screen_reader_enabled() -> Bool {
  ffi_accessibility_info_is_screen_reader_enabled().wait().cast()
}

///|
/// Check if accessibility service is enabled (Android only)
pub async fn is_accessibility_service_enabled() -> Bool {
  ffi_accessibility_info_is_accessibility_service_enabled().wait().cast()
}

///|
/// Announce for accessibility
pub fn announce_for_accessibility(announcement : String) -> Unit {
  ffi_accessibility_info_announce_for_accessibility(announcement)
}

///|
/// Announce for accessibility with options
pub fn announce_for_accessibility_with_options(
  announcement : String,
  queue? : Bool = false,
) -> Unit {
  let options = @core.new_object()
  options._set("queue", @core.any(queue))
  ffi_accessibility_info_announce_for_accessibility_with_options(
    announcement, options,
  )
}

///|
/// Set accessibility focus
pub fn set_accessibility_focus(react_tag : Int) -> Unit {
  ffi_accessibility_info_set_accessibility_focus(react_tag)
}

///|
/// Get recommended timeout in milliseconds (Android only)
pub async fn get_recommended_timeout_millis(original_timeout : Int) -> Int {
  ffi_accessibility_info_get_recommended_timeout_millis(original_timeout)
  .wait()
  .cast()
}

///|
/// Add a bold text change listener
pub fn add_bold_text_changed_listener(handler : (Bool) -> Unit) -> Subscription {
  ffi_accessibility_info_add_event_listener(
    "boldTextChanged",
    @js.from_fn1(handler),
  ).cast()
}

///|
/// Add a grayscale change listener
pub fn add_grayscale_changed_listener(handler : (Bool) -> Unit) -> Subscription {
  ffi_accessibility_info_add_event_listener(
    "grayscaleChanged",
    @js.from_fn1(handler),
  ).cast()
}

///|
/// Add an invert colors change listener
pub fn add_invert_colors_changed_listener(
  handler : (Bool) -> Unit,
) -> Subscription {
  ffi_accessibility_info_add_event_listener(
    "invertColorsChanged",
    @js.from_fn1(handler),
  ).cast()
}

///|
/// Add a reduce motion change listener
pub fn add_reduce_motion_changed_listener(
  handler : (Bool) -> Unit,
) -> Subscription {
  ffi_accessibility_info_add_event_listener(
    "reduceMotionChanged",
    @js.from_fn1(handler),
  ).cast()
}

///|
/// Add a reduce transparency change listener
pub fn add_reduce_transparency_changed_listener(
  handler : (Bool) -> Unit,
) -> Subscription {
  ffi_accessibility_info_add_event_listener(
    "reduceTransparencyChanged",
    @js.from_fn1(handler),
  ).cast()
}

///|
/// Add a screen reader change listener
pub fn add_screen_reader_changed_listener(
  handler : (Bool) -> Unit,
) -> Subscription {
  ffi_accessibility_info_add_event_listener(
    "screenReaderChanged",
    @js.from_fn1(handler),
  ).cast()
}

///|
/// Add an announcement finished listener (iOS only)
pub fn add_announcement_finished_listener(
  handler : (String, Bool) -> Unit,
) -> Subscription {
  let wrapped : (@core.Any) -> Unit = fn(event) {
    handler(event["announcement"].cast(), event["success"].cast())
  }
  ffi_accessibility_info_add_event_listener(
    "announcementFinished",
    @js.from_fn1(wrapped),
  ).cast()
}
