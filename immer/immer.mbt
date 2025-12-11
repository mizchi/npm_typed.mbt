///|
/// immer - Create the next immutable state by mutating the current one
/// https://immerjs.github.io/immer/

///| Core produce function

///|
#module("immer")
extern "js" fn ffi_produce(
  base : @core.Any,
  recipe : (@core.Any) -> Unit,
) -> @core.Any = "produce"

///|
/// Create the next immutable state by mutating the draft
///
/// Example:
/// ```moonbit
/// struct State { mut name: String }
/// let state = { name: "Alice" }
/// let next = produce(state, fn(draft) {
///   draft.name = "Bob"
/// })
/// ```
pub fn[T] produce(base : T, recipe : (T) -> Unit) -> T {
  @core.identity(
    ffi_produce(@core.any(base), fn(draft) { recipe(@core.identity(draft)) }),
  )
}

///| Curried producer - returns a function that produces

///|
#module("immer")
extern "js" fn ffi_produce_curried(
  recipe : (@core.Any) -> Unit,
) -> (@core.Any) -> @core.Any = "produce"

///|
/// Create a curried producer function
///
/// Example:
/// ```moonbit
/// let updater = produce_curried(fn(draft : State) {
///   draft.name = "Bob"
/// })
/// let next = updater(state)
/// ```
pub fn[T] produce_curried(recipe : (T) -> Unit) -> (T) -> T {
  let producer = ffi_produce_curried(fn(draft) { recipe(@core.identity(draft)) })
  fn(base : T) -> T { @core.identity(producer(@core.any(base))) }
}

///| Draft utilities

///|
#module("immer")
extern "js" fn ffi_isDraft(value : @core.Any) -> Bool = "isDraft"

///|
/// Check if a value is a draft
pub fn[T] isDraft(value : T) -> Bool {
  ffi_isDraft(@core.any(value))
}

///|
#module("immer")
extern "js" fn ffi_current(value : @core.Any) -> @core.Any = "current"

///|
/// Get the current state from a draft (snapshot during mutation)
pub fn[T] current(value : T) -> T {
  @core.identity(ffi_current(@core.any(value)))
}

///|
#module("immer")
extern "js" fn ffi_original(value : @core.Any) -> @core.Any = "original"

///|
/// Get the original state from a draft
pub fn[T] original(value : T) -> T {
  @core.identity(ffi_original(@core.any(value)))
}

///| Low-level draft API

///|
#module("immer")
extern "js" fn ffi_createDraft(base : @core.Any) -> @core.Any = "createDraft"

///|
/// Create a draft from a base state (low-level API)
/// Use with finishDraft for async operations
pub fn[T] createDraft(base : T) -> T {
  @core.identity(ffi_createDraft(@core.any(base)))
}

///|
#module("immer")
extern "js" fn ffi_finishDraft(draft : @core.Any) -> @core.Any = "finishDraft"

///|
/// Finish a draft and return the next immutable state
pub fn[T] finishDraft(draft : T) -> T {
  @core.identity(ffi_finishDraft(@core.any(draft)))
}

///| Configuration

///|
#module("immer")
extern "js" fn ffi_setAutoFreeze(freeze : Bool) -> Unit = "setAutoFreeze"

///|
/// Enable or disable auto-freezing of produced states
pub fn setAutoFreeze(freeze : Bool) -> Unit {
  ffi_setAutoFreeze(freeze)
}

///|
#module("immer")
extern "js" fn ffi_setUseStrictShallowCopy(use_strict : Bool) -> Unit = "setUseStrictShallowCopy"

///|
/// Enable or disable strict shallow copy mode
pub fn setUseStrictShallowCopy(use_strict : Bool) -> Unit {
  ffi_setUseStrictShallowCopy(use_strict)
}

///| Freeze utilities

///|
#module("immer")
extern "js" fn ffi_freeze(obj : @core.Any, deep : Bool) -> @core.Any = "freeze"

///|
/// Recursively freeze an object
pub fn[T] freeze(obj : T, deep~ : Bool = true) -> T {
  @core.identity(ffi_freeze(@core.any(obj), deep))
}
