///|
/// Vite API bindings for MoonBit
/// https://vite.dev/guide/api-javascript

///| Types

///|
/// ViteDevServer - the development server instance
#external
pub type ViteDevServer

///|
pub fn ViteDevServer::to_any(self : ViteDevServer) -> @core.Any = "%identity"

///|
/// DevEnvironment - development environment instance
/// https://vite.dev/guide/api-environment
pub(all) struct DevEnvironment {
  /// Environment name (e.g., "client", "ssr")
  name : String
  /// Resolved config for this environment
  config : @core.Any
  /// Mode (development/production)
  mode : String
  /// Resolved plugins for this environment
  plugins : @core.Any
  /// HMR hot channel
  hot : HotChannel
  /// Module graph
  moduleGraph : ModuleGraph
  /// Plugin container
  pluginContainer : PluginContainer
}

///|
pub fn DevEnvironment::to_any(self : DevEnvironment) -> @core.Any = "%identity"

///|
extern "js" fn ffi_dev_environment_from_any(env : @core.Any) -> DevEnvironment =
  #| (e) => ({ name: e.name, config: e.config, mode: e.mode, plugins: e.plugins, hot: e.hot, moduleGraph: e.moduleGraph, pluginContainer: e.pluginContainer })

///|
/// Parse a DevEnvironment from Any
pub fn DevEnvironment::from_any(env : @core.Any) -> DevEnvironment {
  ffi_dev_environment_from_any(env)
}

///|
/// ModuleGraph - tracks import relationships between modules
#external
pub type ModuleGraph

///|
pub fn ModuleGraph::to_any(self : ModuleGraph) -> @core.Any = "%identity"

///|
/// ModuleNode - represents a module in the graph
#external
pub type ModuleNode

///|
pub fn ModuleNode::to_any(self : ModuleNode) -> @core.Any = "%identity"

///|
/// HotChannel - communication channel with runtime
#external
pub type HotChannel

///|
pub fn HotChannel::to_any(self : HotChannel) -> @core.Any = "%identity"

///|
/// PluginContainer - plugin pipeline container
#external
pub type PluginContainer

///|
pub fn PluginContainer::to_any(self : PluginContainer) -> @core.Any = "%identity"

///|
/// ModuleRunner - runs modules in target runtime
#external
pub type ModuleRunner

///|
pub fn ModuleRunner::to_any(self : ModuleRunner) -> @core.Any = "%identity"

///|
/// TransformResult - result of module transformation
/// https://vite.dev/guide/api-environment-instances
pub(all) struct TransformResult {
  /// The transformed code
  code : String
  /// Source map (can be null)
  map : @core.Any
  /// ETag for caching
  etag : String
  /// Static dependencies
  deps : Array[String]
  /// Dynamic import dependencies
  dynamicDeps : Array[String]
}

///|
pub fn TransformResult::to_any(self : TransformResult) -> @core.Any = "%identity"

///|
extern "js" fn ffi_transform_result_from_any(
  result : @core.Any,
) -> TransformResult =
  #| (r) => ({ code: r.code || '', map: r.map || null, etag: r.etag || '', deps: r.deps || [], dynamicDeps: r.dynamicDeps || [] })

///|
/// Parse a TransformResult from Any
pub fn TransformResult::from_any(result : @core.Any) -> TransformResult {
  ffi_transform_result_from_any(result)
}

///|
/// FetchResult - result of module fetch
#external
pub type FetchResult

///|
pub fn FetchResult::to_any(self : FetchResult) -> @core.Any = "%identity"

///| ViteDevServer FFI

///|
#module("vite")
extern "js" fn ffi_create_server(
  config : @core.Any,
) -> @js.Promise[ViteDevServer] = "createServer"

///|
extern "js" fn ffi_server_print_urls(server : ViteDevServer) -> Unit =
  #| (server) => server.printUrls()

///|
extern "js" fn ffi_server_resolved_urls(server : ViteDevServer) -> @core.Any =
  #| (server) => server.resolvedUrls

///|
extern "js" fn ffi_server_listen(
  server : ViteDevServer,
  port : Int,
) -> @js.Promise[ViteDevServer] =
  #| (server, port) => server.listen(port)

///|
extern "js" fn ffi_server_close(server : ViteDevServer) -> @js.Promise[Unit] =
  #| (server) => server.close()

///|
extern "js" fn ffi_server_environments(server : ViteDevServer) -> @core.Any =
  #| (server) => server.environments

