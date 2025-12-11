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
#external
pub type RolldownOutput

///|
pub fn RolldownOutput::to_any(self : RolldownOutput) -> @core.Any = "%identity"

///|
/// OutputChunk - a generated chunk
#external
pub type OutputChunk

///|
pub fn OutputChunk::to_any(self : OutputChunk) -> @core.Any = "%identity"

///|
/// OutputAsset - a generated asset
#external
pub type OutputAsset

///|
pub fn OutputAsset::to_any(self : OutputAsset) -> @core.Any = "%identity"

///|
/// Watcher - watches for file changes
#external
pub type Watcher

///|
pub fn Watcher::to_any(self : Watcher) -> @core.Any = "%identity"

///| FFI Functions

///|
extern "js" fn ffi_rolldown(options : @core.Any) -> @core.Promise[RolldownBuild] =
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

///| RolldownOutput Methods

///|
extern "js" fn ffi_output_output(output : RolldownOutput) -> @core.Any =
  #| (output) => output.output

///|
/// Get the output array (chunks and assets)
pub fn RolldownOutput::output(self : RolldownOutput) -> @core.Any {
  ffi_output_output(self)
}

///| OutputChunk Methods

///|
/// Get chunk file name
pub fn OutputChunk::fileName(self : OutputChunk) -> String {
  self.to_any()["fileName"].cast()
}

///|
/// Get chunk code
pub fn OutputChunk::code(self : OutputChunk) -> String {
  self.to_any()["code"].cast()
}

///|
/// Check if this is an entry chunk
#alias(is_entry)
pub fn OutputChunk::isEntry(self : OutputChunk) -> Bool {
  self.to_any()["isEntry"].cast()
}

///|
/// Get chunk name
pub fn OutputChunk::name(self : OutputChunk) -> String {
  self.to_any()["name"].cast()
}

///|
/// Get chunk type (always "chunk")
pub fn OutputChunk::type_(self : OutputChunk) -> String {
  self.to_any()["type"].cast()
}

///|
/// Get sourcemap if generated
pub fn OutputChunk::map(self : OutputChunk) -> @core.Any {
  self.to_any()["map"]
}

///|
/// Get module IDs included in this chunk
#alias(module_ids)
pub fn OutputChunk::moduleIds(self : OutputChunk) -> @core.Any {
  self.to_any()["moduleIds"]
}

///| OutputAsset Methods

///|
/// Get asset file name
pub fn OutputAsset::fileName(self : OutputAsset) -> String {
  self.to_any()["fileName"].cast()
}

///|
/// Get asset source content
pub fn OutputAsset::source(self : OutputAsset) -> @core.Any {
  self.to_any()["source"]
}

///|
/// Get asset type (always "asset")
pub fn OutputAsset::type_(self : OutputAsset) -> String {
  self.to_any()["type"].cast()
}

///|
/// Get asset name
pub fn OutputAsset::name(self : OutputAsset) -> String? {
  let v = self.to_any()["name"]
  if @core.is_nullish(v) {
    None
  } else {
    Some(v.cast())
  }
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
