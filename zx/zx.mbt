///| npm zx package FFI bindings
/// https://www.npmjs.com/package/zx
/// Shell scripting with JavaScript, now with MoonBit bindings

///| ToZxArg trait - types that can be used as zx template arguments

///|
/// Trait for types that can be used as arguments in zx template strings.
/// Implement this trait for custom types to use them in `zx()` calls.
///
/// Example:
/// ```moonbit
/// let name = "hello"
/// let count = 42
/// @zx.zx("echo ${@0} ${@1}", args=[name.to_zx_arg(), count.to_zx_arg()])
/// ```
pub trait ToZxArg {
  to_zx_arg(Self) -> @core.Any
}

///|
pub impl ToZxArg for String with to_zx_arg(self) {
  @core.any(self)
}

///|
pub impl ToZxArg for Int with to_zx_arg(self) {
  @core.any(self)
}

///|
pub impl ToZxArg for Double with to_zx_arg(self) {
  @core.any(self)
}

///|
pub impl ToZxArg for Bool with to_zx_arg(self) {
  @core.any(self)
}

///|
/// Array of strings - will be joined with spaces in shell
pub impl ToZxArg for Array[String] with to_zx_arg(self) {
  @core.any(self)
}

///|
/// Convenience function to convert any ToZxArg type to @core.Any.
/// Use this to build args array for zx().
///
/// Example:
/// ```moonbit
/// let name = "hello"
/// let count = 42
/// @zx.zx("echo ${@0} ${@1}", args=[@zx.arg(name), @zx.arg(count)])
/// ```
pub fn[T : ToZxArg] arg(value : T) -> @core.Any {
  value.to_zx_arg()
}

///| Core Types

///|
/// ProcessPromise - returned by $`` template
/// Can be awaited to get ProcessOutput
#external
pub type ProcessPromise

///|
pub fn ProcessPromise::to_any(self : ProcessPromise) -> @core.Any = "%identity"

///|
/// ProcessPromise can be used as zx argument (for piping)
pub impl ToZxArg for ProcessPromise with to_zx_arg(self) {
  self.to_any()
}

///|
/// Convert ProcessPromise to @core.Promise[ProcessOutput]
pub fn ProcessPromise::to_promise(
  self : ProcessPromise,
) -> @core.Promise[ProcessOutput] {
  @core.identity(self.to_any())
}

///|
/// Run the command and wait for result
///
/// NOTE: This method does not exist in the original zx library.
/// It is added for MoonBit convenience to avoid verbose `.to_promise().wait()` chains.
/// In JavaScript zx, you would use `await $\`cmd\`` directly.
pub async fn ProcessPromise::run(self : ProcessPromise) -> ProcessOutput {
  self.to_promise().wait()
}

///|
/// ProcessOutput - result of awaited command
#external
pub type ProcessOutput

///|
pub fn ProcessOutput::to_any(self : ProcessOutput) -> @core.Any = "%identity"

///|
/// ProcessOutput can be used as zx argument
pub impl ToZxArg for ProcessOutput with to_zx_arg(self) {
  self.to_any()
}

///|
/// Get stdout as string
extern "js" fn ffi_get_stdout(output : ProcessOutput) -> String =
  #| (o) => o.stdout

///|
pub fn ProcessOutput::stdout(self : ProcessOutput) -> String {
  ffi_get_stdout(self)
}

///|
/// Get stderr as string
extern "js" fn ffi_get_stderr(output : ProcessOutput) -> String =
  #| (o) => o.stderr

///|
pub fn ProcessOutput::stderr(self : ProcessOutput) -> String {
  ffi_get_stderr(self)
}

///|
/// Get exit code
extern "js" fn ffi_get_exitCode(output : ProcessOutput) -> Int =
  #| (o) => o.exitCode

///|
pub fn ProcessOutput::exit_code(self : ProcessOutput) -> Int {
  ffi_get_exitCode(self)
}

///|
/// Get signal if process was killed
extern "js" fn ffi_get_signal(output : ProcessOutput) -> @core.Any =
  #| (o) => o.signal

