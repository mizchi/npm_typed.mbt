///|
/// framer-motion - A production-ready motion library for React
/// https://www.framer.com/motion/

///| Animation Controls type

///|
#external
pub type AnimationControls

///|
#external
pub type AnimationPlaybackControls

///| Core animate function

///|
#module("framer-motion")
extern "js" fn ffi_animate(
  element : @core.Any,
  keyframes : @core.Any,
  options : @core.Any,
) -> AnimationPlaybackControls = "animate"

///|
/// Animate elements with keyframes and options (raw version)
///
/// Example:
/// ```moonbit
/// let controls = animate(
///   @core.any(".box"),
///   { "x": @core.any(100), "opacity": @core.any(1) },
///   { "duration": @core.any(0.5) },
/// )
/// ```
pub fn animate(
  element : @core.Any,
  keyframes : @core.Any,
  options? : @core.Any,
) -> AnimationPlaybackControls {
  ffi_animate(element, keyframes, options.unwrap_or(@core.undefined()))
}

///|
/// Animate a DOM Element with keyframes and options
pub fn animate_element(
  element : @dom.Element,
  keyframes : @core.Any,
  options? : @core.Any,
) -> AnimationPlaybackControls {
  ffi_animate(element.as_any(), keyframes, options.unwrap_or(@core.undefined()))
}

///|
/// Animate a DOM HTMLElement with keyframes and options
pub fn animate_html_element(
  element : @dom.HTMLElement,
  keyframes : @core.Any,
  options? : @core.Any,
) -> AnimationPlaybackControls {
  ffi_animate(element.as_any(), keyframes, options.unwrap_or(@core.undefined()))
}

///|
/// Animate elements by CSS selector
pub fn animate_selector(
  selector : String,
  keyframes : @core.Any,
  options? : @core.Any,
) -> AnimationPlaybackControls {
  ffi_animate(
    @core.any(selector),
    keyframes,
    options.unwrap_or(@core.undefined()),
  )
}

///| Stagger function for sequential animations

///|
#module("framer-motion")
extern "js" fn ffi_stagger(duration : Double, options : @core.Any) -> @core.Any = "stagger"

///|
/// Create a stagger function for delaying animations
///
/// Example:
/// ```moonbit
/// let delay = stagger(0.1)
/// animate(@core.any("li"), keyframes, { "delay": delay })
/// ```
pub fn stagger(duration : Double, options? : @core.Any) -> @core.Any {
  ffi_stagger(duration, options.unwrap_or(@core.undefined()))
}

///| Spring animation - use "spring" as type in transition options
/// Example: { "type": "spring", "stiffness": 100, "damping": 10 }

///| Easing - use string names in transition options
/// Example: { "ease": "easeIn" } or { "ease": [0.4, 0, 0.2, 1] }

///| Animation playback controls

///|
extern "js" fn ffi_controls_stop(controls : AnimationPlaybackControls) -> Unit =
  #| (controls) => controls.stop()

///|
/// Stop the animation
pub fn stop(controls : AnimationPlaybackControls) -> Unit {
  ffi_controls_stop(controls)
}

///|
extern "js" fn ffi_controls_play(controls : AnimationPlaybackControls) -> Unit =
  #| (controls) => controls.play()

///|
/// Play the animation
pub fn play(controls : AnimationPlaybackControls) -> Unit {
  ffi_controls_play(controls)
}

///|
extern "js" fn ffi_controls_pause(controls : AnimationPlaybackControls) -> Unit =
  #| (controls) => controls.pause()

///|
/// Pause the animation
pub fn pause(controls : AnimationPlaybackControls) -> Unit {
  ffi_controls_pause(controls)
}

///|
extern "js" fn ffi_controls_cancel(
  controls : AnimationPlaybackControls,
) -> Unit =
  #| (controls) => controls.cancel()

///|
/// Cancel the animation
pub fn cancel(controls : AnimationPlaybackControls) -> Unit {
  ffi_controls_cancel(controls)
}

///|
extern "js" fn ffi_controls_complete(
  controls : AnimationPlaybackControls,
) -> Unit =
  #| (controls) => controls.complete()

///|
/// Complete the animation immediately
pub fn complete(controls : AnimationPlaybackControls) -> Unit {
  ffi_controls_complete(controls)
}

///|
extern "js" fn ffi_controls_then(
  controls : AnimationPlaybackControls,
  callback : () -> Unit,
) -> @core.Promise[Unit] =
  #| (controls, callback) => controls.then(callback)

///|
/// Execute callback when animation completes
pub fn then_(
  controls : AnimationPlaybackControls,
  callback : () -> Unit,
) -> @core.Promise[Unit] {
  ffi_controls_then(controls, callback)
}

///| Scroll-triggered animations

///|
#module("framer-motion")
extern "js" fn ffi_scroll(callback : (@core.Any) -> Unit) -> () -> Unit = "scroll"

