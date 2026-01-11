///|
/// Tauri Core - Main IPC functionality
/// https://v2.tauri.app/reference/javascript/api/namespacecore/

///|
/// Check if running in Tauri environment
extern "js" fn ffi_is_tauri() -> Bool =
  #| () => typeof window !== 'undefined' && window.__TAURI__ !== undefined

///|
pub fn is_tauri() -> Bool {
  ffi_is_tauri()
}

///|
/// Invoke a Tauri command
extern "js" fn ffi_invoke(
  cmd : String,
  args : @core.Any,
) -> @js.Promise[@core.Any] =
  #| (cmd, args) => import("@tauri-apps/api/core").then(m => m.invoke(cmd, args))

///|
/// Invoke a Tauri command with headers
extern "js" fn ffi_invoke_with_options(
  cmd : String,
  args : @core.Any,
  options : @core.Any,
) -> @js.Promise[@core.Any] =
  #| (cmd, args, opts) => import("@tauri-apps/api/core").then(m => m.invoke(cmd, args, opts))

///|
/// Invoke a Tauri command
pub async fn invoke(cmd : String, args? : @core.Any) -> @core.Any {
  let a = args.unwrap_or(@core.new_object())
  ffi_invoke(cmd, a).wait()
}

///|
/// Invoke a Tauri command with options
pub async fn invoke_with_headers(
  cmd : String,
  args : @core.Any,
  headers : @core.Any,
) -> @core.Any {
  let opts = @core.new_object()
  opts["headers"] = headers
  ffi_invoke_with_options(cmd, args, opts).wait()
}

///|
/// Convert a device file path to a URL that can be loaded by webview
extern "js" fn ffi_convert_file_src(
  file_path : String,
  protocol : String,
) -> String =
  #| (path, proto) => {
  #|   if (typeof window !== 'undefined' && window.__TAURI__) {
  #|     return window.__TAURI__.core.convertFileSrc(path, proto);
  #|   }
  #|   return `${proto}://localhost/${encodeURIComponent(path)}`;
  #| }

///|
/// Convert a device file path to a URL that can be loaded by webview
pub fn convert_file_src(file_path : String, protocol? : String) -> String {
  ffi_convert_file_src(file_path, protocol.unwrap_or("asset"))
}

///|
/// Transform a callback function into a number for IPC
extern "js" fn ffi_transform_callback(callback : @core.Any) -> Int =
  #| (cb) => {
  #|   if (typeof window !== 'undefined' && window.__TAURI__) {
  #|     return window.__TAURI__.core.transformCallback(cb);
  #|   }
  #|   return 0;
  #| }

///|
/// Channel for bidirectional communication
#external
pub type Channel

///|
pub fn Channel::as_any(self : Channel) -> @core.Any = "%identity"

///|
extern "js" fn ffi_new_channel() -> @js.Promise[@core.Any] =
  #| () => import("@tauri-apps/api/core").then(m => new m.Channel())

///|
/// Create a new Channel
pub async fn Channel::new() -> Channel {
  ffi_new_channel().wait().cast()
}

///|
extern "js" fn ffi_channel_on_message(
  channel : @core.Any,
  handler : @core.Any,
) -> Unit =
  #| (ch, handler) => ch.onmessage = handler

///|
/// Set message handler for channel
pub fn Channel::on_message(
  self : Channel,
  handler : (@core.Any) -> Unit,
) -> Unit {
  ffi_channel_on_message(self.as_any(), @core.any(handler))
}

///|
extern "js" fn ffi_channel_id(channel : @core.Any) -> Int =
  #| (ch) => ch.id

///|
/// Get channel ID
pub fn Channel::id(self : Channel) -> Int {
  ffi_channel_id(self.as_any())
}

///|
/// Resource class for Rust-backed resources
#external
pub type Resource

///|
pub fn Resource::as_any(self : Resource) -> @core.Any = "%identity"

///|
extern "js" fn ffi_resource_close(
  resource : @core.Any,
) -> @js.Promise[@core.Any] =
  #| (res) => res.close()

///|
/// Close the resource
pub async fn Resource::close(self : Resource) -> Unit {
  ffi_resource_close(self.as_any()).wait() |> ignore
}

///|
extern "js" fn ffi_resource_rid(resource : @core.Any) -> Int =
  #| (res) => res.rid

///|
/// Get resource ID
pub fn Resource::rid(self : Resource) -> Int {
  ffi_resource_rid(self.as_any())
}

///|
/// Permission state
pub(all) enum PermissionState {
  Granted
  Denied
  Prompt
  PromptWithRationale
}

///|
pub fn permission_state_from_string(s : String) -> PermissionState {
  match s {
    "granted" => Granted
    "denied" => Denied
    "prompt" => Prompt
    "prompt-with-rationale" => PromptWithRationale
    _ => Prompt
  }
}

///|
pub fn permission_state_to_string(state : PermissionState) -> String {
  match state {
    Granted => "granted"
    Denied => "denied"
    Prompt => "prompt"
    PromptWithRationale => "prompt-with-rationale"
  }
}
