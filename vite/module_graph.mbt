///|
/// Vite ModuleGraph API bindings
/// https://vite.dev/guide/api-environment

///| ModuleGraph FFI

///|
extern "js" fn ffi_graph_get_module_by_url(
  graph : ModuleGraph,
  url : String,
) -> @js.Promise[ModuleNode?] =
  #| (graph, url) => graph.getModuleByUrl(url)

///|
extern "js" fn ffi_graph_get_module_by_id(
  graph : ModuleGraph,
  id : String,
) -> ModuleNode? =
  #| (graph, id) => graph.getModuleById(id)

///|
extern "js" fn ffi_graph_invalidate_module(
  graph : ModuleGraph,
  mod : ModuleNode,
) -> Unit =
  #| (graph, mod) => graph.invalidateModule(mod)

///| ModuleNode FFI

///|
extern "js" fn ffi_node_id(node : ModuleNode) -> String? =
  #| (node) => node.id

///|
extern "js" fn ffi_node_url(node : ModuleNode) -> String =
  #| (node) => node.url

///|
extern "js" fn ffi_node_file(node : ModuleNode) -> String? =
  #| (node) => node.file

///|
extern "js" fn ffi_node_type(node : ModuleNode) -> String =
  #| (node) => node.type

///|
extern "js" fn ffi_node_importers(node : ModuleNode) -> @core.Any =
  #| (node) => Array.from(node.importers)

///|
extern "js" fn ffi_node_imported_modules(node : ModuleNode) -> @core.Any =
  #| (node) => Array.from(node.importedModules)

///| ModuleGraph Methods

///|
/// Get module by URL
pub async fn ModuleGraph::getModuleByUrl(
  self : ModuleGraph,
  url : String,
) -> ModuleNode? {
  ffi_graph_get_module_by_url(self, url).wait()
}

///|
/// Get module by ID (sync)
pub fn ModuleGraph::getModuleById(
  self : ModuleGraph,
  id : String,
) -> ModuleNode? {
  ffi_graph_get_module_by_id(self, id)
}

///|
/// Invalidate a module
pub fn ModuleGraph::invalidateModule(
  self : ModuleGraph,
  mod : ModuleNode,
) -> Unit {
  ffi_graph_invalidate_module(self, mod)
}

///| ModuleNode Methods

///|
/// Get the module ID
pub fn ModuleNode::id(self : ModuleNode) -> String? {
  ffi_node_id(self)
}

///|
/// Get the module URL
pub fn ModuleNode::url(self : ModuleNode) -> String {
  ffi_node_url(self)
}

///|
/// Get the file path
pub fn ModuleNode::file(self : ModuleNode) -> String? {
  ffi_node_file(self)
}

///|
/// Get the module type (js, css, etc.)
pub fn ModuleNode::moduleType(self : ModuleNode) -> String {
  ffi_node_type(self)
}

///|
/// Get modules that import this module
pub fn ModuleNode::importers(self : ModuleNode) -> Array[ModuleNode] {
  @core.identity(ffi_node_importers(self))
}

///|
/// Get modules imported by this module
pub fn ModuleNode::importedModules(self : ModuleNode) -> Array[ModuleNode] {
  @core.identity(ffi_node_imported_modules(self))
}
