# AGENTS.md - npm_typed

MoonBit FFI bindings for npm packages. See [CONTRIBUTING.md](CONTRIBUTING.md) for quick start.

## Project Structure

```
<package_name>/
  moon.pkg           # Package config
  <name>.mbt         # FFI bindings
  <name>_test.mbt    # Tests
  README.mbt.md      # Executable docs (`mbt test` blocks)
  README.md          # Symlink to README.mbt.md
```

`moon.pkg` / `moon.mod` use the TOML-ish `moon.pkg`/`moon.mod` format, not the
legacy `*.json` files:

```
import {
  "mizchi/js",
  "mizchi/js_core" @core,
  "mizchi/js_node/fs",
}

import {
  "moonbitlang/async",
} for "test"

supported_targets = "js"
```

## Creating a New Library

```bash
./_scripts/new-library.sh <package_name> [npm_package_name]
```

## Upstream js bindings

`mizchi/js` is a facade that re-exports `mizchi/js_core` + `mizchi/js_builtin`.
Environment-specific APIs live in separate modules; import the narrowest one
that covers what the binding needs:

| module | contents |
|--------|----------|
| `mizchi/js_core` | `Any`, `Promise`, `Nullable`, interop primitives (aliased `@core`) |
| `mizchi/js_builtin/*` | `object`, `array`, `json`, `regexp`, `symbol`, `global`, ... |
| `mizchi/js_web/*` | `http` (fetch), `streams`, `encoding`, `url`, `worker`, ... |
| `mizchi/js_node/*` | `fs`, `process`, `stream`, `tty`, `sqlite`, ... |
| `mizchi/js_browser/*` | `dom`, ... |
| `mizchi/js_convert` | MoonBit <-> JS value conversion |

## FFI Patterns

### Basic `#module` directive (ESM)

```moonbit
///|
#module("lodash")
pub extern "js" fn debounce(fn : @core.Any, wait : Int) -> @core.Any = "debounce"
```

### Classes (use inline JS)

```moonbit
///|
extern "js" fn ffi_new_client(config : @core.Any) -> Client =
  #| (config) => new (require("some-pkg").Client)(config)
```

### Dynamic import for non-functions

```moonbit
///|
extern "js" fn import_pkg() -> @js.Promise[@core.Any] =
  #| () => import("some-pkg")
```

### Limitations of `#module`

- ✅ Functions with fixed arguments
- ❌ Classes (`new X()`)
- ❌ Constants/Symbols
- ❌ Variadic functions

### Arrays across the FFI boundary

`Array[T]` is deprecated in `extern "js"` signatures. Declare the extern with
`FixedArray[T]` and keep `Array[T]` in the public wrapper:

```moonbit
///|
extern "js" fn ffi_clsx(args : FixedArray[@core.Any]) -> String = "clsx"

///|
pub fn clsx_raw(args : Array[@core.Any]) -> String {
  ffi_clsx(FixedArray::from_array(args[:]))
}
```

For returns, convert back with `Array::from_fixed_array(...)`.

## Testing

```bash
# Test specific package
moon test --package <package_name> --target js

# Test all
moon test --target js

# Update snapshots
moon test --update
```

## Code Style

- Blocks separated by `///|`
- Use `inspect()` for snapshot testing
- Run `moon fmt` before commit

## Resources

- [MoonBit JS FFI Best Practices](https://www.moonbitlang.com/pearls/moonbit-jsffi)
- [MoonBit Cheatsheet](./_examples/moonbit_cheatsheet.mbt.md)
