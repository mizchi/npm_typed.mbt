# TODO

## ESM Migration

**Goal**: Eliminate all `require()` calls → `git grep 'require('` should return nothing.

### Blocked Items

These items cannot use `#module` directive due to MoonBit limitations.

### `#module` Limitations

The `#module` directive can only be applied to **functions with fixed arguments**:

- **Class constructors**: `new Hono()`, `new SignJWT()`, `new Database()`
- **Factory functions**: `pino()`, `debug()`, `chalk()`
- **Method calls on objects**: `chalk.red()`, `semver.coerce`
- **Property access**: `path.delimiter`, `process.env`, `os.EOL`
- **Symbols**: `comlink.createEndpoint`, `comlink.releaseProxy`

Workarounds:
1. **Dynamic import**: Preferred for frontend-compatible packages
   ```moonbit
   extern "js" fn ffi_import_x() -> @core.Promise[@core.Any] =
     #| () => import("x")

   // wrap example
   #external
   pub type Foo
   pub async fn x_foo() -> Foo {
     let mod = ffi_import_x().wait()
     // x.foo
     mod["foo"].cast()
   }
   ```
2. **Inline require()**: Only for Node.js-only packages
   ```moonbit
   extern "js" fn ffi_x_fn() -> @core.Any =
     #| () => require('x').fn()
   ```

### Blocked Libraries

| Library | Reason |
|---------|--------|
| react_router | RouterProvider is a component, not a function. Uses `init_global()` workaround. |
| node:buffer | Buffer class static methods |
| node:http | All functions have callbacks/optional args |
| node:sqlite | Database class constructor |
| jose | `new SignJWT()` class constructor |
| pino | `pino()` factory function |
| debug | `debug()` factory function |
| chalk | `chalk.red()` method calls on object |
| vitest | Test runner internals |
| drizzle | Many functions, low priority |
| testing_library_* | `screen`, `fireEvent` are value exports (objects) |

---

## Known Issues

### jose package: Async test PanicError

Three async tests in `jose/jose_test.mbt` cause PanicError:
- `JWS compact sign and verify`
- `JWE compact encrypt and decrypt`
- `Generate secret key`

Tests are commented out with `// FIXME:` comments.

### Flaky tests with NEW_MOON=0

Running `NEW_MOON=0 moon test` occasionally fails with PanicError in async driver. This appears to be a flaky test issue with the legacy moon runtime.
