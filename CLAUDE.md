# AGENTS.md - npm_typed

MoonBit FFI bindings for npm packages. See [CONTRIBUTING.md](CONTRIBUTING.md) for quick start.

## Project Structure

```
<package_name>/
  moon.pkg.json      # Package config
  <name>.mbt         # FFI bindings
  <name>_test.mbt    # Tests
  README.mbt.md      # Executable docs (`mbt test` blocks)
  README.md          # Symlink to README.mbt.md
```

## Creating a New Library

```bash
./_scripts/new-library.sh <package_name> [npm_package_name]
```

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
