///|
/// Rollup Plugin Types - Shared types for Rollup-compatible bundlers
/// Used by: rolldown, vite, unplugin, etc.
/// See: https://rollupjs.org/plugin-development/

///| Input/External Types

///|
/// Input type - entry point(s) for the bundle
/// Can be: string | string[] | { [entryName: string]: string }
pub(all) enum Input {
  /// Single entry point
  Single(String)
  /// Multiple entry points
  Multiple(Array[String])
  /// Named entry points (object)
  Named(@core.Any)
}

///|
/// Convert Input to @core.Any for FFI
pub fn Input::to_any(self : Input) -> @core.Any {
  match self {
    Single(s) => @core.any(s)
    Multiple(arr) => @core.any(arr)
    Named(obj) => obj
  }
}

///|
/// External type - modules to exclude from bundle
/// Can be: string[] | (id, parentId, isResolved) => boolean
pub(all) enum External {
  /// Array of module IDs to externalize
  Modules(Array[String])
  /// Function to determine if module is external
  Fn((String, String, Bool) -> Bool)
}

///|
extern "js" fn ffi_external_fn_to_any(
  f : (String, String, Bool) -> Bool,
) -> @core.Any =
  #| (f) => (id, parentId, isResolved) => f(id, parentId ?? '', isResolved ?? false)

///|
/// Convert External to @core.Any for FFI
pub fn External::to_any(self : External) -> @core.Any {
  match self {
    Modules(arr) => @core.any(arr)
    Fn(f) => ffi_external_fn_to_any(f)
  }
}

///| Plugin Types

///|
/// Plugin type (Rollup-compatible)
pub type Plugin = @core.Any

///|
/// Convert plugins array to @core.Any
pub fn plugins(arr : Array[Plugin]) -> @core.Any {
  @core.any(arr)
}

///| Hook Callback Types (Rollup-compatible)

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

///|
/// CloseBundle hook callback
/// () -> Unit
pub type CloseBundleHook = () -> Unit

///| Output Types

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
  /// Source map if generated
  map : @core.Any
  /// Module IDs included in this chunk
  moduleIds : Array[String]
}

///|
/// self.type
pub fn OutputChunk::type_(self : OutputChunk) -> String {
  self.to_any()["type"].cast()
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
/// OutputAsset - a generated asset
pub(all) struct OutputAsset {
  /// Asset file name
  fileName : String
  /// Asset source content
  source : @core.Any
  /// Type (always "asset")
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

///| Plugin Builder

///|
/// Create a Rollup-compatible plugin with labeled arguments
/// See: https://rollupjs.org/plugin-development/
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
