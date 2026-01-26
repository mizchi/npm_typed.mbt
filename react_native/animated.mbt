///| React Native Animated API
/// https://reactnative.dev/docs/animated

// ============================================================================
// Animated Value
// ============================================================================

///|
extern "js" fn ffi_animated_value(value : Double) -> @core.Any =
  #| (value) => new (require("react-native").Animated.Value)(value)

///|
extern "js" fn ffi_animated_value_xy(x : Double, y : Double) -> @core.Any =
  #| (x, y) => new (require("react-native").Animated.ValueXY)({ x, y })

///|
/// Animated.Value - Standard value for driving animations
#external
pub type AnimatedValue

///|
pub fn AnimatedValue::as_any(self : AnimatedValue) -> @core.Any = "%identity"

///|
pub fn AnimatedValue::new(value : Double) -> AnimatedValue {
  ffi_animated_value(value).cast()
}

///|
extern "js" fn ffi_animated_value_set_value(
  value : AnimatedValue,
  to_value : Double,
) -> Unit =
  #| (value, toValue) => value.setValue(toValue)

///|
extern "js" fn ffi_animated_value_set_offset(
  value : AnimatedValue,
  offset : Double,
) -> Unit =
  #| (value, offset) => value.setOffset(offset)

///|
extern "js" fn ffi_animated_value_flat_offset(value : AnimatedValue) -> Unit =
  #| (value) => value.flattenOffset()

///|
extern "js" fn ffi_animated_value_extract_offset(value : AnimatedValue) -> Unit =
  #| (value) => value.extractOffset()

///|
extern "js" fn ffi_animated_value_add_listener(
  value : AnimatedValue,
  callback : @core.Any,
) -> String =
  #| (value, callback) => value.addListener(callback)

///|
extern "js" fn ffi_animated_value_remove_listener(
  value : AnimatedValue,
  id : String,
) -> Unit =
  #| (value, id) => value.removeListener(id)

///|
extern "js" fn ffi_animated_value_remove_all_listeners(
  value : AnimatedValue,
) -> Unit =
  #| (value) => value.removeAllListeners()

///|
extern "js" fn ffi_animated_value_stop_animation(
  value : AnimatedValue,
  callback : @core.Any,
) -> Unit =
  #| (value, callback) => value.stopAnimation(callback)

///|
extern "js" fn ffi_animated_value_reset_animation(
  value : AnimatedValue,
  callback : @core.Any,
) -> Unit =
  #| (value, callback) => value.resetAnimation(callback)

///|
/// Set the value
pub fn AnimatedValue::set_value(self : AnimatedValue, value : Double) -> Unit {
  ffi_animated_value_set_value(self, value)
}

///|
/// Set the offset
pub fn AnimatedValue::set_offset(self : AnimatedValue, offset : Double) -> Unit {
  ffi_animated_value_set_offset(self, offset)
}

///|
/// Flatten the offset
pub fn AnimatedValue::flatten_offset(self : AnimatedValue) -> Unit {
  ffi_animated_value_flat_offset(self)
}

///|
/// Extract the offset
pub fn AnimatedValue::extract_offset(self : AnimatedValue) -> Unit {
  ffi_animated_value_extract_offset(self)
}

///|
/// Add a listener
pub fn AnimatedValue::add_listener(
  self : AnimatedValue,
  callback : (Double) -> Unit,
) -> String {
  let wrapped : (@core.Any) -> Unit = fn(state) {
    callback(state["value"].cast())
  }
  ffi_animated_value_add_listener(self, @js.from_fn1(wrapped))
}

///|
/// Remove a listener
pub fn AnimatedValue::remove_listener(
  self : AnimatedValue,
  id : String,
) -> Unit {
  ffi_animated_value_remove_listener(self, id)
}

///|
/// Remove all listeners
pub fn AnimatedValue::remove_all_listeners(self : AnimatedValue) -> Unit {
  ffi_animated_value_remove_all_listeners(self)
}

///|
/// Stop animation
pub fn AnimatedValue::stop_animation(
  self : AnimatedValue,
  callback? : ((Double) -> Unit)? = None,
) -> Unit {
  let callback_any : @core.Any = match callback {
    Some(f) => @js.from_fn1(f)
    None => @core.undefined()
  }
  ffi_animated_value_stop_animation(self, callback_any)
}

