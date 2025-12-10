///|
/// Vite HMR (Hot Module Replacement) API bindings
/// https://vite.dev/guide/api-environment

///| HotChannel FFI

///|
extern "js" fn ffi_hot_send(channel : HotChannel, payload : @core.Any) -> Unit =
  #| (channel, payload) => channel.send(payload)

///|
extern "js" fn ffi_hot_on(
  channel : HotChannel,
  event : String,
  handler : @core.Any,
) -> Unit =
  #| (channel, event, handler) => channel.on(event, handler)

///|
extern "js" fn ffi_hot_off(
  channel : HotChannel,
  event : String,
  handler : @core.Any,
) -> Unit =
  #| (channel, event, handler) => channel.off(event, handler)

///| HotChannel Methods

///|
/// Send a payload to the client
pub fn HotChannel::send(self : HotChannel, payload : @core.Any) -> Unit {
  ffi_hot_send(self, payload)
}

///|
/// Listen for an event
pub fn HotChannel::on(
  self : HotChannel,
  event : String,
  handler : (@core.Any) -> Unit,
) -> Unit {
  ffi_hot_on(self, event, @js.from_fn1(handler))
}

///|
/// Remove an event listener
pub fn HotChannel::off(
  self : HotChannel,
  event : String,
  handler : (@core.Any) -> Unit,
) -> Unit {
  ffi_hot_off(self, event, @js.from_fn1(handler))
}

///| HMR Payload Helpers

///|
/// Create a full-reload HMR payload
pub fn createFullReloadPayload(path? : String) -> @core.Any {
  let payload = @core.new_object()
  payload["type"] = @core.any("full-reload")
  if path is Some(p) {
    payload["path"] = @core.any(p)
  }
  payload
}

///|
/// Create an update HMR payload for module updates
pub fn createUpdatePayload(updates : Array[@core.Any]) -> @core.Any {
  let payload = @core.new_object()
  payload["type"] = @core.any("update")
  payload["updates"] = @core.any(updates)
  payload
}

///|
/// Create a prune HMR payload for module cleanup
pub fn createPrunePayload(paths : Array[String]) -> @core.Any {
  let payload = @core.new_object()
  payload["type"] = @core.any("prune")
  payload["paths"] = @core.any(paths)
  payload
}

///|
/// Create a custom HMR payload
pub fn createCustomPayload(event : String, data? : @core.Any) -> @core.Any {
  let payload = @core.new_object()
  payload["type"] = @core.any("custom")
  payload["event"] = @core.any(event)
  if data is Some(d) {
    payload["data"] = d
  }
  payload
}
