///|
/// Vite Plugin API support
/// See: https://ja.vite.dev/guide/api-plugin

///| Re-export Rollup-compatible types from rollup_types
pub using @rollup_types {
  type Plugin,
  type ResolveIdHook,
  type LoadHook,
  type TransformHook,
  type BuildStartHook,
  type BuildEndHook,
  type CloseBundleHook,
}

///| Vite-specific Hook callback types

///|
/// Config hook callback
/// (config: @core.Any, env: @core.Any) -> @core.Any | Unit
pub type ConfigHook = (@core.Any, @core.Any) -> @core.Any?

///|
/// ConfigResolved hook callback
/// (config: @core.Any) -> Unit
pub type ConfigResolvedHook = (@core.Any) -> Unit

///|
/// ConfigureServer hook callback
/// (server: ViteDevServer) -> (() -> Unit)?
pub type ConfigureServerHook = (@core.Any) -> Unit

///|
/// ConfigurePreviewServer hook callback
/// (server: PreviewServer) -> (() -> Unit)?
pub type ConfigurePreviewServerHook = (@core.Any) -> Unit

///|
/// TransformIndexHtml hook callback
/// (html: String, ctx: @core.Any) -> String | @core.Any
pub type TransformIndexHtmlHook = (String, @core.Any) -> @core.Any

///|
/// HandleHotUpdate hook callback
/// (ctx: HmrContext) -> Unit | Array[@core.Any]?
pub type HandleHotUpdateHook = (@core.Any) -> Unit

///|
/// Create a Vite plugin with labeled arguments
/// Extends Rollup plugin with Vite-specific hooks
/// See: https://ja.vite.dev/guide/api-plugin
pub fn define_plugin(
  name : String,
  // Vite-specific options
  enforce? : String,
  apply? : String,
  // Vite-specific hooks
  config? : ConfigHook,
  configResolved? : ConfigResolvedHook,
  configureServer? : ConfigureServerHook,
  configurePreviewServer? : ConfigurePreviewServerHook,
  transformIndexHtml? : TransformIndexHtmlHook,
  handleHotUpdate? : HandleHotUpdateHook,
  // Rollup-compatible hooks
  options? : (@core.Any) -> Unit,
  buildStart? : BuildStartHook,
  resolveId? : ResolveIdHook,
  load? : LoadHook,
  transform? : TransformHook,
  buildEnd? : BuildEndHook,
  closeBundle? : CloseBundleHook,
) -> Plugin {
  let plugin = @core.new_object()
  plugin["name"] = @core.any(name)
  // Vite-specific options
  if enforce is Some(v) {
    plugin["enforce"] = @core.any(v)
  }
  if apply is Some(v) {
    plugin["apply"] = @core.any(v)
  }
  // Vite-specific hooks
  if config is Some(v) {
    plugin["config"] = @core.any(@js.from_fn2(v))
  }
  if configResolved is Some(v) {
    plugin["configResolved"] = @core.any(@js.from_fn1(v))
  }
  if configureServer is Some(v) {
    plugin["configureServer"] = @core.any(@js.from_fn1(v))
  }
  if configurePreviewServer is Some(v) {
    plugin["configurePreviewServer"] = @core.any(@js.from_fn1(v))
  }
  if transformIndexHtml is Some(v) {
    plugin["transformIndexHtml"] = @core.any(@js.from_fn2(v))
  }
  if handleHotUpdate is Some(v) {
    plugin["handleHotUpdate"] = @core.any(@js.from_fn1(v))
  }
  // Rollup-compatible hooks
  if options is Some(v) {
    plugin["options"] = @core.any(@js.from_fn1(v))
  }
  if buildStart is Some(v) {
    plugin["buildStart"] = @core.any(@js.from_fn1(v))
  }
  if resolveId is Some(v) {
    plugin["resolveId"] = @core.any(@js.from_fn3(v))
  }
  if load is Some(v) {
    plugin["load"] = @core.any(@js.from_fn1(v))
  }
  if transform is Some(v) {
    plugin["transform"] = @core.any(@js.from_fn2(v))
  }
  if buildEnd is Some(v) {
    plugin["buildEnd"] = @core.any(@js.from_fn1(v))
  }
  if closeBundle is Some(v) {
    plugin["closeBundle"] = @core.any(@js.from_fn0(v))
  }
  plugin |> @core.identity
}
