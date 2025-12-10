///|
/// Vite Environment API bindings for MoonBit
/// https://vite.dev/guide/api-environment
///
/// Environment API for Vite 6+ multi-environment support.

///| DevEnvironment FFI

///|
extern "js" fn ffi_env_name(env : DevEnvironment) -> String =
  #| (env) => env.name

///|
extern "js" fn ffi_env_hot(env : DevEnvironment) -> HotChannel =
  #| (env) => env.hot

///|
extern "js" fn ffi_env_module_graph(env : DevEnvironment) -> ModuleGraph =
  #| (env) => env.moduleGraph

///|
extern "js" fn ffi_env_plugin_container(
  env : DevEnvironment,
) -> PluginContainer =
  #| (env) => env.pluginContainer

///|
extern "js" fn ffi_env_transform_request(
  env : DevEnvironment,
  url : String,
) -> @js.Promise[TransformResult?] =
  #| (env, url) => env.transformRequest(url)

///|
extern "js" fn ffi_env_warmup_request(
  env : DevEnvironment,
  url : String,
) -> Unit =
  #| (env, url) => env.warmupRequest(url)

///|
extern "js" fn ffi_env_fetch_module(
  env : DevEnvironment,
  id : String,
  importer : String,
) -> @js.Promise[FetchResult] =
  #| (env, id, importer) => env.fetchModule(id, importer)

///|
extern "js" fn ffi_env_config(env : DevEnvironment) -> @core.Any =
  #| (env) => env.config

///|
extern "js" fn ffi_env_plugins(env : DevEnvironment) -> @core.Any =
  #| (env) => env.plugins

///|
extern "js" fn ffi_env_mode(env : DevEnvironment) -> String =
  #| (env) => env.mode

///|
extern "js" fn ffi_is_runnable_dev_environment(env : DevEnvironment) -> Bool =
  #| (env) => 'runner' in env

///|
extern "js" fn ffi_env_runner(env : DevEnvironment) -> ModuleRunner =
  #| (env) => env.runner

///|
extern "js" fn ffi_is_fetchable_dev_environment(env : DevEnvironment) -> Bool =
  #| (env) => typeof env.fetch === 'function'

///|
extern "js" fn ffi_env_fetch(
  env : DevEnvironment,
  request : @core.Any,
) -> @js.Promise[@core.Any] =
  #| (env, request) => env.fetch(request)

///|
#module("vite")
extern "js" fn ffi_create_server_module_runner(
  env : DevEnvironment,
) -> ModuleRunner = "createServerModuleRunner"

///| DevEnvironment Methods

///|
/// Get the environment name
pub fn DevEnvironment::name(self : DevEnvironment) -> String {
  ffi_env_name(self)
}

///|
/// Get the HMR hot channel
pub fn DevEnvironment::hot(self : DevEnvironment) -> HotChannel {
  ffi_env_hot(self)
}

///|
/// Get the module graph
pub fn DevEnvironment::moduleGraph(self : DevEnvironment) -> ModuleGraph {
  ffi_env_module_graph(self)
}

///|
/// Get the plugin container
pub fn DevEnvironment::pluginContainer(
  self : DevEnvironment,
) -> PluginContainer {
  ffi_env_plugin_container(self)
}

///|
/// Transform a request URL through the plugin pipeline
pub async fn DevEnvironment::transformRequest(
  self : DevEnvironment,
  url : String,
) -> TransformResult? {
  ffi_env_transform_request(self, url).wait()
}

///|
/// Register a low-priority warmup request
pub fn DevEnvironment::warmupRequest(
  self : DevEnvironment,
  url : String,
) -> Unit {
  ffi_env_warmup_request(self, url)
}

///|
/// Fetch a module for the runner
pub async fn DevEnvironment::fetchModule(
  self : DevEnvironment,
  id : String,
  importer? : String,
) -> FetchResult {
  ffi_env_fetch_module(self, id, importer.unwrap_or("")).wait()
}

///|
/// Get the resolved config for this environment
pub fn DevEnvironment::config(self : DevEnvironment) -> @core.Any {
  ffi_env_config(self)
}

///|
/// Get the resolved plugins for this environment
pub fn DevEnvironment::plugins(self : DevEnvironment) -> @core.Any {
  ffi_env_plugins(self)
}

///|
/// Get the mode (development/production)
pub fn DevEnvironment::mode(self : DevEnvironment) -> String {
  ffi_env_mode(self)
}

///|
/// Check if this environment is a RunnableDevEnvironment
pub fn DevEnvironment::isRunnable(self : DevEnvironment) -> Bool {
  ffi_is_runnable_dev_environment(self)
}

///|
/// Get the module runner (only available for RunnableDevEnvironment)
pub fn DevEnvironment::runner(self : DevEnvironment) -> ModuleRunner {
  ffi_env_runner(self)
}

///|
/// Check if this environment is a FetchableDevEnvironment
pub fn DevEnvironment::isFetchable(self : DevEnvironment) -> Bool {
  ffi_is_fetchable_dev_environment(self)
}

///|
/// Fetch a request (only available for FetchableDevEnvironment)
pub async fn DevEnvironment::fetch(
  self : DevEnvironment,
  request : @core.Any,
) -> @core.Any {
  ffi_env_fetch(self, request).wait()
}

///|
/// Create a ModuleRunner for the given environment
/// See: https://vite.dev/guide/api-environment-runtimes
pub fn createServerModuleRunner(env : DevEnvironment) -> ModuleRunner {
  ffi_create_server_module_runner(env)
}

///| EnvironmentOptions

///|
/// EnvironmentOptions - options for configuring an environment
pub(all) struct EnvironmentOptions {
  consumer : String? // "client" | "server"
  resolve : @core.Any?
  dev : @core.Any?
  build : @core.Any?
}

///|
/// Create an EnvironmentOptions object for custom environments
pub fn EnvironmentOptions::to_any(self : EnvironmentOptions) -> @core.Any {
  let obj = @core.new_object()
  if self.consumer is Some(v) {
    obj["consumer"] = @core.any(v)
  }
  if self.resolve is Some(v) {
    obj["resolve"] = v
  }
  if self.dev is Some(v) {
    obj["dev"] = v
  }
  if self.build is Some(v) {
    obj["build"] = v
  }
  obj
}
