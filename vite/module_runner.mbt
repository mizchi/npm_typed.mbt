///|
/// Vite ModuleRunner API bindings
/// https://vite.dev/guide/api-environment-runtimes

///| ModuleRunner FFI

///|
extern "js" fn ffi_runner_import(
  runner : ModuleRunner,
  url : String,
) -> @js.Promise[@core.Any] =
  #| (runner, url) => runner.import(url)

///|
extern "js" fn ffi_runner_clear_cache(runner : ModuleRunner) -> Unit =
  #| (runner) => runner.clearCache()

///|
extern "js" fn ffi_runner_close(runner : ModuleRunner) -> @js.Promise[Unit] =
  #| (runner) => runner.close()

///|
extern "js" fn ffi_runner_is_closed(runner : ModuleRunner) -> Bool =
  #| (runner) => runner.isClosed()

///| ModuleRunner Methods

///|
/// Import and execute a module
pub async fn ModuleRunner::importModule(
  self : ModuleRunner,
  url : String,
) -> @core.Any {
  ffi_runner_import(self, url).wait()
}

///|
/// Clear all caches
pub fn ModuleRunner::clearCache(self : ModuleRunner) -> Unit {
  ffi_runner_clear_cache(self)
}

///|
/// Close the runner
pub async fn ModuleRunner::close(self : ModuleRunner) -> Unit {
  ffi_runner_close(self).wait()
}

///|
/// Check if runner is closed
pub fn ModuleRunner::isClosed(self : ModuleRunner) -> Bool {
  ffi_runner_is_closed(self)
}

///| TransformResult FFI

///|
extern "js" fn ffi_result_code(result : TransformResult) -> String =
  #| (result) => result.code

///|
extern "js" fn ffi_result_map(result : TransformResult) -> @core.Any =
  #| (result) => result.map

///|
extern "js" fn ffi_result_etag(result : TransformResult) -> String? =
  #| (result) => result.etag

///| TransformResult Methods

///|
/// Get the transformed code
pub fn TransformResult::code(self : TransformResult) -> String {
  ffi_result_code(self)
}

///|
/// Get the source map
pub fn TransformResult::map(self : TransformResult) -> @core.Any {
  ffi_result_map(self)
}

///|
/// Get the etag
pub fn TransformResult::etag(self : TransformResult) -> String? {
  ffi_result_etag(self)
}
