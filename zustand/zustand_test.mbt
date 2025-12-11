///|
struct CounterState {
  count : Int
}

///|
test "createStore - struct state" {
  let store : @zustand.Store[CounterState] = @zustand.createStore(fn(
    _set,
    _get,
    _api,
  ) {
    { count: 0 }
  })
  let state = @zustand.getState(store)
  inspect(state.count, content="0")
}

///|
test "replaceState - direct state" {
  let store : @zustand.Store[CounterState] = @zustand.createStore(fn(
    _set,
    _get,
    _api,
  ) {
    { count: 0 }
  })
  @zustand.replaceState(store, { count: 5 })
  let state = @zustand.getState(store)
  inspect(state.count, content="5")
}

///|
test "setState - updater function" {
  let store : @zustand.Store[CounterState] = @zustand.createStore(fn(
    _set,
    _get,
    _api,
  ) {
    { count: 10 }
  })
  @zustand.setState(store, fn(prev) { { count: prev.count + 1 } })
  let state = @zustand.getState(store)
  inspect(state.count, content="11")
}

///|
test "subscribe - struct state changes" {
  let store : @zustand.Store[CounterState] = @zustand.createStore(fn(
    _set,
    _get,
    _api,
  ) {
    { count: 0 }
  })
  let mut received = 0
  let unsub = @zustand.subscribe(store, fn(state, _prev) {
    received = state.count
  })
  @zustand.replaceState(store, { count: 42 })
  inspect(received, content="42")
  unsub()
}

///|
test "subscribe_selector - typed selector" {
  let store : @zustand.Store[CounterState] = @zustand.createStore(fn(
    _set,
    _get,
    _api,
  ) {
    { count: 0 }
  })
  let mut received = 0
  let unsub = @zustand.subscribe_selector(store, fn(state) { state.count }, fn(
    count,
    _prev_count,
  ) {
    received = count
  })
  @zustand.replaceState(store, { count: 99 })
  inspect(received, content="99")
  unsub()
}

///|
test "getInitialState - struct state" {
  let store : @zustand.Store[CounterState] = @zustand.createStore(fn(
    _set,
    _get,
    _api,
  ) {
    { count: 42 }
  })
  @zustand.replaceState(store, { count: 100 })
  let initial = @zustand.getInitialState(store)
  inspect(initial.count, content="42")
}

///|
test "set helper - after store creation" {
  let mut set_fn_ref : @zustand.SetFn[CounterState]? = None
  let store : @zustand.Store[CounterState] = @zustand.createStore(fn(
    set_fn,
    _get,
    _api,
  ) {
    set_fn_ref = Some(set_fn)
    { count: 0 }
  })
  // Call set after store is initialized
  match set_fn_ref {
    Some(set_fn) => @zustand.set(set_fn, fn(prev) { { count: prev.count + 1 } })
    None => ()
  }
  let state = @zustand.getState(store)
  inspect(state.count, content="1")
}

///|
test "get helper - after store creation" {
  let mut get_fn_ref : @zustand.GetFn[CounterState]? = None
  let mut set_fn_ref : @zustand.SetFn[CounterState]? = None
  let store : @zustand.Store[CounterState] = @zustand.createStore(fn(
    set_fn,
    get_fn,
    _api,
  ) {
    set_fn_ref = Some(set_fn)
    get_fn_ref = Some(get_fn)
    { count: 5 }
  })
  // Call get and set after store is initialized
  match (set_fn_ref, get_fn_ref) {
    (Some(set_fn), Some(get_fn)) => {
      let current = @zustand.get(get_fn)
      @zustand.set(set_fn, fn(_) { { count: current.count * 2 } })
    }
    _ => ()
  }
  let state = @zustand.getState(store)
  inspect(state.count, content="10")
}

///| Struct with multiple fields

///|
struct UserState {
  name : String
  age : Int
}

///|
test "createStore - multiple fields struct" {
  let store : @zustand.Store[UserState] = @zustand.createStore(fn(
    _set,
    _get,
    _api,
  ) {
    { name: "Alice", age: 30 }
  })
  let state = @zustand.getState(store)
  inspect(state.name, content="Alice")
  inspect(state.age, content="30")
}

///|
test "setState - update multiple fields" {
  let store : @zustand.Store[UserState] = @zustand.createStore(fn(
    _set,
    _get,
    _api,
  ) {
    { name: "Alice", age: 30 }
  })
  @zustand.setState(store, fn(prev) { { name: prev.name, age: prev.age + 1 } })
  let state = @zustand.getState(store)
  inspect(state.name, content="Alice")
  inspect(state.age, content="31")
}