///|
/// Reset animation
pub fn AnimatedValue::reset_animation(
  self : AnimatedValue,
  callback? : ((Double) -> Unit)? = None,
) -> Unit {
  let callback_any : @core.Any = match callback {
    Some(f) => @js.from_fn1(f)
    None => @core.undefined()
  }
  ffi_animated_value_reset_animation(self, callback_any)
}

// ============================================================================
// Animated ValueXY
// ============================================================================

///|
/// Animated.ValueXY - Value for driving 2D animations
#external
pub type AnimatedValueXY

///|
pub fn AnimatedValueXY::as_any(self : AnimatedValueXY) -> @core.Any = "%identity"

///|
pub fn AnimatedValueXY::new(
  x? : Double = 0.0,
  y? : Double = 0.0,
) -> AnimatedValueXY {
  ffi_animated_value_xy(x, y).cast()
}

///|
extern "js" fn ffi_animated_value_xy_set_value(
  value : AnimatedValueXY,
  x : Double,
  y : Double,
) -> Unit =
  #| (value, x, y) => value.setValue({ x, y })

///|
extern "js" fn ffi_animated_value_xy_set_offset(
  value : AnimatedValueXY,
  x : Double,
  y : Double,
) -> Unit =
  #| (value, x, y) => value.setOffset({ x, y })

///|
extern "js" fn ffi_animated_value_xy_flatten_offset(
  value : AnimatedValueXY,
) -> Unit =
  #| (value) => value.flattenOffset()

///|
extern "js" fn ffi_animated_value_xy_extract_offset(
  value : AnimatedValueXY,
) -> Unit =
  #| (value) => value.extractOffset()

///|
extern "js" fn ffi_animated_value_xy_get_layout(
  value : AnimatedValueXY,
) -> @core.Any =
  #| (value) => value.getLayout()

///|
extern "js" fn ffi_animated_value_xy_get_translate_transform(
  value : AnimatedValueXY,
) -> @core.Any =
  #| (value) => value.getTranslateTransform()

///|
/// Set the value
pub fn AnimatedValueXY::set_value(
  self : AnimatedValueXY,
  x : Double,
  y : Double,
) -> Unit {
  ffi_animated_value_xy_set_value(self, x, y)
}

///|
/// Set the offset
pub fn AnimatedValueXY::set_offset(
  self : AnimatedValueXY,
  x : Double,
  y : Double,
) -> Unit {
  ffi_animated_value_xy_set_offset(self, x, y)
}

///|
/// Flatten the offset
pub fn AnimatedValueXY::flatten_offset(self : AnimatedValueXY) -> Unit {
  ffi_animated_value_xy_flatten_offset(self)
}

///|
/// Extract the offset
pub fn AnimatedValueXY::extract_offset(self : AnimatedValueXY) -> Unit {
  ffi_animated_value_xy_extract_offset(self)
}

///|
/// Get layout (left/top)
pub fn AnimatedValueXY::get_layout(self : AnimatedValueXY) -> @core.Any {
  ffi_animated_value_xy_get_layout(self)
}

///|
/// Get translate transform
pub fn AnimatedValueXY::get_translate_transform(
  self : AnimatedValueXY,
) -> @core.Any {
  ffi_animated_value_xy_get_translate_transform(self)
}

// ============================================================================
// Animation Types
// ============================================================================

///|
/// CompositeAnimation type for animation control
#external
pub type CompositeAnimation

///|
pub fn CompositeAnimation::as_any(self : CompositeAnimation) -> @core.Any = "%identity"

///|
extern "js" fn ffi_composite_animation_start(
  anim : CompositeAnimation,
  callback : @core.Any,
) -> Unit =
  #| (anim, callback) => anim.start(callback)

///|
extern "js" fn ffi_composite_animation_stop(anim : CompositeAnimation) -> Unit =
  #| (anim) => anim.stop()

///|
extern "js" fn ffi_composite_animation_reset(anim : CompositeAnimation) -> Unit =
  #| (anim) => anim.reset()

///|
/// Animation result
pub struct AnimationResult {
  finished : Bool
}

///|
/// Start the animation
pub fn CompositeAnimation::start(
  self : CompositeAnimation,
  callback? : ((AnimationResult) -> Unit)? = None,
) -> Unit {
  let callback_any : @core.Any = match callback {
    Some(f) =>
      @js.from_fn1(fn(result : @core.Any) {
        f({ finished: result["finished"].cast() })
      })
    None => @core.undefined()
  }
  ffi_composite_animation_start(self, callback_any)
}

