///|
/// Rolldown - Fast Rust bundler for JavaScript with Rollup-compatible API
/// https://rolldown.rs/

///| Re-export types from rollup_types
/// Note: enum constructors (Single, Multiple, Named, Modules, Fn) cannot be re-exported
/// Use @rollup_types.Single, @rollup_types.Modules, etc. directly
pub using @rollup_types {
  type Input,
  type External,
  type Plugin,
  type OutputChunk,
  type OutputAsset,
  type ResolveIdHook,
  type LoadHook,
  type TransformHook,
  type BuildStartHook,
  type BuildEndHook,
  type RenderChunkHook,
  type GenerateBundleHook,
  type WriteBundleHook,
  type CloseBundleHook,
}

///| Rolldown-specific Types

///|
/// RolldownBuild - represents a built bundle
#external
pub type RolldownBuild

///|
pub fn RolldownBuild::to_any(self : RolldownBuild) -> @core.Any = "%identity"

///|
/// RolldownOutput - result of generate/write
pub(all) struct RolldownOutput {
  /// The output array (chunks and assets)
  output : Array[@core.Any]
}

///|
pub fn RolldownOutput::to_any(self : RolldownOutput) -> @core.Any = "%identity"

///|
extern "js" fn ffi_rolldown_output_from_any(o : @core.Any) -> RolldownOutput =
  #| (o) => ({ output: o.output || [] })

///|
/// Parse a RolldownOutput from Any
pub fn RolldownOutput::from_any(o : @core.Any) -> RolldownOutput {
  ffi_rolldown_output_from_any(o)
}

///|
/// Watcher - watches for file changes
#external
pub type Watcher

///|
pub fn Watcher::to_any(self : Watcher) -> @core.Any = "%identity"

///| FFI Functions

///|
extern "js" fn ffi_rolldown(
  options : @core.Any,
) -> @core.Promise[RolldownBuild] =
  #| (options) => import("rolldown").then(m => m.rolldown(options))

///|
extern "js" fn ffi_build(options : @core.Any) -> @core.Promise[RolldownOutput] =
  #| (options) => import("rolldown").then(m => m.build(options))

///|
extern "js" fn ffi_watch(options : @core.Any) -> @core.Promise[Watcher] =
  #| (options) => import("rolldown").then(m => m.watch(options))

///| Helper function to build input options object
fn build_input_options(
  input : Input,
  external : External?,
  plugins : Array[Plugin]?,
  resolve : @core.Any?,
  platform : String?,
  cwd : String?,
  treeshake : @core.Any?,
) -> @core.Any {
  let opts = @core.new_object()
  opts["input"] = input.to_any()
  if external is Some(v) {
    opts["external"] = v.to_any()
  }
  if plugins is Some(v) {
    opts["plugins"] = @core.any(v)
  }
  if resolve is Some(v) {
    opts["resolve"] = v
  }
  if platform is Some(v) {
    opts["platform"] = @core.any(v)
  }
  if cwd is Some(v) {
    opts["cwd"] = @core.any(v)
  }
  if treeshake is Some(v) {
    opts["treeshake"] = v
  }
  opts
}

///| Main Functions

///|
/// Create a bundle for processing with labeled arguments
/// Returns a RolldownBuild that can be used to generate or write output
pub async fn rolldown(
  input~ : Input,
  external? : External,
  plugins? : Array[Plugin],
  resolve? : @core.Any,
  platform? : String,
  cwd? : String,
  treeshake? : @core.Any,
) -> RolldownBuild {
  let opts = build_input_options(
    input, external, plugins, resolve, platform, cwd, treeshake,
  )
  ffi_rolldown(opts).wait()
}

///|
/// Create output options object
pub fn outputOptions(
  file? : String,
  dir? : String,
  format? : String,
  entryFileNames? : String,
  chunkFileNames? : String,
  assetFileNames? : String,
  sourcemap? : @core.Any,
  minify? : @core.Any,
  banner? : String,
  footer? : String,
  intro? : String,
  outro? : String,
  globals? : @core.Any,
  advancedChunks? : @core.Any,
) -> @core.Any {
  let opts = @core.new_object()
  if file is Some(v) {
    opts["file"] = @core.any(v)
  }
  if dir is Some(v) {
    opts["dir"] = @core.any(v)
  }
  if format is Some(v) {
    opts["format"] = @core.any(v)
  }
  if entryFileNames is Some(v) {
    opts["entryFileNames"] = @core.any(v)
  }
  if chunkFileNames is Some(v) {
    opts["chunkFileNames"] = @core.any(v)
  }
  if assetFileNames is Some(v) {
    opts["assetFileNames"] = @core.any(v)
  }
  if sourcemap is Some(v) {
    opts["sourcemap"] = v
  }
  if minify is Some(v) {
    opts["minify"] = v
  }
  if banner is Some(v) {
    opts["banner"] = @core.any(v)
  }
  if footer is Some(v) {
    opts["footer"] = @core.any(v)
  }
  if intro is Some(v) {
    opts["intro"] = @core.any(v)
  }
  if outro is Some(v) {
    opts["outro"] = @core.any(v)
  }
  if globals is Some(v) {
    opts["globals"] = v
  }
  if advancedChunks is Some(v) {
    opts["advancedChunks"] = v
  }
  opts
}