///|
pub fn ProcessOutput::signal(self : ProcessOutput) -> String? {
  let sig = ffi_get_signal(self)
  if @core.is_null(sig) || @core.is_undefined(sig) {
    None
  } else {
    Some(sig.to_string())
  }
}

///|
/// Get output as string (trimmed stdout)
extern "js" fn ffi_output_to_string(output : ProcessOutput) -> String =
  #| (o) => o.toString()

///|
pub fn ProcessOutput::text(self : ProcessOutput) -> String {
  ffi_output_to_string(self)
}

///|
/// Get output lines
extern "js" fn ffi_output_lines(output : ProcessOutput) -> Array[String] =
  #| (o) => o.lines()

///|
pub fn ProcessOutput::lines(self : ProcessOutput) -> Array[String] {
  ffi_output_lines(self)
}

///|
/// Parse output as JSON
extern "js" fn ffi_output_json(output : ProcessOutput) -> @core.Any =
  #| (o) => o.json()

///|
pub fn ProcessOutput::json(self : ProcessOutput) -> @core.Any {
  ffi_output_json(self)
}

///| ProcessPromise Methods

///|
/// Get exit code without throwing on non-zero
extern "js" fn ffi_pp_exitCode(pp : ProcessPromise) -> @core.Promise[Int] =
  #| (pp) => pp.exitCode

///|
pub fn ProcessPromise::exit_code(self : ProcessPromise) -> @core.Promise[Int] {
  ffi_pp_exitCode(self)
}

///|
/// Get output as text
extern "js" fn ffi_pp_text(pp : ProcessPromise) -> @core.Promise[String] =
  #| (pp) => pp.text()

///|
pub fn ProcessPromise::text(self : ProcessPromise) -> @core.Promise[String] {
  ffi_pp_text(self)
}

///|
/// Get output as lines
extern "js" fn ffi_pp_lines(
  pp : ProcessPromise,
) -> @core.Promise[Array[String]] =
  #| (pp) => pp.lines()

///|
pub fn ProcessPromise::lines(
  self : ProcessPromise,
) -> @core.Promise[Array[String]] {
  ffi_pp_lines(self)
}

///|
/// Parse output as JSON
extern "js" fn ffi_pp_json(pp : ProcessPromise) -> @core.Promise[@core.Any] =
  #| (pp) => pp.json()

///|
pub fn ProcessPromise::json(self : ProcessPromise) -> @core.Promise[@core.Any] {
  ffi_pp_json(self)
}

///|
/// nothrow - don't throw on non-zero exit code
extern "js" fn ffi_pp_nothrow(pp : ProcessPromise) -> ProcessPromise =
  #| (pp) => pp.nothrow()

///|
pub fn ProcessPromise::nothrow(self : ProcessPromise) -> ProcessPromise {
  ffi_pp_nothrow(self)
}

///|
/// quiet - suppress verbose output
extern "js" fn ffi_pp_quiet(pp : ProcessPromise) -> ProcessPromise =
  #| (pp) => pp.quiet()

///|
pub fn ProcessPromise::quiet(self : ProcessPromise) -> ProcessPromise {
  ffi_pp_quiet(self)
}

///|
/// verbose - enable verbose output
extern "js" fn ffi_pp_verbose(pp : ProcessPromise) -> ProcessPromise =
  #| (pp) => pp.verbose()

///|
pub fn ProcessPromise::verbose(self : ProcessPromise) -> ProcessPromise {
  ffi_pp_verbose(self)
}

///|
/// timeout - set timeout in milliseconds
extern "js" fn ffi_pp_timeout(pp : ProcessPromise, ms : Int) -> ProcessPromise =
  #| (pp, ms) => pp.timeout(ms)

///|
pub fn ProcessPromise::timeout(
  self : ProcessPromise,
  ms : Int,
) -> ProcessPromise {
  ffi_pp_timeout(self, ms)
}

///|
/// kill - terminate the process
extern "js" fn ffi_pp_kill(pp : ProcessPromise, signal : @core.Any) -> Unit =
  #| (pp, signal) => pp.kill(signal)

