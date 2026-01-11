///|
/// Tauri Path - Path utilities
/// https://v2.tauri.app/reference/javascript/api/namespacepath/

///|
extern "js" fn ffi_app_cache_dir() -> @js.Promise[String] =
  #| () => import("@tauri-apps/api/path").then(m => m.appCacheDir())

///|
/// Get app cache directory
pub async fn app_cache_dir() -> String {
  ffi_app_cache_dir().wait()
}

///|
extern "js" fn ffi_app_config_dir() -> @js.Promise[String] =
  #| () => import("@tauri-apps/api/path").then(m => m.appConfigDir())

///|
/// Get app config directory
pub async fn app_config_dir() -> String {
  ffi_app_config_dir().wait()
}

///|
extern "js" fn ffi_app_data_dir() -> @js.Promise[String] =
  #| () => import("@tauri-apps/api/path").then(m => m.appDataDir())

///|
/// Get app data directory
pub async fn app_data_dir() -> String {
  ffi_app_data_dir().wait()
}

///|
extern "js" fn ffi_app_local_data_dir() -> @js.Promise[String] =
  #| () => import("@tauri-apps/api/path").then(m => m.appLocalDataDir())

///|
/// Get app local data directory
pub async fn app_local_data_dir() -> String {
  ffi_app_local_data_dir().wait()
}

///|
extern "js" fn ffi_app_log_dir() -> @js.Promise[String] =
  #| () => import("@tauri-apps/api/path").then(m => m.appLogDir())

///|
/// Get app log directory
pub async fn app_log_dir() -> String {
  ffi_app_log_dir().wait()
}

///|
extern "js" fn ffi_audio_dir() -> @js.Promise[String] =
  #| () => import("@tauri-apps/api/path").then(m => m.audioDir())

///|
/// Get audio directory
pub async fn audio_dir() -> String {
  ffi_audio_dir().wait()
}

///|
extern "js" fn ffi_cache_dir() -> @js.Promise[String] =
  #| () => import("@tauri-apps/api/path").then(m => m.cacheDir())

///|
/// Get cache directory
pub async fn cache_dir() -> String {
  ffi_cache_dir().wait()
}

///|
extern "js" fn ffi_config_dir() -> @js.Promise[String] =
  #| () => import("@tauri-apps/api/path").then(m => m.configDir())

///|
/// Get config directory
pub async fn config_dir() -> String {
  ffi_config_dir().wait()
}

///|
extern "js" fn ffi_data_dir() -> @js.Promise[String] =
  #| () => import("@tauri-apps/api/path").then(m => m.dataDir())

///|
/// Get data directory
pub async fn data_dir() -> String {
  ffi_data_dir().wait()
}

///|
extern "js" fn ffi_desktop_dir() -> @js.Promise[String] =
  #| () => import("@tauri-apps/api/path").then(m => m.desktopDir())

///|
/// Get desktop directory
pub async fn desktop_dir() -> String {
  ffi_desktop_dir().wait()
}

///|
extern "js" fn ffi_document_dir() -> @js.Promise[String] =
  #| () => import("@tauri-apps/api/path").then(m => m.documentDir())

///|
/// Get document directory
pub async fn document_dir() -> String {
  ffi_document_dir().wait()
}

///|
extern "js" fn ffi_download_dir() -> @js.Promise[String] =
  #| () => import("@tauri-apps/api/path").then(m => m.downloadDir())

///|
/// Get download directory
pub async fn download_dir() -> String {
  ffi_download_dir().wait()
}

///|
extern "js" fn ffi_executable_dir() -> @js.Promise[String] =
  #| () => import("@tauri-apps/api/path").then(m => m.executableDir())

///|
/// Get executable directory
pub async fn executable_dir() -> String {
  ffi_executable_dir().wait()
}

///|
extern "js" fn ffi_home_dir() -> @js.Promise[String] =
  #| () => import("@tauri-apps/api/path").then(m => m.homeDir())

///|
/// Get home directory
pub async fn home_dir() -> String {
  ffi_home_dir().wait()
}

///|
extern "js" fn ffi_local_data_dir() -> @js.Promise[String] =
  #| () => import("@tauri-apps/api/path").then(m => m.localDataDir())

///|
/// Get local data directory
pub async fn local_data_dir() -> String {
  ffi_local_data_dir().wait()
}

///|
extern "js" fn ffi_picture_dir() -> @js.Promise[String] =
  #| () => import("@tauri-apps/api/path").then(m => m.pictureDir())

///|
/// Get picture directory
pub async fn picture_dir() -> String {
  ffi_picture_dir().wait()
}

///|
extern "js" fn ffi_public_dir() -> @js.Promise[String] =
  #| () => import("@tauri-apps/api/path").then(m => m.publicDir())