///|
/// Stop the animation
pub fn CompositeAnimation::stop(self : CompositeAnimation) -> Unit {
  ffi_composite_animation_stop(self)
}

///|
/// Reset the animation
pub fn CompositeAnimation::reset(self : CompositeAnimation) -> Unit {
  ffi_composite_animation_reset(self)
}

// ============================================================================
// Animated Timing
// ============================================================================

///|
extern "js" fn ffi_animated_timing(
  value : @core.Any,
  config : @core.Any,
) -> CompositeAnimation =
  #| (value, config) => require("react-native").Animated.timing(value, config)

///|
/// Easing functions
pub(all) enum Easing {
  Linear
  Ease
  EaseIn
  EaseOut
  EaseInOut
  Quad
  Cubic
  Poly(Double)
  Sin
  Circle
  Exp
  Elastic(Double)
  Back(Double)
  Bounce
  Bezier(Double, Double, Double, Double)
}

///|
extern "js" fn ffi_easing_linear() -> @core.Any =
  #| () => require("react-native").Easing.linear

///|
extern "js" fn ffi_easing_ease() -> @core.Any =
  #| () => require("react-native").Easing.ease

///|
extern "js" fn ffi_easing_quad() -> @core.Any =
  #| () => require("react-native").Easing.quad

///|
extern "js" fn ffi_easing_cubic() -> @core.Any =
  #| () => require("react-native").Easing.cubic

///|
extern "js" fn ffi_easing_poly(n : Double) -> @core.Any =
  #| (n) => require("react-native").Easing.poly(n)

///|
extern "js" fn ffi_easing_sin() -> @core.Any =
  #| () => require("react-native").Easing.sin

///|
extern "js" fn ffi_easing_circle() -> @core.Any =
  #| () => require("react-native").Easing.circle

///|
extern "js" fn ffi_easing_exp() -> @core.Any =
  #| () => require("react-native").Easing.exp

///|
extern "js" fn ffi_easing_elastic(bounciness : Double) -> @core.Any =
  #| (bounciness) => require("react-native").Easing.elastic(bounciness)

///|
extern "js" fn ffi_easing_back(s : Double) -> @core.Any =
  #| (s) => require("react-native").Easing.back(s)

///|
extern "js" fn ffi_easing_bounce() -> @core.Any =
  #| () => require("react-native").Easing.bounce

///|
extern "js" fn ffi_easing_bezier(
  x1 : Double,
  y1 : Double,
  x2 : Double,
  y2 : Double,
) -> @core.Any =
  #| (x1, y1, x2, y2) => require("react-native").Easing.bezier(x1, y1, x2, y2)

///|
extern "js" fn ffi_easing_in(easing : @core.Any) -> @core.Any =
  #| (easing) => require("react-native").Easing.in(easing)

///|
extern "js" fn ffi_easing_out(easing : @core.Any) -> @core.Any =
  #| (easing) => require("react-native").Easing.out(easing)

///|
extern "js" fn ffi_easing_in_out(easing : @core.Any) -> @core.Any =
  #| (easing) => require("react-native").Easing.inOut(easing)

///|
fn Easing::to_any(self : Easing) -> @core.Any {
  match self {
    Linear => ffi_easing_linear()
    Ease => ffi_easing_ease()
    EaseIn => ffi_easing_in(ffi_easing_ease())
    EaseOut => ffi_easing_out(ffi_easing_ease())
    EaseInOut => ffi_easing_in_out(ffi_easing_ease())
    Quad => ffi_easing_quad()
    Cubic => ffi_easing_cubic()
    Poly(n) => ffi_easing_poly(n)
    Sin => ffi_easing_sin()
    Circle => ffi_easing_circle()
    Exp => ffi_easing_exp()
    Elastic(bounciness) => ffi_easing_elastic(bounciness)
    Back(s) => ffi_easing_back(s)
    Bounce => ffi_easing_bounce()
    Bezier(x1, y1, x2, y2) => ffi_easing_bezier(x1, y1, x2, y2)
  }
}

///|
/// Animated.timing configuration
pub struct TimingConfig {
  to_value : Double
  duration : Int?
  easing : Easing?
  delay : Int?
  use_native_driver : Bool?
}

