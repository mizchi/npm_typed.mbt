///|
/// Simple test that verifies the bindings compile and basic types work
test "zx: types compile" {
  // Test that types exist and have expected methods
  // This is a compile-time check
  fn _test_process_output_methods(output : @zx.ProcessOutput) -> Unit {
    let _ : String = output.stdout()
    let _ : String = output.stderr()
    let _ : Int = output.exit_code()
    let _ : String? = output.signal()
    let _ : String = output.text()
    let _ : Array[String] = output.lines()
    let _ : @core.Any = output.json()
    ()
  }

  fn _test_process_promise_methods(pp : @zx.ProcessPromise) -> Unit {
    let _ : @zx.ProcessPromise = pp.nothrow()
    let _ : @zx.ProcessPromise = pp.quiet()
    let _ : @zx.ProcessPromise = pp.verbose()
    let _ : @zx.ProcessPromise = pp.timeout(1000)
    let _ : @core.Promise[@zx.ProcessOutput] = pp.to_promise()
    let _ : @core.Promise[Int] = pp.exit_code()
    let _ : @core.Promise[String] = pp.text()
    let _ : @core.Promise[Array[String]] = pp.lines()
    let _ : @core.Promise[@core.Any] = pp.json()
    ()
  }

  ignore(_test_process_output_methods)
  ignore(_test_process_promise_methods)
}

///|
/// Test ToZxArg trait implementations
test "zx: ToZxArg trait" {
  // Test that various types implement ToZxArg via @zx.arg()
  fn _test_to_zx_arg() -> Unit {
    // String
    let _ : @core.Any = @zx.arg("hello")
    // Int
    let _ : @core.Any = @zx.arg(42)
    // Double
    let _ : @core.Any = @zx.arg(3.14)
    // Bool
    let _ : @core.Any = @zx.arg(true)
    // Array[String]
    let _ : @core.Any = @zx.arg(["a", "b", "c"])
    ()
  }

  ignore(_test_to_zx_arg)
}