///|
/// Build with input and output options (typed version)
/// Convenience function combining input and output options
pub async fn build(
  input~ : Input,
  output? : @core.Any,
  external? : External,
  plugins? : Array[Plugin],
  resolve? : @core.Any,
  platform? : String,
  cwd? : String,
  treeshake? : @core.Any,
) -> RolldownOutput {
  let opts = build_input_options(
    input, external, plugins, resolve, platform, cwd, treeshake,
  )
  if output is Some(v) {
    opts["output"] = v
  }
  ffi_build(opts).wait()
}

///|
/// Create a watcher for rebuilding on file changes
pub async fn watch(
  input~ : Input,
  external? : External,
  plugins? : Array[Plugin],
  resolve? : @core.Any,
  platform? : String,
  cwd? : String,
  treeshake? : @core.Any,
) -> Watcher {
  let opts = build_input_options(
    input, external, plugins, resolve, platform, cwd, treeshake,
  )
  ffi_watch(opts).wait()
}

///| RolldownBuild Methods

///|
extern "js" fn ffi_build_generate(
  build : RolldownBuild,
  options : @core.Any,
) -> @core.Promise[RolldownOutput] =
  #| (build, options) => build.generate(options)

///|
extern "js" fn ffi_build_write(
  build : RolldownBuild,
  options : @core.Any,
) -> @core.Promise[RolldownOutput] =
  #| (build, options) => build.write(options)

///|
extern "js" fn ffi_build_close(build : RolldownBuild) -> @core.Promise[Unit] =
  #| (build) => build.close()

///|
/// Generate output in memory
pub async fn RolldownBuild::generate(
  self : RolldownBuild,
  options : @core.Any,
) -> RolldownOutput {
  ffi_build_generate(self, options).wait()
}

///|
/// Write generated bundles to disk
pub async fn RolldownBuild::write(
  self : RolldownBuild,
  options : @core.Any,
) -> RolldownOutput {
  ffi_build_write(self, options).wait()
}

///|
/// Close the bundle
pub async fn RolldownBuild::close(self : RolldownBuild) -> Unit {
  ffi_build_close(self).wait()
}

///| Watcher Methods

///|
extern "js" fn ffi_watcher_on(
  watcher : Watcher,
  event : String,
  callback : @core.Any,
) -> Watcher =
  #| (watcher, event, callback) => watcher.on(event, callback)

///|
extern "js" fn ffi_watcher_close(watcher : Watcher) -> @core.Promise[Unit] =
  #| (watcher) => watcher.close()

///|
/// Add event listener
/// Events: "event", "change", "close"
pub fn Watcher::on(
  self : Watcher,
  event : String,
  callback : (@core.Any) -> Unit,
) -> Watcher {
  ffi_watcher_on(self, event, @core.any(callback))
}

///|
/// Close the watcher
pub async fn Watcher::close(self : Watcher) -> Unit {
  ffi_watcher_close(self).wait()
}

///| Plugin Functions (re-exported for convenience)

///|
/// Create a Rolldown plugin with labeled arguments
/// See: https://rolldown.rs/apis/plugin-api
pub fn define_plugin(
  name : String,
  buildStart? : BuildStartHook,
  resolveId? : ResolveIdHook,
  load? : LoadHook,
  transform? : TransformHook,
  renderChunk? : RenderChunkHook,
  generateBundle? : GenerateBundleHook,
  writeBundle? : WriteBundleHook,
  buildEnd? : BuildEndHook,
  closeBundle? : CloseBundleHook,
) -> Plugin {
  @rollup_types.define_plugin(
    name,
    buildStart?,
    resolveId?,
    load?,
    transform?,
    renderChunk?,
    generateBundle?,
    writeBundle?,
    buildEnd?,
    closeBundle?,
  )
}