///|
pub fn TimingConfig::new(
  to_value~ : Double,
  duration? : Int? = None,
  easing? : Easing? = None,
  delay? : Int? = None,
  use_native_driver? : Bool? = None,
) -> TimingConfig {
  { to_value, duration, easing, delay, use_native_driver }
}

///|
fn TimingConfig::to_any(self : TimingConfig) -> @core.Any {
  let obj = @core.new_object()
  obj._set("toValue", @core.any(self.to_value))
  if self.duration is Some(d) {
    obj._set("duration", @core.any(d))
  }
  if self.easing is Some(e) {
    obj._set("easing", e.to_any())
  }
  if self.delay is Some(d) {
    obj._set("delay", @core.any(d))
  }
  if self.use_native_driver is Some(v) {
    obj._set("useNativeDriver", @core.any(v))
  }
  obj
}

///|
/// Animated.timing - Animates a value along a timed easing curve
pub fn timing(
  value : AnimatedValue,
  config : TimingConfig,
) -> CompositeAnimation {
  ffi_animated_timing(value.as_any(), config.to_any())
}

// ============================================================================
// Animated Spring
// ============================================================================

///|
extern "js" fn ffi_animated_spring(
  value : @core.Any,
  config : @core.Any,
) -> CompositeAnimation =
  #| (value, config) => require("react-native").Animated.spring(value, config)

///|
/// Animated.spring configuration
pub struct SpringConfig {
  to_value : Double
  friction : Double?
  tension : Double?
  speed : Double?
  bounciness : Double?
  stiffness : Double?
  damping : Double?
  mass : Double?
  overshoot_clamping : Bool?
  rest_displacement_threshold : Double?
  rest_speed_threshold : Double?
  velocity : Double?
  delay : Int?
  use_native_driver : Bool?
}

///|
pub fn SpringConfig::new(
  to_value~ : Double,
  friction? : Double? = None,
  tension? : Double? = None,
  speed? : Double? = None,
  bounciness? : Double? = None,
  stiffness? : Double? = None,
  damping? : Double? = None,
  mass? : Double? = None,
  overshoot_clamping? : Bool? = None,
  rest_displacement_threshold? : Double? = None,
  rest_speed_threshold? : Double? = None,
  velocity? : Double? = None,
  delay? : Int? = None,
  use_native_driver? : Bool? = None,
) -> SpringConfig {
  {
    to_value,
    friction,
    tension,
    speed,
    bounciness,
    stiffness,
    damping,
    mass,
    overshoot_clamping,
    rest_displacement_threshold,
    rest_speed_threshold,
    velocity,
    delay,
    use_native_driver,
  }
}

///|
fn SpringConfig::to_any(self : SpringConfig) -> @core.Any {
  let obj = @core.new_object()
  obj._set("toValue", @core.any(self.to_value))
  if self.friction is Some(v) {
    obj._set("friction", @core.any(v))
  }
  if self.tension is Some(v) {
    obj._set("tension", @core.any(v))
  }
  if self.speed is Some(v) {
    obj._set("speed", @core.any(v))
  }
  if self.bounciness is Some(v) {
    obj._set("bounciness", @core.any(v))
  }
  if self.stiffness is Some(v) {
    obj._set("stiffness", @core.any(v))
  }
  if self.damping is Some(v) {
    obj._set("damping", @core.any(v))
  }
  if self.mass is Some(v) {
    obj._set("mass", @core.any(v))
  }
  if self.overshoot_clamping is Some(v) {
    obj._set("overshootClamping", @core.any(v))
  }
  if self.rest_displacement_threshold is Some(v) {
    obj._set("restDisplacementThreshold", @core.any(v))
  }
  if self.rest_speed_threshold is Some(v) {
    obj._set("restSpeedThreshold", @core.any(v))
  }
  if self.velocity is Some(v) {
    obj._set("velocity", @core.any(v))
  }
  if self.delay is Some(d) {
    obj._set("delay", @core.any(d))
  }
  if self.use_native_driver is Some(v) {
    obj._set("useNativeDriver", @core.any(v))
  }
  obj
}

///|
/// Animated.spring - Animates a value using spring physics
pub fn spring(
  value : AnimatedValue,
  config : SpringConfig,
) -> CompositeAnimation {
  ffi_animated_spring(value.as_any(), config.to_any())
}

// ============================================================================
// Animated Decay
// ============================================================================