///|
/// Create scroll-triggered animation
/// Callback receives scroll progress (0-1)
pub fn scroll(callback : (@core.Any) -> Unit) -> () -> Unit {
  ffi_scroll(callback)
}

///|
#module("framer-motion")
extern "js" fn ffi_inView(
  element : @core.Any,
  callback : (@core.Any) -> Unit,
  options : @core.Any,
) -> () -> Unit = "inView"

///|
/// Trigger callback when element enters/exits viewport (raw version)
pub fn inView(
  element : @core.Any,
  callback : (@core.Any) -> Unit,
  options? : @core.Any,
) -> () -> Unit {
  ffi_inView(element, callback, options.unwrap_or(@core.undefined()))
}

///|
/// Trigger callback when DOM Element enters/exits viewport
pub fn inView_element(
  element : @dom.Element,
  callback : (@core.Any) -> Unit,
  options? : @core.Any,
) -> () -> Unit {
  ffi_inView(element.as_any(), callback, options.unwrap_or(@core.undefined()))
}

///|
/// Trigger callback when element matching selector enters/exits viewport
pub fn inView_selector(
  selector : String,
  callback : (@core.Any) -> Unit,
  options? : @core.Any,
) -> () -> Unit {
  ffi_inView(
    @core.any(selector),
    callback,
    options.unwrap_or(@core.undefined()),
  )
}

///| Delay utility

///|
#module("framer-motion")
extern "js" fn ffi_delay(callback : () -> Unit, time : Double) -> () -> Unit = "delay"

///|
/// Delay execution of a callback
pub fn delay(callback : () -> Unit, time : Double) -> () -> Unit {
  ffi_delay(callback, time)
}

///| Animation controls factory

///|
#module("framer-motion")
extern "js" fn ffi_animationControls() -> AnimationControls = "animationControls"

///|
/// Create animation controls for imperative control
pub fn animationControls() -> AnimationControls {
  ffi_animationControls()
}

///|
extern "js" fn ffi_animation_controls_start(
  controls : AnimationControls,
  definition : @core.Any,
) -> @core.Promise[Unit] =
  #| (controls, definition) => controls.start(definition)

///|
/// Start an animation with the given definition
pub fn start(
  controls : AnimationControls,
  definition : @core.Any,
) -> @core.Promise[Unit] {
  ffi_animation_controls_start(controls, definition)
}

///|
extern "js" fn ffi_animation_controls_stop(
  controls : AnimationControls,
) -> Unit =
  #| (controls) => controls.stop()

///|
/// Stop all animations
pub fn stop_controls(controls : AnimationControls) -> Unit {
  ffi_animation_controls_stop(controls)
}

///| MotionValue for reactive values

///|
#module("framer-motion")
extern "js" fn ffi_motionValue(initial : @core.Any) -> @core.Any = "motionValue"

///|
/// Create a motion value for reactive animations
pub fn motionValue(initial : @core.Any) -> @core.Any {
  ffi_motionValue(initial)
}

///|
extern "js" fn ffi_motion_value_get(mv : @core.Any) -> @core.Any =
  #| (mv) => mv.get()

///|
/// Get the current value
pub fn mv_get(mv : @core.Any) -> @core.Any {
  ffi_motion_value_get(mv)
}

///|
extern "js" fn ffi_motion_value_set(mv : @core.Any, value : @core.Any) -> Unit =
  #| (mv, value) => mv.set(value)

///|
/// Set the value
pub fn mv_set(mv : @core.Any, value : @core.Any) -> Unit {
  ffi_motion_value_set(mv, value)
}

///|
extern "js" fn ffi_motion_value_on(
  mv : @core.Any,
  event : String,
  callback : (@core.Any) -> Unit,
) -> () -> Unit =
  #| (mv, event, callback) => mv.on(event, callback)

///|
/// Subscribe to motion value events ("change", "animationStart", etc.)
pub fn mv_on(
  mv : @core.Any,
  event : String,
  callback : (@core.Any) -> Unit,
) -> () -> Unit {
  ffi_motion_value_on(mv, event, callback)
}

///| Transform utility

///|
#module("framer-motion")
extern "js" fn ffi_transform(
  value : @core.Any,
  input_range : Array[Double],
  output_range : Array[@core.Any],
) -> @core.Any = "transform"

///|
/// Transform a value from one range to another
pub fn transform(
  value : @core.Any,
  input_range : Array[Double],
  output_range : Array[@core.Any],
) -> @core.Any {
  ffi_transform(value, input_range, output_range)
}

///| Mix/interpolate values

///|
#module("framer-motion")
extern "js" fn ffi_mix(from : Double, to : Double, progress : Double) -> Double = "mix"

///|
/// Mix two values by progress (0-1)
pub fn mix(from : Double, to : Double, progress : Double) -> Double {
  ffi_mix(from, to, progress)
}
