///|
/// Tauri App - Application lifecycle
/// https://v2.tauri.app/reference/javascript/api/namespaceapp/

///|
/// Bundle type
pub(all) enum BundleType {
  App
  AppImage
  Deb
  Msi
  Nsis
  Rpm
}

///|
pub fn bundle_type_from_string(s : String) -> BundleType {
  match s {
    "app" => App
    "appimage" => AppImage
    "deb" => Deb
    "msi" => Msi
    "nsis" => Nsis
    "rpm" => Rpm
    _ => App
  }
}

///|
pub fn bundle_type_to_string(bt : BundleType) -> String {
  match bt {
    App => "app"
    AppImage => "appimage"
    Deb => "deb"
    Msi => "msi"
    Nsis => "nsis"
    Rpm => "rpm"
  }
}

///|
extern "js" fn ffi_get_name() -> @js.Promise[String] =
  #| () => import("@tauri-apps/api/app").then(m => m.getName())

///|
/// Get application name
pub async fn get_name() -> String {
  ffi_get_name().wait()
}

///|
extern "js" fn ffi_get_version() -> @js.Promise[String] =
  #| () => import("@tauri-apps/api/app").then(m => m.getVersion())

///|
/// Get application version
pub async fn get_version() -> String {
  ffi_get_version().wait()
}

///|
extern "js" fn ffi_get_tauri_version() -> @js.Promise[String] =
  #| () => import("@tauri-apps/api/app").then(m => m.getTauriVersion())

///|
/// Get Tauri framework version
pub async fn get_tauri_version() -> String {
  ffi_get_tauri_version().wait()
}

///|
extern "js" fn ffi_get_identifier() -> @js.Promise[String] =
  #| () => import("@tauri-apps/api/app").then(m => m.getIdentifier())

///|
/// Get application identifier
pub async fn get_identifier() -> String {
  ffi_get_identifier().wait()
}

///|
extern "js" fn ffi_get_bundle_type() -> @js.Promise[String] =
  #| () => import("@tauri-apps/api/app").then(m => m.getBundleType())

///|
/// Get current bundle type
pub async fn get_bundle_type() -> BundleType {
  bundle_type_from_string(ffi_get_bundle_type().wait())
}

///|
extern "js" fn ffi_show() -> @js.Promise[@core.Any] =
  #| () => import("@tauri-apps/api/app").then(m => m.show())

///|
/// Show application (macOS only)
pub async fn show() -> Unit {
  ffi_show().wait() |> ignore
}

///|
extern "js" fn ffi_hide() -> @js.Promise[@core.Any] =
  #| () => import("@tauri-apps/api/app").then(m => m.hide())

///|
/// Hide application (macOS only)
pub async fn hide() -> Unit {
  ffi_hide().wait() |> ignore
}

///|
/// Theme type
pub(all) enum Theme {
  Light
  Dark
}

///|
pub fn theme_to_string(t : Theme) -> String {
  match t {
    Light => "light"
    Dark => "dark"
  }
}

///|
pub fn theme_from_string(s : String) -> Theme {
  match s {
    "light" => Light
    "dark" => Dark
    _ => Light
  }
}

///|
extern "js" fn ffi_set_theme(theme : @core.Any) -> @js.Promise[@core.Any] =
  #| (theme) => import("@tauri-apps/api/app").then(m => m.setTheme(theme))

///|
/// Set application theme
pub async fn set_theme(theme? : Theme) -> Unit {
  let t : @core.Any = match theme {
    Some(t) => @core.any(theme_to_string(t))
    None => @core.null()
  }
  ffi_set_theme(t).wait() |> ignore
}

///|
extern "js" fn ffi_set_dock_visibility(
  visible : Bool,
) -> @js.Promise[@core.Any] =
  #| (visible) => import("@tauri-apps/api/app").then(m => m.setDockVisibility(visible))

///|
/// Set dock visibility (macOS only)
pub async fn set_dock_visibility(visible : Bool) -> Unit {
  ffi_set_dock_visibility(visible).wait() |> ignore
}