///|
extern "js" fn ffi_animated_decay(
  value : @core.Any,
  config : @core.Any,
) -> CompositeAnimation =
  #| (value, config) => require("react-native").Animated.decay(value, config)

///|
/// Animated.decay configuration
pub struct DecayConfig {
  velocity : Double
  deceleration : Double?
  use_native_driver : Bool?
}

///|
pub fn DecayConfig::new(
  velocity~ : Double,
  deceleration? : Double? = None,
  use_native_driver? : Bool? = None,
) -> DecayConfig {
  { velocity, deceleration, use_native_driver }
}

///|
fn DecayConfig::to_any(self : DecayConfig) -> @core.Any {
  let obj = @core.new_object()
  obj._set("velocity", @core.any(self.velocity))
  if self.deceleration is Some(v) {
    obj._set("deceleration", @core.any(v))
  }
  if self.use_native_driver is Some(v) {
    obj._set("useNativeDriver", @core.any(v))
  }
  obj
}

///|
/// Animated.decay - Animates a value from an initial velocity to zero
pub fn decay(value : AnimatedValue, config : DecayConfig) -> CompositeAnimation {
  ffi_animated_decay(value.as_any(), config.to_any())
}

// ============================================================================
// Composition Functions
// ============================================================================

///|
extern "js" fn ffi_animated_sequence(
  animations : @core.Any,
) -> CompositeAnimation =
  #| (animations) => require("react-native").Animated.sequence(animations)

///|
extern "js" fn ffi_animated_parallel(
  animations : @core.Any,
  config : @core.Any,
) -> CompositeAnimation =
  #| (animations, config) => require("react-native").Animated.parallel(animations, config)

///|
extern "js" fn ffi_animated_stagger(
  time : Int,
  animations : @core.Any,
) -> CompositeAnimation =
  #| (time, animations) => require("react-native").Animated.stagger(time, animations)

///|
extern "js" fn ffi_animated_delay(time : Int) -> CompositeAnimation =
  #| (time) => require("react-native").Animated.delay(time)

///|
extern "js" fn ffi_animated_loop(
  animation : CompositeAnimation,
  config : @core.Any,
) -> CompositeAnimation =
  #| (animation, config) => require("react-native").Animated.loop(animation, config)

///|
/// Animated.sequence - Runs animations in sequence
pub fn sequence(animations : Array[CompositeAnimation]) -> CompositeAnimation {
  ffi_animated_sequence(@core.any(animations.map(CompositeAnimation::as_any)))
}

///|
/// Animated.parallel - Runs animations in parallel
pub fn parallel(
  animations : Array[CompositeAnimation],
  stop_together? : Bool = true,
) -> CompositeAnimation {
  let config = @core.new_object()
  config._set("stopTogether", @core.any(stop_together))
  ffi_animated_parallel(
    @core.any(animations.map(CompositeAnimation::as_any)),
    config,
  )
}

///|
/// Animated.stagger - Runs animations in sequence with a stagger delay
pub fn stagger(
  time : Int,
  animations : Array[CompositeAnimation],
) -> CompositeAnimation {
  ffi_animated_stagger(
    time,
    @core.any(animations.map(CompositeAnimation::as_any)),
  )
}

///|
/// Animated.delay - Creates a delay animation
pub fn delay(time : Int) -> CompositeAnimation {
  ffi_animated_delay(time)
}

///|
/// Animated.loop - Loops an animation
pub fn loop_(
  animation : CompositeAnimation,
  iterations? : Int? = None,
  reset_before_iteration? : Bool = true,
) -> CompositeAnimation {
  let config = @core.new_object()
  if iterations is Some(n) {
    config._set("iterations", @core.any(n))
  } else {
    config._set("iterations", @core.any(-1))
  }
  config._set("resetBeforeIteration", @core.any(reset_before_iteration))
  ffi_animated_loop(animation, config)
}

// ============================================================================
// Interpolation
// ============================================================================

///|
extern "js" fn ffi_animated_value_interpolate(
  value : AnimatedValue,
  config : @core.Any,
) -> @core.Any =
  #| (value, config) => value.interpolate(config)

///|
/// Extrapolate type
pub(all) enum Extrapolate {
  Extend
  Clamp
  Identity
}

///|
fn Extrapolate::to_string(self : Extrapolate) -> String {
  match self {
    Extend => "extend"
    Clamp => "clamp"
    Identity => "identity"
  }
}