///|
pub fn ProcessPromise::kill(self : ProcessPromise, signal? : String) -> Unit {
  match signal {
    Some(s) => ffi_pp_kill(self, @core.any(s))
    None => ffi_pp_kill(self, @core.undefined())
  }
}

///|
/// abort - abort using AbortController
extern "js" fn ffi_pp_abort(pp : ProcessPromise, reason : @core.Any) -> Unit =
  #| (pp, reason) => pp.abort(reason)

///|
pub fn ProcessPromise::abort(self : ProcessPromise, reason? : String) -> Unit {
  match reason {
    Some(r) => ffi_pp_abort(self, @core.any(r))
    None => ffi_pp_abort(self, @core.undefined())
  }
}

///|
/// pipe to another process or stream
extern "js" fn ffi_pp_pipe(
  pp : ProcessPromise,
  dest : @core.Any,
) -> ProcessPromise =
  #| (pp, dest) => pp.pipe(dest)

///|
pub fn ProcessPromise::pipe(
  self : ProcessPromise,
  dest : ProcessPromise,
) -> ProcessPromise {
  ffi_pp_pipe(self, dest.to_any())
}

///| Core $ function implementation

///|
/// Load zx module
extern "js" fn require_zx() -> @core.Any =
  #| () => require("zx")

///|
/// Get the $ function from zx
fn get_dollar() -> @core.Any {
  require_zx()["$"]
}

///|
/// Call $ with template strings and values
extern "js" fn ffi_call_dollar(
  dollar_fn : @core.Any,
  strings : @core.TemplateStringsArray,
  values : Array[@core.Any],
) -> ProcessPromise =
  #| (dollar_fn, strings, values) => dollar_fn(strings, ...values)

///|
/// Execute shell command using tagged template syntax
/// MoonBit では $ は変数として使えないので zx を使用
///
/// Example:
/// ```moonbit
/// let result = @zx.zx("echo ${@0}", args=[@core.any("hello")])
/// ```
pub fn zx(cmd : String, args? : Array[@core.Any] = []) -> ProcessPromise {
  @core.tag(
    fn(strings, values) { ffi_call_dollar(get_dollar(), strings, values) },
    cmd,
    args,
  )
}

///|
/// Execute shell command and wait for result (async convenience function)
///
/// NOTE: This function does not exist in the original zx library.
/// It is added for MoonBit convenience, similar to how execa works.
/// Use this in async contexts for simpler code.
///
/// Example:
/// ```moonbit
/// let output = @zx.exec("echo hello")
/// println(output.text())
/// ```
pub async fn exec(cmd : String, args? : Array[@core.Any] = []) -> ProcessOutput {
  zx(cmd, args~).to_promise().wait()
}

///| Utility Functions

///|
/// cd - change working directory
fn get_cd() -> @core.Any {
  require_zx()["cd"]
}

///|
extern "js" fn ffi_call_cd(cd_fn : @core.Any, path : String) -> Unit =
  #| (cd_fn, path) => cd_fn(path)

///|
pub fn cd(path : String) -> Unit {
  ffi_call_cd(get_cd(), path)
}

///|
/// sleep - wait for specified milliseconds
fn get_sleep() -> @core.Any {
  require_zx()["sleep"]
}

///|
extern "js" fn ffi_call_sleep(
  sleep_fn : @core.Any,
  ms : Int,
) -> @core.Promise[Unit] =
  #| (sleep_fn, ms) => sleep_fn(ms)

///|
pub fn sleep(ms : Int) -> @core.Promise[Unit] {
  ffi_call_sleep(get_sleep(), ms)
}

///|
/// echo - print to stdout
fn get_echo() -> @core.Any {
  require_zx()["echo"]
}

///|
extern "js" fn ffi_call_echo(
  echo_fn : @core.Any,
  args : Array[@core.Any],
) -> Unit =
  #| (echo_fn, args) => echo_fn(...args)

///|
pub fn echo(messages : Array[@core.Any]) -> Unit {
  ffi_call_echo(get_echo(), messages)
}

