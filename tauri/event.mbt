///|
/// Tauri Event - Inter-process communication events
/// https://v2.tauri.app/reference/javascript/api/namespaceevent/

///|
/// Tauri event types
pub const TAURI_EVENT_DRAG_DROP : String = "tauri://drag-drop"

///|
pub const TAURI_EVENT_DRAG_ENTER : String = "tauri://drag-enter"

///|
pub const TAURI_EVENT_DRAG_LEAVE : String = "tauri://drag-leave"

///|
pub const TAURI_EVENT_DRAG_OVER : String = "tauri://drag-over"

///|
pub const TAURI_EVENT_WEBVIEW_CREATED : String = "tauri://webview-created"

///|
pub const TAURI_EVENT_WINDOW_BLUR : String = "tauri://blur"

///|
pub const TAURI_EVENT_WINDOW_CLOSE_REQUESTED : String = "tauri://close-requested"

///|
pub const TAURI_EVENT_WINDOW_CREATED : String = "tauri://window-created"

///|
pub const TAURI_EVENT_WINDOW_DESTROYED : String = "tauri://destroyed"

///|
pub const TAURI_EVENT_WINDOW_FOCUS : String = "tauri://focus"

///|
pub const TAURI_EVENT_WINDOW_MOVED : String = "tauri://move"

///|
pub const TAURI_EVENT_WINDOW_RESIZED : String = "tauri://resize"

///|
pub const TAURI_EVENT_WINDOW_SCALE_FACTOR_CHANGED : String = "tauri://scale-change"

///|
pub const TAURI_EVENT_WINDOW_THEME_CHANGED : String = "tauri://theme-changed"

///|
/// Event wrapper
#external
pub type Event

///|
pub fn Event::as_any(self : Event) -> @core.Any = "%identity"

///|
/// Get event name
pub fn Event::event(self : Event) -> String {
  self.as_any()["event"].cast()
}

///|
/// Get event ID
pub fn Event::id(self : Event) -> Int {
  self.as_any()["id"].cast()
}

///|
/// Get event payload
pub fn Event::payload(self : Event) -> @core.Any {
  self.as_any()["payload"]
}

///|
/// Unlisten function
#external
pub type UnlistenFn

///|
pub fn UnlistenFn::as_any(self : UnlistenFn) -> @core.Any = "%identity"

///|
extern "js" fn ffi_unlisten(f : @core.Any) -> Unit =
  #| (f) => f()

///|
/// Call unlisten function to stop listening
pub fn UnlistenFn::unlisten(self : UnlistenFn) -> Unit {
  ffi_unlisten(self.as_any())
}

///|
/// Event listen options
pub(all) struct ListenOptions {
  target : String?
}

///|
fn listen_options_to_any(opts : ListenOptions) -> @core.Any {
  let obj = @core.new_object()
  if opts.target is Some(t) {
    obj["target"] = @core.any(t)
  }
  obj
}

///|
extern "js" fn ffi_listen(
  event : String,
  handler : @core.Any,
  options : @core.Any,
) -> @js.Promise[@core.Any] =
  #| (event, handler, opts) => import("@tauri-apps/api/event").then(m => m.listen(event, handler, opts))

///|
extern "js" fn ffi_listen_no_opts(
  event : String,
  handler : @core.Any,
) -> @js.Promise[@core.Any] =
  #| (event, handler) => import("@tauri-apps/api/event").then(m => m.listen(event, handler))

///|
/// Listen to an event
pub async fn listen(
  event : String,
  handler : (Event) -> Unit,
  options? : ListenOptions,
) -> UnlistenFn {
  let h : @core.Any = @core.any(handler)
  match options {
    Some(opts) =>
      ffi_listen(event, h, listen_options_to_any(opts)).wait().cast()
    None => ffi_listen_no_opts(event, h).wait().cast()
  }
}

///|
extern "js" fn ffi_once(
  event : String,
  handler : @core.Any,
  options : @core.Any,
) -> @js.Promise[@core.Any] =
  #| (event, handler, opts) => import("@tauri-apps/api/event").then(m => m.once(event, handler, opts))

///|
extern "js" fn ffi_once_no_opts(
  event : String,
  handler : @core.Any,
) -> @js.Promise[@core.Any] =
  #| (event, handler) => import("@tauri-apps/api/event").then(m => m.once(event, handler))

///|
/// Listen to an event once
pub async fn once(
  event : String,
  handler : (Event) -> Unit,
  options? : ListenOptions,
) -> UnlistenFn {
  let h : @core.Any = @core.any(handler)
  match options {
    Some(opts) => ffi_once(event, h, listen_options_to_any(opts)).wait().cast()
    None => ffi_once_no_opts(event, h).wait().cast()
  }
}

///|
extern "js" fn ffi_emit(
  event : String,
  payload : @core.Any,
) -> @js.Promise[@core.Any] =
  #| (event, payload) => import("@tauri-apps/api/event").then(m => m.emit(event, payload))

///|
/// Emit an event to all targets
pub async fn emit(event : String, payload? : @core.Any) -> Unit {
  ffi_emit(event, payload.unwrap_or(@core.undefined())).wait() |> ignore
}

///|
extern "js" fn ffi_emit_to(
  target : String,
  event : String,
  payload : @core.Any,
) -> @js.Promise[@core.Any] =
  #| (target, event, payload) => import("@tauri-apps/api/event").then(m => m.emitTo(target, event, payload))

///|
/// Emit an event to a specific target
pub async fn emit_to(
  target : String,
  event : String,
  payload? : @core.Any,
) -> Unit {
  ffi_emit_to(target, event, payload.unwrap_or(@core.undefined())).wait()
  |> ignore
}
