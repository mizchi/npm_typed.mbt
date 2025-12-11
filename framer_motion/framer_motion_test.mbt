///|
test "stagger - creates delay function" {
  let delay_fn = @framer_motion.stagger(0.1)
  inspect(@core.typeof_(delay_fn), content="function")
}

///|
test "mix - interpolates values" {
  // mix(0, 100, 0.5) should return 50
  let result = @framer_motion.mix(0.0, 100.0, 0.5)
  inspect(result, content="50")
}

///|
test "mix - at boundaries" {
  inspect(@framer_motion.mix(0.0, 100.0, 0.0), content="0")
  inspect(@framer_motion.mix(0.0, 100.0, 1.0), content="100")
}

///|
test "motionValue - creates motion value" {
  let mv = @framer_motion.motionValue(@core.any(0))
  inspect(@core.typeof_(mv), content="object")
}

///|
test "motionValue - get and set" {
  let mv = @framer_motion.motionValue(@core.any(42))
  let initial : Int = @core.identity(@framer_motion.mv_get(mv))
  inspect(initial, content="42")
  @framer_motion.mv_set(mv, @core.any(100))
  let updated : Int = @core.identity(@framer_motion.mv_get(mv))
  inspect(updated, content="100")
}

///|
test "animationControls - creates controls" {
  let controls = @framer_motion.animationControls()
  inspect(@core.typeof_(@core.identity(controls)), content="object")
}

///|
test "delay - returns cancel function" {
  let mut called = false
  let cancel = @framer_motion.delay(fn() { called = true }, 1000.0)
  // Cancel immediately so the callback doesn't run
  cancel()
  inspect(called, content="false")
}
