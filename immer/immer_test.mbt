///|
extern "js" fn ffi_to_string(v : @core.Any) -> String =
  #| (v) => String(v)

///|
struct State {
  mut name : String
  age : Int
}

///|
test "produce - struct mutation" {
  let state : State = { name: "Alice", age: 30 }
  let next = @immer.produce(state, fn(draft) { draft.name = "Bob" })
  // Original unchanged
  inspect(state.name, content="Alice")
  // Next has new value
  inspect(next.name, content="Bob")
  // Unchanged values are preserved
  inspect(next.age, content="30")
}

///|
struct Counter {
  mut count : Int
}

///|
test "produce - simple counter struct" {
  let state : Counter = { count: 0 }
  let next = @immer.produce(state, fn(draft) { draft.count = draft.count + 1 })
  inspect(state.count, content="0")
  inspect(next.count, content="1")
}

///|
test "produce_curried - struct" {
  let increment = @immer.produce_curried(fn(draft : Counter) {
    draft.count = draft.count + 1
  })
  let state : Counter = { count: 5 }
  let next = increment(state)
  inspect(state.count, content="5")
  inspect(next.count, content="6")
}

///|
test "isDraft - struct" {
  let state : Counter = { count: 0 }
  inspect(@immer.isDraft(state), content="false")
  let mut was_draft = false
  let _ = @immer.produce(state, fn(draft) { was_draft = @immer.isDraft(draft) })
  inspect(was_draft, content="true")
}

///|
test "createDraft/finishDraft - struct" {
  let state : Counter = { count: 10 }
  let draft = @immer.createDraft(state)
  draft.count = 20
  let next = @immer.finishDraft(draft)
  inspect(state.count, content="10")
  inspect(next.count, content="20")
}

///|
test "produce - basic mutation" {
  let state = @core.new_object()
  state["name"] = @core.any("Alice")
  state["age"] = @core.any(30)
  let next = @immer.produce(state, fn(draft) {
    draft["name"] = @core.any("Bob")
  })
  // Original unchanged
  inspect(ffi_to_string(state["name"]), content="Alice")
  // Next has new value
  inspect(ffi_to_string(next["name"]), content="Bob")
  // Unchanged values are preserved
  inspect(ffi_to_string(next["age"]), content="30")
}

///|
extern "js" fn ffi_array_push(arr : @core.Any, val : @core.Any) -> Unit =
  #| (arr, val) => arr.push(val)

///|
test "produce - array mutation" {
  let state = @core.new_object()
  let items = @core.new_array()
  ffi_array_push(items, @core.any(1))
  ffi_array_push(items, @core.any(2))
  state["items"] = items
  let next = @immer.produce(state, fn(draft) {
    ffi_array_push(draft["items"], @core.any(3))
  })
  // Original unchanged
  inspect(ffi_to_string(state["items"]["length"]), content="2")
  // Next has new item
  inspect(ffi_to_string(next["items"]["length"]), content="3")
}

///|
test "isDraft - returns false for regular objects" {
  let obj = @core.new_object()
  inspect(@immer.isDraft(obj), content="false")
}

///|
test "isDraft - returns true inside produce" {
  let state = @core.new_object()
  let mut was_draft = false
  let _ = @immer.produce(state, fn(draft) { was_draft = @immer.isDraft(draft) })
  inspect(was_draft, content="true")
}

///|
test "original - get original state in draft" {
  let state = @core.new_object()
  state["x"] = @core.any(1)
  let mut orig_x = 0
  let _ = @immer.produce(state, fn(draft) {
    draft["x"] = @core.any(99)
    let orig = @immer.original(draft)
    orig_x = @core.identity(orig["x"])
  })
  inspect(orig_x, content="1")
}

///|
test "createDraft/finishDraft - low-level API" {
  let state = @core.new_object()
  state["value"] = @core.any(10)
  let draft = @immer.createDraft(state)
  draft["value"] = @core.any(20)
  let next = @immer.finishDraft(draft)
  // Original unchanged
  inspect(ffi_to_string(state["value"]), content="10")
  // Next has new value
  inspect(ffi_to_string(next["value"]), content="20")
}

///|
test "setAutoFreeze - configuration" {
  // Should not throw
  @immer.setAutoFreeze(false)
  @immer.setAutoFreeze(true)
  inspect(true, content="true")
}

///|
test "freeze - freezes object" {
  let obj = @core.new_object()
  obj["a"] = @core.any(1)
  let frozen = @immer.freeze(obj)
  inspect(@core.typeof_(frozen), content="object")
}
