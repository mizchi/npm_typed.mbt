# mizchi/npm_typed/zx

MoonBit FFI bindings for [zx](https://www.npmjs.com/package/zx) - A tool for writing better shell scripts in JavaScript (and now MoonBit!).

## Installation

```bash
moon add mizchi/js
moon add mizchi/npm_typed
npm install zx
```

Add to your `moon.pkg.json`:

```json
{
  "import": [
    "mizchi/js",
    "mizchi/js/core",
    "mizchi/npm_typed/zx"
  ]
}
```

## Basic Usage

The main entry point is the `zx` function, which works like the `$` template literal in JavaScript zx.

```mbt nocheck
// Execute shell commands with .run()
let output = @zx.zx("echo hello").run()
println(output.text()) // "hello"

// With variable interpolation using ${@0}, ${@1}, etc.
// Use @zx.arg() to convert values to zx arguments
let name = "world"
let output = @zx.zx("echo ${@0}", args=[@zx.arg(name)]).run()
println(output.text()) // "world"

// Multiple arguments with different types
let count = 42
let output = @zx.zx("echo ${@0} ${@1}", args=[@zx.arg(name), @zx.arg(count)]).run()
```

## ProcessPromise Methods

The `zx` function returns a `ProcessPromise` that can be:

```mbt nocheck
// Simple execution with .run()

///|
let output = @zx.zx("ls -la").run()

// Chained with modifiers

///|
let output = @zx.zx("some-command")
  .nothrow() // Don't throw on non-zero exit
  .quiet() // Suppress verbose output
  .timeout(5000) // Set timeout in ms
  .run()

// Get results directly (still need .wait() for Promise methods)

///|
let text = @zx.zx("echo hello").text().wait()

///|
let lines = @zx.zx("ls").lines().wait()

///|
let exit_code = @zx.zx("exit 0").exit_code().wait()
```

## ProcessOutput Properties

```mbt nocheck
let output = @zx.zx("echo hello").to_promise().wait()

output.stdout()     // Standard output as string
output.stderr()     // Standard error as string
output.exit_code()  // Exit code (0 = success)
output.signal()     // Signal if killed (e.g., "SIGTERM")
output.text()       // Trimmed stdout
output.lines()      // Output split into lines
output.json()       // Parse output as JSON
```

## Utility Functions

```mbt nocheck
// Change working directory
@zx.cd("/tmp")

// Sleep for milliseconds
@zx.sleep(1000).wait()

// Print to stdout
@zx.echo([@core.any("Hello"), @core.any("World")])

// Find executable path
let path = @zx.which("node").wait()

// Retry function
let result = @zx.retry(3, fn() {
  @zx.zx("some-flaky-command").to_promise()
}).wait()
```

## Configuration

```mbt nocheck
// Set verbose mode (show commands being executed)
@zx.set_verbose(true)
let is_verbose = @zx.get_verbose()

// Set shell
@zx.set_shell("/bin/bash")

// Set working directory
@zx.set_cwd("/tmp")

// Set environment variable
@zx.set_env("NODE_ENV", "production")

// Set timeout
@zx.set_timeout(30000)

// Use bash shell
@zx.use_bash()

// Use PowerShell (Windows)
@zx.use_powershell()
```

## Piping Commands

```mbt nocheck
///|
let output = @zx.zx("echo 'hello world'").pipe(@zx.zx("grep hello")).run()
```

## Error Handling

By default, zx throws on non-zero exit codes. Use `nothrow()` to suppress:

```mbt nocheck
// This will throw if command fails
let output = @zx.zx("exit 1").run() // throws!

// This won't throw
let output = @zx.zx("exit 1").nothrow().run()
if output.exit_code() != 0 {
  println("Command failed with exit code: " + output.exit_code().to_string())
}
```

## ToZxArg Trait

The `ToZxArg` trait allows various types to be used as zx template arguments.
Use `@zx.arg()` helper function to convert values.

Built-in implementations:
- `String` - text values
- `Int` - integers
- `Double` - floating point numbers
- `Bool` - boolean values
- `Array[String]` - multiple arguments (joined with spaces)
- `ProcessPromise` - for piping
- `ProcessOutput` - previous command output

```mbt nocheck
// Using different types as arguments
let name = "file.txt"
let lines = 10
let verbose = true
let flags = ["-l", "-a"]

let output = @zx.zx("head -n ${@0} ${@1}", args=[@zx.arg(lines), @zx.arg(name)]).run()

// Custom types can implement ToZxArg trait
```

## API Reference

### Types

- `ProcessPromise` - Promise-like object returned by `zx()`
- `ProcessOutput` - Result of awaited command execution
- `ToZxArg` - Trait for types that can be used as zx arguments

### Functions

| Function | Description |
|----------|-------------|
| `zx(cmd, args?)` | Execute shell command |
| `exec(cmd, args?)` | Execute and wait (async convenience) |
| `arg(value)` | Convert ToZxArg value to Any |
| `cd(path)` | Change directory |
| `sleep(ms)` | Wait for milliseconds |
| `echo(messages)` | Print to stdout |
| `stdin()` | Read from standard input |
| `which(name)` | Find executable path |
| `retry(count, fn)` | Retry function |

### Configuration

| Function | Description |
|----------|-------------|
| `set_verbose(bool)` | Enable/disable verbose output |
| `get_verbose()` | Get verbose mode |
| `set_shell(path)` | Set shell path |
| `set_cwd(path)` | Set working directory |
| `set_env(key, value)` | Set environment variable |
| `set_timeout(ms)` | Set command timeout |
| `use_bash()` | Use bash shell |
| `use_powershell()` | Use PowerShell |

## See Also

- [zx npm package](https://www.npmjs.com/package/zx)
- [zx GitHub](https://github.com/google/zx)
