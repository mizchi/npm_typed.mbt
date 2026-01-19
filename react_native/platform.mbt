///| Platform API for React Native
/// https://reactnative.dev/docs/platform

// ============================================================================
// Platform FFI
// ============================================================================

///|
extern "js" fn ffi_platform_os() -> String =
  #| () => require("react-native").Platform.OS

///|
extern "js" fn ffi_platform_version() -> @core.Any =
  #| () => require("react-native").Platform.Version

///|
extern "js" fn ffi_platform_is_tv() -> Bool =
  #| () => require("react-native").Platform.isTV

///|
extern "js" fn ffi_platform_is_testing() -> Bool =
  #| () => require("react-native").Platform.isTesting

///|
extern "js" fn ffi_platform_select(specifics : @core.Any) -> @core.Any =
  #| (specifics) => require("react-native").Platform.select(specifics)

// ============================================================================
// Platform Module
// ============================================================================

///|
/// OS type enum
pub(all) enum OS {
  IOS
  Android
  Windows
  MacOS
  Web
  Other(String)
}

///|
pub fn OS::to_string(self : OS) -> String {
  match self {
    IOS => "ios"
    Android => "android"
    Windows => "windows"
    MacOS => "macos"
    Web => "web"
    Other(s) => s
  }
}

///|
fn OS::from_string(s : String) -> OS {
  match s {
    "ios" => IOS
    "android" => Android
    "windows" => Windows
    "macos" => MacOS
    "web" => Web
    other => Other(other)
  }
}

///|
/// Get the current operating system
pub fn os() -> OS {
  OS::from_string(ffi_platform_os())
}

///|
/// Get the OS name as a string
pub fn os_string() -> String {
  ffi_platform_os()
}

///|
/// Get the platform version
/// For iOS, returns the OS version (e.g., "14.0")
/// For Android, returns the API level as a number
pub fn version() -> @core.Any {
  ffi_platform_version()
}

///|
/// Get the iOS version as a string (only valid on iOS)
pub fn ios_version() -> String {
  ffi_platform_version().cast()
}

///|
/// Get the Android API level (only valid on Android)
pub fn android_api_level() -> Int {
  ffi_platform_version().cast()
}

///|
/// Check if running on TV
pub fn is_tv() -> Bool {
  ffi_platform_is_tv()
}

///|
/// Check if running in testing mode
pub fn is_testing() -> Bool {
  ffi_platform_is_testing()
}

///|
/// Check if running on iOS
pub fn is_ios() -> Bool {
  ffi_platform_os() == "ios"
}

///|
/// Check if running on Android
pub fn is_android() -> Bool {
  ffi_platform_os() == "android"
}

///|
/// Check if running on Web
pub fn is_web() -> Bool {
  ffi_platform_os() == "web"
}

///|
/// Check if running on macOS
pub fn is_macos() -> Bool {
  ffi_platform_os() == "macos"
}

///|
/// Check if running on Windows
pub fn is_windows() -> Bool {
  ffi_platform_os() == "windows"
}

///|
/// Select a value based on the current platform
pub fn[T] select(
  ios? : T? = None,
  android? : T? = None,
  web? : T? = None,
  macos? : T? = None,
  windows? : T? = None,
  default? : T? = None,
) -> T? {
  let current_os = ffi_platform_os()
  match current_os {
    "ios" => if ios is Some(_) { ios } else { default }
    "android" => if android is Some(_) { android } else { default }
    "web" => if web is Some(_) { web } else { default }
    "macos" => if macos is Some(_) { macos } else { default }
    "windows" => if windows is Some(_) { windows } else { default }
    _ => default
  }
}

///|
/// Select a value using the native Platform.select method
pub fn select_any(specifics : Map[String, @core.Any]) -> @core.Any {
  let obj = @core.new_object()
  for key, value in specifics {
    obj._set(key, value)
  }
  ffi_platform_select(obj)
}
