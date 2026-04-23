///|
/// Comlink bindings tests
/// Note: Full Worker tests require browser/worker environment.
/// These tests verify basic API availability.

///|
test "proxy function" {
  let callback = @comlink.proxyCallback(fn(_event) { () })
  inspect(!@core.is_nullish(callback.as_any()), content="true")
}

///|
test "transfer array buffer" {
  let buffer = @core.new_object()
  let result = @comlink.transferArrayBuffer(@core.any(buffer))
  inspect(!@core.is_nullish(result), content="true")
}

///|
test "transfer with transferables" {
  let data = @core.new_object()
  let result = @comlink.transfer(@core.any(data), [])
  inspect(!@core.is_nullish(result), content="true")
}

///|
test "get symbols" {
  let create_ep = @comlink.createEndpointSymbol()
  inspect(!@core.is_nullish(create_ep), content="true")
  let release = @comlink.releaseProxySymbol()
  inspect(!@core.is_nullish(release), content="true")
  let marker = @comlink.proxyMarkerSymbol()
  inspect(!@core.is_nullish(marker), content="true")
}

///|
test "get transfer handlers" {
  let handlers = @comlink.transferHandlers()
  inspect(!@core.is_nullish(handlers), content="true")
}

///|
test "proxy with return value" {
  let func = @comlink.proxyFunction(fn(x) { x })
  inspect(!@core.is_nullish(func.as_any()), content="true")
}
