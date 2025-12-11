///|
/// Rolldown - Fast Rust bundler for JavaScript with Rollup-compatible API
/// https://rolldown.rs/

///| Types

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
/// OutputChunk - a generated chunk
pub(all) struct OutputChunk {
  /// Chunk file name
  fileName : String
  /// Generated code
  code : String
  /// Whether this is an entry chunk
  isEntry : Bool
  /// Chunk name
  name : String
  /// Chunk type (always "chunk")
  type_ : String
  /// Source map if generated
  map : @core.Any
  /// Module IDs included in this chunk
  moduleIds : Array[String]
}

///|
pub fn OutputChunk::to_any(self : OutputChunk) -> @core.Any = "%identity"

///|
extern "js" fn ffi_output_chunk_from_any(c : @core.Any) -> OutputChunk =
  #| (c) => ({ fileName: c.fileName || '', code: c.code || '', isEntry: c.isEntry || false, name: c.name || '', type_: c.type || 'chunk', map: c.map || null, moduleIds: c.moduleIds || [] })

///|
/// Parse an OutputChunk from Any
pub fn OutputChunk::from_any(c : @core.Any) -> OutputChunk {
  ffi_output_chunk_from_any(c)
}

///|
/// Get chunk type from raw Any (always "chunk")
pub fn OutputChunk::type_(self : OutputChunk) -> String {
  self.to_any()["type"].cast()
}

///|
/// OutputAsset - a generated asset
pub(all) struct OutputAsset {
  /// Asset file name
  fileName : String
  /// Asset source content
  source : @core.Any
  /// Asset type (always "asset")
  type_ : String
  /// Asset name (optional)
  name : String?
}

///|
pub fn OutputAsset::to_any(self : OutputAsset) -> @core.Any = "%identity"

///|
extern "js" fn ffi_output_asset_from_any(a : @core.Any) -> OutputAsset =
  #| (a) => ({ fileName: a.fileName || '', source: a.source, type_: a.type || 'asset', name: a.name || null })

///|
/// Parse an OutputAsset from Any
pub fn OutputAsset::from_any(a : @core.Any) -> OutputAsset {
  ffi_output_asset_from_any(a)
}

///|
/// Get asset type from raw Any (always "asset")
pub fn OutputAsset::type_(self : OutputAsset) -> String {
  self.to_any()["type"].cast()
}

///|
/// Watcher - watches for file changes
#external
pub type Watcher

///|
pub fn Watcher::to_any(self : Watcher) -> @core.Any = "%identity"

///|
/// Plugin type
pub type Plugin = @core.Any

///| Hook callback types

///|
/// ResolveId hook callback
/// (source: String, importer: String?, options: @core.Any) -> String? | @core.Any?
pub type ResolveIdHook = (String, String?, @core.Any) -> String?

///|
/// Load hook callback
/// (id: String) -> String? | @core.Any?
pub type LoadHook = (String) -> String?

///|
/// Transform hook callback
/// (code: String, id: String) -> String? | @core.Any?
pub type TransformHook = (String, String) -> String?

///|
/// BuildStart hook callback
/// (options: @core.Any) -> Unit
pub type BuildStartHook = (@core.Any) -> Unit

///|
/// BuildEnd hook callback
/// (error?: @core.Any) -> Unit
pub type BuildEndHook = (@core.Any?) -> Unit

///|
/// RenderChunk hook callback
/// (code: String, chunk: @core.Any, options: @core.Any) -> String? | @core.Any?
pub type RenderChunkHook = (String, @core.Any, @core.Any) -> String?

///|
/// GenerateBundle hook callback
/// (options: @core.Any, bundle: @core.Any) -> Unit
pub type GenerateBundleHook = (@core.Any, @core.Any) -> Unit

///|
/// WriteBundle hook callback
/// (options: @core.Any, bundle: @core.Any) -> Unit
pub type WriteBundleHook = (@core.Any, @core.Any) -> Unit

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

///| Main Functions

///|
/// Create a bundle for processing
/// Returns a RolldownBuild that can be used to generate or write output
pub async fn rolldown(options : @core.Any) -> RolldownBuild {
  ffi_rolldown(options).wait()
}

///|
/// Create input options object
pub fn inputOptions(
  input~ : @core.Any,
  external? : @core.Any,
  plugins? : @core.Any,
  resolve? : @core.Any,
  platform? : String,
  cwd? : String,
  treeshake? : @core.Any,
) -> @core.Any {
  let opts = @core.new_object()
  opts["input"] = input
  if external is Some(v) {
    opts["external"] = v
  }
  if plugins is Some(v) {
    opts["plugins"] = v
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
/// Convenience function combining input and output options
/// Writes output to disk by default
pub async fn build(options : @core.Any) -> RolldownOutput {
  ffi_build(options).wait()
}

///|
/// Create build options with input and output
pub fn buildOptions(
  input~ : @core.Any,
  output? : @core.Any,
  external? : @core.Any,
  plugins? : @core.Any,
  resolve? : @core.Any,
  platform? : String,
  cwd? : String,
  treeshake? : @core.Any,
) -> @core.Any {
  let opts = @core.new_object()
  opts["input"] = input
  if output is Some(v) {
    opts["output"] = v
  }
  if external is Some(v) {
    opts["external"] = v
  }
  if plugins is Some(v) {
    opts["plugins"] = v
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

///|
/// Create a watcher for rebuilding on file changes
pub async fn watch(options : @core.Any) -> Watcher {
  ffi_watch(options).wait()
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

///| Plugin Functions

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
  closeBundle? : () -> Unit,
) -> Plugin {
  let plugin = @core.new_object()
  plugin["name"] = @core.any(name)
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
  if renderChunk is Some(v) {
    plugin["renderChunk"] = @core.any(@js.from_fn3(v))
  }
  if generateBundle is Some(v) {
    plugin["generateBundle"] = @core.any(@js.from_fn2(v))
  }
  if writeBundle is Some(v) {
    plugin["writeBundle"] = @core.any(@js.from_fn2(v))
  }
  if buildEnd is Some(v) {
    plugin["buildEnd"] = @core.any(@js.from_fn1(v))
  }
  if closeBundle is Some(v) {
    plugin["closeBundle"] = @core.any(@js.from_fn0(v))
  }
  plugin |> @core.identity
}
