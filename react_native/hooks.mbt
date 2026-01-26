///| React Native Hooks
/// useColorScheme, useWindowDimensions

// ============================================================================
// useColorScheme Hook
// https://reactnative.dev/docs/usecolorscheme
// ============================================================================

///|
extern "js" fn ffi_use_color_scheme() -> @core.Any =
  #| () => require("react-native").useColorScheme()

///|
/// useColorScheme - Returns the user's preferred color scheme
pub fn use_color_scheme() -> ColorScheme {
  ColorScheme::from_any(ffi_use_color_scheme())
}

// ============================================================================
// useWindowDimensions Hook
// https://reactnative.dev/docs/usewindowdimensions
// ============================================================================

///|
extern "js" fn ffi_use_window_dimensions() -> @core.Any =
  #| () => require("react-native").useWindowDimensions()

///|
/// useWindowDimensions - Returns the current window dimensions
pub fn use_window_dimensions() -> ScaledSize {
  ScaledSize::from_any(ffi_use_window_dimensions())
}