///|
/// Interpolation configuration
pub struct InterpolateConfig {
  input_range : Array[Double]
  output_range : Array[@core.Any]
  extrapolate : Extrapolate?
  extrapolate_left : Extrapolate?
  extrapolate_right : Extrapolate?
}

///|
pub fn InterpolateConfig::new(
  input_range~ : Array[Double],
  output_range~ : Array[@core.Any],
  extrapolate? : Extrapolate? = None,
  extrapolate_left? : Extrapolate? = None,
  extrapolate_right? : Extrapolate? = None,
) -> InterpolateConfig {
  {
    input_range,
    output_range,
    extrapolate,
    extrapolate_left,
    extrapolate_right,
  }
}

///|
fn InterpolateConfig::to_any(self : InterpolateConfig) -> @core.Any {
  let obj = @core.new_object()
  obj._set("inputRange", @core.any(self.input_range))
  obj._set("outputRange", @core.any(self.output_range))
  if self.extrapolate is Some(e) {
    obj._set("extrapolate", @core.any(e.to_string()))
  }
  if self.extrapolate_left is Some(e) {
    obj._set("extrapolateLeft", @core.any(e.to_string()))
  }
  if self.extrapolate_right is Some(e) {
    obj._set("extrapolateRight", @core.any(e.to_string()))
  }
  obj
}

///|
/// Interpolate animated value
pub fn AnimatedValue::interpolate(
  self : AnimatedValue,
  config : InterpolateConfig,
) -> @core.Any {
  ffi_animated_value_interpolate(self, config.to_any())
}

// ============================================================================
// Animated Components
// ============================================================================

///|
extern "js" fn ffi_animated_view() -> @core.Any =
  #| () => require("react-native").Animated.View

///|
extern "js" fn ffi_animated_text() -> @core.Any =
  #| () => require("react-native").Animated.Text

///|
extern "js" fn ffi_animated_image() -> @core.Any =
  #| () => require("react-native").Animated.Image

///|
extern "js" fn ffi_animated_scroll_view() -> @core.Any =
  #| () => require("react-native").Animated.ScrollView

///|
extern "js" fn ffi_animated_flat_list() -> @core.Any =
  #| () => require("react-native").Animated.FlatList

///|
extern "js" fn ffi_animated_section_list() -> @core.Any =
  #| () => require("react-native").Animated.SectionList

///|
/// Animated.View
pub fn animated_view(
  children? : Array[&@react.ReactNode] = [],
  style? : @core.Any? = None,
  on_layout? : ((LayoutChangeEvent) -> Unit)? = None,
  test_id? : String? = None,
  key? : String? = None,
) -> @react.Element {
  let props = @core.new_object()
  if style is Some(s) {
    props._set("style", s)
  }
  if on_layout is Some(f) {
    props._set("onLayout", @js.from_fn1(f))
  }
  if test_id is Some(id) {
    props._set("testID", @core.any(id))
  }
  create_element(ffi_animated_view(), props, children~, key~)
}

///|
/// Animated.Text
pub fn animated_text(
  children? : Array[&@react.ReactNode] = [],
  style? : @core.Any? = None,
  number_of_lines? : Int? = None,
  test_id? : String? = None,
  key? : String? = None,
) -> @react.Element {
  let props = @core.new_object()
  if style is Some(s) {
    props._set("style", s)
  }
  if number_of_lines is Some(n) {
    props._set("numberOfLines", @core.any(n))
  }
  if test_id is Some(id) {
    props._set("testID", @core.any(id))
  }
  create_element(ffi_animated_text(), props, children~, key~)
}

///|
/// Animated.Image
pub fn animated_image(
  source~ : ImageSource,
  style? : @core.Any? = None,
  resize_mode? : String? = None,
  test_id? : String? = None,
  key? : String? = None,
) -> @react.Element {
  let props = @core.new_object()
  props._set("source", source.as_any())
  if style is Some(s) {
    props._set("style", s)
  }
  if resize_mode is Some(mode) {
    props._set("resizeMode", @core.any(mode))
  }
  if test_id is Some(id) {
    props._set("testID", @core.any(id))
  }
  create_element(ffi_animated_image(), props, key~)
}

