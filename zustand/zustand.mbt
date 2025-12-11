///|
/// zustand/vanilla - Bear necessities for state management
/// Framework-agnostic vanilla store
/// https://docs.pmnd.rs/zustand/guides/typescript#basic-usage

///| Store type (generic over state type T)

///|
#external
pub type Store[_]

///| Store creation

///|
#module("zustand/vanilla")
extern "js" fn ffi_createStore(
  initializer : (@core.Any, @core.Any, @core.Any) -> @core.Any,
) -> @core.Any = "createStore"

///|
/// Create a vanilla zustand store with typed state
///
/// Example:
/// ```moonbit
/// struct CounterState { mut count: Int }
/// let store : Store[CounterState] = createStore(fn(_set, _get, _api) {
///   { count: 0 }
/// })
/// ```
pub fn[T] createStore(initializer : (SetFn[T], GetFn[T], @core.Any) -> T) -> Store[T] {
  @core.identity(
    ffi_createStore(fn(set, get, api) {
      let set_fn : SetFn[T] = @core.identity(set)
      let get_fn : GetFn[T] = @core.identity(get)
      @core.any(initializer(set_fn, get_fn, api))
    }),
  )
}

///| Set and Get function types

///|
#external
pub type SetFn[_]

///|
#external
pub type GetFn[_]

///| Store methods

///|
extern "js" fn ffi_getState(store : @core.Any) -> @core.Any =
  #| (store) => store.getState()

///|
/// Get the current state from the store
pub fn[T] getState(store : Store[T]) -> T {
  @core.identity(ffi_getState(@core.any(store)))
}

///|
extern "js" fn ffi_setState(
  store : @core.Any,
  partial : @core.Any,
  replace : Bool,
) -> Unit =
  #| (store, partial, replace) => store.setState(partial, replace)

///|
/// Set state in the store with updater function
/// Note: MoonBit has no Partial<T>, so always return complete state
pub fn[T] setState(store : Store[T], updater : (T) -> T) -> Unit {
  ffi_setState(
    @core.any(store),
    @core.any(fn(prev : @core.Any) { @core.any(updater(@core.identity(prev))) }),
    true,
  )
}

///|
/// Replace state in the store directly
pub fn[T] replaceState(store : Store[T], state : T) -> Unit {
  ffi_setState(@core.any(store), @core.any(state), true)
}

///|
extern "js" fn ffi_subscribe(
  store : @core.Any,
  listener : (@core.Any, @core.Any) -> Unit,
) -> () -> Unit =
  #| (store, listener) => store.subscribe(listener)

///|
/// Subscribe to state changes
/// Returns an unsubscribe function
pub fn[T] subscribe(store : Store[T], listener : (T, T) -> Unit) -> () -> Unit {
  ffi_subscribe(@core.any(store), fn(state, prev) {
    listener(@core.identity(state), @core.identity(prev))
  })
}

///|
extern "js" fn ffi_subscribe_selector(
  store : @core.Any,
  selector : (@core.Any) -> @core.Any,
  listener : (@core.Any, @core.Any) -> Unit,
) -> () -> Unit =
  #| (store, selector, listener) => store.subscribe((state, prev) => {
  #|   const selected = selector(state);
  #|   const prevSelected = selector(prev);
  #|   if (selected !== prevSelected) listener(selected, prevSelected);
  #| })

///|
/// Subscribe to a slice of state changes
/// Only calls listener when the selected value changes
pub fn[T, U] subscribe_selector(
  store : Store[T],
  selector : (T) -> U,
  listener : (U, U) -> Unit,
) -> () -> Unit {
  ffi_subscribe_selector(
    @core.any(store),
    fn(state) { @core.any(selector(@core.identity(state))) },
    fn(selected, prev_selected) {
      listener(@core.identity(selected), @core.identity(prev_selected))
    },
  )
}

///|
extern "js" fn ffi_getInitialState(store : @core.Any) -> @core.Any =
  #| (store) => store.getInitialState()

///|
/// Get the initial state of the store
pub fn[T] getInitialState(store : Store[T]) -> T {
  @core.identity(ffi_getInitialState(@core.any(store)))
}

///| Helper for set function in createStore

///|
extern "js" fn ffi_call_set(
  set_fn : @core.Any,
  updater : (@core.Any) -> @core.Any,
) -> Unit =
  #| (set_fn, updater) => set_fn(updater)

///|
/// Call set function with an updater
pub fn[T] set(set_fn : SetFn[T], updater : (T) -> T) -> Unit {
  ffi_call_set(@core.any(set_fn), fn(prev) {
    @core.any(updater(@core.identity(prev)))
  })
}

///|
extern "js" fn ffi_call_set_partial(
  set_fn : @core.Any,
  partial : @core.Any,
) -> Unit =
  #| (set_fn, partial) => set_fn(partial)

///|
/// Call set function with a partial state
pub fn[T] set_partial(set_fn : SetFn[T], partial : T) -> Unit {
  ffi_call_set_partial(@core.any(set_fn), @core.any(partial))
}

///|
extern "js" fn ffi_call_get(get_fn : @core.Any) -> @core.Any =
  #| (get_fn) => get_fn()

///|
/// Call get function to get current state
pub fn[T] get(get_fn : GetFn[T]) -> T {
  @core.identity(ffi_call_get(@core.any(get_fn)))
}