///|
/// stdin - read from standard input
fn get_stdin() -> @core.Any {
  require_zx()["stdin"]
}

///|
extern "js" fn ffi_call_stdin(stdin_fn : @core.Any) -> @core.Promise[String] =
  #| (stdin_fn) => stdin_fn()

///|
pub fn stdin() -> @core.Promise[String] {
  ffi_call_stdin(get_stdin())
}

///|
/// which - find executable path
fn get_which() -> @core.Any {
  require_zx()["which"]
}

///|
extern "js" fn ffi_call_which(
  which_fn : @core.Any,
  name : String,
) -> @core.Promise[String] =
  #| (which_fn, name) => which_fn(name)

///|
pub fn which(name : String) -> @core.Promise[String] {
  ffi_call_which(get_which(), name)
}

///|
/// retry - retry a function multiple times
fn get_retry() -> @core.Any {
  require_zx()["retry"]
}

///|
extern "js" fn ffi_call_retry(
  retry_fn : @core.Any,
  count : Int,
  fn_ : @core.Any,
) -> @core.Promise[@core.Any] =
  #| (retry_fn, count, fn_) => retry_fn(count, fn_)

///|
pub fn retry(
  count : Int,
  f : () -> @core.Promise[@core.Any],
) -> @core.Promise[@core.Any] {
  ffi_call_retry(get_retry(), count, @core.any(f))
}

///| Configuration

///|
/// Set verbose mode
extern "js" fn ffi_set_verbose(mod : @core.Any, value : Bool) -> Unit =
  #| (mod, value) => { mod.$.verbose = value }

///|
pub fn set_verbose(value : Bool) -> Unit {
  ffi_set_verbose(require_zx(), value)
}

///|
/// Get verbose mode
extern "js" fn ffi_get_verbose(mod : @core.Any) -> Bool =
  #| (mod) => mod.$.verbose

///|
pub fn get_verbose() -> Bool {
  ffi_get_verbose(require_zx())
}

///|
/// Set shell
extern "js" fn ffi_set_shell(mod : @core.Any, shell : String) -> Unit =
  #| (mod, shell) => { mod.$.shell = shell }

///|
pub fn set_shell(shell : String) -> Unit {
  ffi_set_shell(require_zx(), shell)
}

///|
/// Set cwd (working directory)
extern "js" fn ffi_set_cwd(mod : @core.Any, cwd : String) -> Unit =
  #| (mod, cwd) => { mod.$.cwd = cwd }

///|
pub fn set_cwd(cwd : String) -> Unit {
  ffi_set_cwd(require_zx(), cwd)
}

///|
/// Set environment variable
extern "js" fn ffi_set_env(
  mod : @core.Any,
  key : String,
  value : String,
) -> Unit =
  #| (mod, key, value) => { if (!mod.$.env) mod.$.env = {}; mod.$.env[key] = value }

///|
pub fn set_env(key : String, value : String) -> Unit {
  ffi_set_env(require_zx(), key, value)
}

///|
/// Set timeout (in milliseconds)
extern "js" fn ffi_set_timeout(mod : @core.Any, ms : Int) -> Unit =
  #| (mod, ms) => { mod.$.timeout = ms }

///|
pub fn set_timeout(ms : Int) -> Unit {
  ffi_set_timeout(require_zx(), ms)
}

///| Shell Presets

///|
/// Use bash shell
fn get_useBash() -> @core.Any {
  require_zx()["useBash"]
}

///|
extern "js" fn ffi_call_useBash(fn_ : @core.Any) -> Unit =
  #| (fn_) => fn_()

///|
pub fn use_bash() -> Unit {
  ffi_call_useBash(get_useBash())
}

///|
/// Use PowerShell
fn get_usePowerShell() -> @core.Any {
  require_zx()["usePowerShell"]
}

///|
extern "js" fn ffi_call_usePowerShell(fn_ : @core.Any) -> Unit =
  #| (fn_) => fn_()

///|
pub fn use_powershell() -> Unit {
  ffi_call_usePowerShell(get_usePowerShell())
}