///|
extern "js" fn ffi_server_get_environment(
  server : ViteDevServer,
  name : String,
) -> DevEnvironment =
  #| (server, name) => server.environments[name]

///| ViteDevServer Methods

///|
/// Create a new Vite dev server with config object
pub async fn createServerWithConfig(config : @core.Any) -> ViteDevServer {
  ffi_create_server(config).wait()
}

///|
/// Create a new Vite dev server
pub async fn createServer(
  root? : String,
  base? : String,
  mode? : String,
  logLevel? : String,
  clearScreen? : Bool,
  server? : @core.Any,
  plugins? : @core.Any,
) -> ViteDevServer {
  let cfg = @core.new_object()
  if root is Some(v) {
    cfg["root"] = @core.any(v)
  }
  if base is Some(v) {
    cfg["base"] = @core.any(v)
  }
  if mode is Some(v) {
    cfg["mode"] = @core.any(v)
  }
  if logLevel is Some(v) {
    cfg["logLevel"] = @core.any(v)
  }
  if clearScreen is Some(v) {
    cfg["clearScreen"] = @core.any(v)
  }
  if server is Some(v) {
    cfg["server"] = @core.any(v)
  }
  if plugins is Some(v) {
    cfg["plugins"] = @core.any(v)
  }
  ffi_create_server(cfg).wait()
}

///|
/// Start listening on the specified port
pub async fn ViteDevServer::listen(
  self : ViteDevServer,
  port? : Int,
) -> ViteDevServer {
  ffi_server_listen(self, port.unwrap_or(5173)).wait()
}

///|
/// Close the server
pub async fn ViteDevServer::close(self : ViteDevServer) -> Unit {
  ffi_server_close(self).wait()
}

///|
/// Print server URLs to console
pub fn ViteDevServer::printUrls(self : ViteDevServer) -> Unit {
  ffi_server_print_urls(self)
}

///|
/// Get the resolved URLs
pub fn ViteDevServer::resolvedUrls(self : ViteDevServer) -> @core.Any {
  ffi_server_resolved_urls(self)
}

///|
/// Get all environments
pub fn ViteDevServer::environments(self : ViteDevServer) -> @core.Any {
  ffi_server_environments(self)
}

///|
/// Get environment by name (client, ssr, or custom)
pub fn ViteDevServer::getEnvironment(
  self : ViteDevServer,
  name : String,
) -> DevEnvironment {
  ffi_server_get_environment(self, name)
}

///|
/// Get the client environment
pub fn ViteDevServer::client(self : Self) -> DevEnvironment {
  ffi_server_get_environment(self, "client")
}

///|
/// Get the SSR environment
pub fn ViteDevServer::ssr(self : Self) -> DevEnvironment {
  ffi_server_get_environment(self, "ssr")
}

///| SSR Methods

///|
extern "js" fn ffi_server_transform_index_html(
  server : ViteDevServer,
  url : String,
  html : String,
) -> @js.Promise[String] =
  #| (server, url, html) => server.transformIndexHtml(url, html)

///|
extern "js" fn ffi_server_ssr_load_module(
  server : ViteDevServer,
  url : String,
) -> @js.Promise[@core.Any] =
  #| (server, url) => server.ssrLoadModule(url)

///|
extern "js" fn ffi_server_ssr_fix_stack_trace(
  server : ViteDevServer,
  error : @core.Any,
) -> Unit =
  #| (server, error) => server.ssrFixStacktrace(error)

///|
extern "js" fn ffi_server_middlewares(server : ViteDevServer) -> @core.Any =
  #| (server) => server.middlewares

///|
/// Transform index.html with Vite's transformations (HMR injection, plugin transforms)
/// See: https://vite.dev/guide/ssr
pub async fn ViteDevServer::transformIndexHtml(
  self : Self,
  url : String,
  html : String,
) -> String {
  ffi_server_transform_index_html(self, url, html).wait()
}

///|
/// Load a module for SSR (development only)
/// Deprecated in Vite 6+, use environment.runner.import() instead
pub async fn ViteDevServer::ssrLoadModule(
  self : Self,
  url : String,
) -> @core.Any {
  ffi_server_ssr_load_module(self, url).wait()
}

///|
/// Fix stack trace for SSR errors
pub fn ViteDevServer::ssrFixStacktrace(self : Self, error : @core.Any) -> Unit {
  ffi_server_ssr_fix_stack_trace(self, error)
}

///|
/// Get the Connect middleware instance
pub fn ViteDevServer::middlewares(self : ViteDevServer) -> @core.Any {
  ffi_server_middlewares(self)
}