///|
/// Animated.ScrollView
pub fn animated_scroll_view(
  children? : Array[&@react.ReactNode] = [],
  style? : @core.Any? = None,
  content_container_style? : @core.Any? = None,
  horizontal? : Bool? = None,
  on_scroll? : ((ScrollEvent) -> Unit)? = None,
  scroll_event_throttle? : Int? = None,
  test_id? : String? = None,
  key? : String? = None,
) -> @react.Element {
  let props = @core.new_object()
  if style is Some(s) {
    props._set("style", s)
  }
  if content_container_style is Some(s) {
    props._set("contentContainerStyle", s)
  }
  if horizontal is Some(v) {
    props._set("horizontal", @core.any(v))
  }
  if on_scroll is Some(f) {
    props._set("onScroll", @js.from_fn1(f))
  }
  if scroll_event_throttle is Some(t) {
    props._set("scrollEventThrottle", @core.any(t))
  }
  if test_id is Some(id) {
    props._set("testID", @core.any(id))
  }
  create_element(ffi_animated_scroll_view(), props, children~, key~)
}

// ============================================================================
// Animated Math Operations
// ============================================================================

///|
extern "js" fn ffi_animated_add(a : @core.Any, b : @core.Any) -> @core.Any =
  #| (a, b) => require("react-native").Animated.add(a, b)

///|
extern "js" fn ffi_animated_subtract(a : @core.Any, b : @core.Any) -> @core.Any =
  #| (a, b) => require("react-native").Animated.subtract(a, b)

///|
extern "js" fn ffi_animated_multiply(a : @core.Any, b : @core.Any) -> @core.Any =
  #| (a, b) => require("react-native").Animated.multiply(a, b)

///|
extern "js" fn ffi_animated_divide(a : @core.Any, b : @core.Any) -> @core.Any =
  #| (a, b) => require("react-native").Animated.divide(a, b)

///|
extern "js" fn ffi_animated_modulo(
  a : @core.Any,
  modulus : Double,
) -> @core.Any =
  #| (a, modulus) => require("react-native").Animated.modulo(a, modulus)

///|
extern "js" fn ffi_animated_diff_clamp(
  a : @core.Any,
  min : Double,
  max : Double,
) -> @core.Any =
  #| (a, min, max) => require("react-native").Animated.diffClamp(a, min, max)

///|
/// Animated.add - Adds two animated values
pub fn animated_add(a : AnimatedValue, b : AnimatedValue) -> @core.Any {
  ffi_animated_add(a.as_any(), b.as_any())
}

///|
/// Animated.subtract - Subtracts two animated values
pub fn animated_subtract(a : AnimatedValue, b : AnimatedValue) -> @core.Any {
  ffi_animated_subtract(a.as_any(), b.as_any())
}

///|
/// Animated.multiply - Multiplies two animated values
pub fn animated_multiply(a : AnimatedValue, b : AnimatedValue) -> @core.Any {
  ffi_animated_multiply(a.as_any(), b.as_any())
}

///|
/// Animated.divide - Divides two animated values
pub fn animated_divide(a : AnimatedValue, b : AnimatedValue) -> @core.Any {
  ffi_animated_divide(a.as_any(), b.as_any())
}

///|
/// Animated.modulo - Calculates modulo of an animated value
pub fn animated_modulo(a : AnimatedValue, modulus : Double) -> @core.Any {
  ffi_animated_modulo(a.as_any(), modulus)
}

///|
/// Animated.diffClamp - Clamps the difference between values
pub fn animated_diff_clamp(
  a : AnimatedValue,
  min : Double,
  max : Double,
) -> @core.Any {
  ffi_animated_diff_clamp(a.as_any(), min, max)
}

// ============================================================================
// Animated Event
// ============================================================================

///|
extern "js" fn ffi_animated_event(
  arg_mapping : @core.Any,
  config : @core.Any,
) -> @core.Any =
  #| (argMapping, config) => require("react-native").Animated.event(argMapping, config)

///|
/// Animated.event - Maps an array of event values to animated values
pub fn animated_event(
  arg_mapping : @core.Any,
  use_native_driver? : Bool = false,
  listener? : ((@core.Any) -> Unit)? = None,
) -> @core.Any {
  let config = @core.new_object()
  config._set("useNativeDriver", @core.any(use_native_driver))
  if listener is Some(f) {
    config._set("listener", @js.from_fn1(f))
  }
  ffi_animated_event(arg_mapping, config)
}