///|
/// Get public directory
pub async fn public_dir() -> String {
  ffi_public_dir().wait()
}

///|
extern "js" fn ffi_resource_dir() -> @js.Promise[String] =
  #| () => import("@tauri-apps/api/path").then(m => m.resourceDir())

///|
/// Get resource directory
pub async fn resource_dir() -> String {
  ffi_resource_dir().wait()
}

///|
extern "js" fn ffi_runtime_dir() -> @js.Promise[String] =
  #| () => import("@tauri-apps/api/path").then(m => m.runtimeDir())

///|
/// Get runtime directory
pub async fn runtime_dir() -> String {
  ffi_runtime_dir().wait()
}

///|
extern "js" fn ffi_temp_dir() -> @js.Promise[String] =
  #| () => import("@tauri-apps/api/path").then(m => m.tempDir())

///|
/// Get temp directory
pub async fn temp_dir() -> String {
  ffi_temp_dir().wait()
}

///|
extern "js" fn ffi_template_dir() -> @js.Promise[String] =
  #| () => import("@tauri-apps/api/path").then(m => m.templateDir())

///|
/// Get template directory
pub async fn template_dir() -> String {
  ffi_template_dir().wait()
}

///|
extern "js" fn ffi_video_dir() -> @js.Promise[String] =
  #| () => import("@tauri-apps/api/path").then(m => m.videoDir())

///|
/// Get video directory
pub async fn video_dir() -> String {
  ffi_video_dir().wait()
}

///|
extern "js" fn ffi_basename(
  path : String,
  ext : @core.Any,
) -> @js.Promise[String] =
  #| (path, ext) => import("@tauri-apps/api/path").then(m => m.basename(path, ext))

///|
/// Get basename of path
pub async fn basename(path : String, ext? : String) -> String {
  let e : @core.Any = match ext {
    Some(e) => @core.any(e)
    None => @core.undefined()
  }
  ffi_basename(path, e).wait()
}

///|
extern "js" fn ffi_dirname(path : String) -> @js.Promise[String] =
  #| (path) => import("@tauri-apps/api/path").then(m => m.dirname(path))

///|
/// Get directory name of path
pub async fn dirname(path : String) -> String {
  ffi_dirname(path).wait()
}

///|
extern "js" fn ffi_extname(path : String) -> @js.Promise[String] =
  #| (path) => import("@tauri-apps/api/path").then(m => m.extname(path))

///|
/// Get extension of path
pub async fn extname(path : String) -> String {
  ffi_extname(path).wait()
}

///|
extern "js" fn ffi_is_absolute(path : String) -> @js.Promise[Bool] =
  #| (path) => import("@tauri-apps/api/path").then(m => m.isAbsolute(path))

///|
/// Check if path is absolute
pub async fn is_absolute(path : String) -> Bool {
  ffi_is_absolute(path).wait()
}

///|
extern "js" fn ffi_join(paths : @core.Any) -> @js.Promise[String] =
  #| (paths) => import("@tauri-apps/api/path").then(m => m.join(...paths))

///|
/// Join paths
pub async fn join(paths : Array[String]) -> String {
  ffi_join(@core.any(paths)).wait()
}

///|
extern "js" fn ffi_normalize(path : String) -> @js.Promise[String] =
  #| (path) => import("@tauri-apps/api/path").then(m => m.normalize(path))

///|
/// Normalize path
pub async fn normalize(path : String) -> String {
  ffi_normalize(path).wait()
}

///|
extern "js" fn ffi_resolve(paths : @core.Any) -> @js.Promise[String] =
  #| (paths) => import("@tauri-apps/api/path").then(m => m.resolve(...paths))

///|
/// Resolve paths
pub async fn resolve(paths : Array[String]) -> String {
  ffi_resolve(@core.any(paths)).wait()
}

///|
extern "js" fn ffi_resolve_resource(
  resource_path : String,
) -> @js.Promise[String] =
  #| (path) => import("@tauri-apps/api/path").then(m => m.resolveResource(path))

///|
/// Resolve resource path
pub async fn resolve_resource(resource_path : String) -> String {
  ffi_resolve_resource(resource_path).wait()
}

///|
extern "js" fn ffi_delimiter() -> String =
  #| () => {
  #|   if (typeof window !== 'undefined' && window.__TAURI__) {
  #|     return window.__TAURI__.path.delimiter();
  #|   }
  #|   return ':';
  #| }

///|
/// Get path delimiter
pub fn delimiter() -> String {
  ffi_delimiter()
}

///|
extern "js" fn ffi_sep() -> String =
  #| () => {
  #|   if (typeof window !== 'undefined' && window.__TAURI__) {
  #|     return window.__TAURI__.path.sep();
  #|   }
  #|   return '/';
  #| }

///|
/// Get path separator
pub fn sep() -> String {
  ffi_sep()
}
