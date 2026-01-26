///| Tests for React Native bindings
/// Note: Tests that require the React Native runtime are skipped
/// Full runtime tests require a React Native environment

///|
test "ImageSource uri" {
  let source = @react_native.ImageSource::uri(
    "https://example.com/image.png",
    width=Some(100),
    height=Some(100),
  )
  inspect(@core.is_undefined(source.as_any()), content="false")
}

///|
test "AlertButton creation" {
  let button = @react_native.AlertButton::new(
    text="OK",
    style=@react_native.AlertButtonStyle::Default,
  )
  let any = button.to_any()
  inspect(any["text"], content="OK")
}

///|
test "AlertButton with callback" {
  let button = @react_native.AlertButton::new(
    text="Press Me",
    on_press=Some(fn() { () }),
    style=@react_native.AlertButtonStyle::Destructive,
    is_preferred=true,
  )
  let any = button.to_any()
  inspect(any["text"], content="Press Me")
  inspect(any["style"], content="destructive")
}

///|
test "Section creation" {
  let section = @react_native.Section::new(title="Header", data=[
    "Item 1", "Item 2", "Item 3",
  ])
  let any = section.to_any()
  inspect(any["title"], content="Header")
}

///|
test "ItemLayout creation" {
  let layout = @react_native.ItemLayout::new(length=50.0, offset=100.0, index=2)
  inspect(layout.length, content="50")
  inspect(layout.offset, content="100")
  inspect(layout.index, content="2")
}

///|
test "OS enum to_string" {
  inspect(@react_native.OS::IOS.to_string(), content="ios")
  inspect(@react_native.OS::Android.to_string(), content="android")
  inspect(@react_native.OS::Web.to_string(), content="web")
}

///|
test "AppStateStatus to_string" {
  inspect(@react_native.AppStateStatus::Active.to_string(), content="active")
  inspect(
    @react_native.AppStateStatus::Background.to_string(),
    content="background",
  )
  inspect(
    @react_native.AppStateStatus::Inactive.to_string(),
    content="inactive",
  )
}

///|
test "ColorScheme to_string" {
  inspect(@react_native.ColorScheme::Light.to_string(), content="light")
  inspect(@react_native.ColorScheme::Dark.to_string(), content="dark")
}

///|
test "AlertButtonStyle to_string" {
  inspect(
    @react_native.AlertButtonStyle::Default.to_string(),
    content="default",
  )
  inspect(@react_native.AlertButtonStyle::Cancel.to_string(), content="cancel")
  inspect(
    @react_native.AlertButtonStyle::Destructive.to_string(),
    content="destructive",
  )
}

///|
test "ScaledSize struct" {
  let size : @react_native.ScaledSize = {
    width: 375.0,
    height: 812.0,
    scale: 3.0,
    font_scale: 1.0,
  }
  inspect(size.width, content="375")
  inspect(size.height, content="812")
  inspect(size.scale, content="3")
}

///|
test "KeyboardCoordinates struct" {
  let coords : @react_native.KeyboardCoordinates = {
    screen_x: 0.0,
    screen_y: 500.0,
    width: 375.0,
    height: 300.0,
  }
  inspect(coords.screen_x, content="0")
  inspect(coords.screen_y, content="500")
}

// ============================================================================
// Toast API Tests (Android)
// ============================================================================

///|
test "ToastDuration enum" {
  // ToastDuration enum variants exist
  let _short : @react_native.ToastDuration = @react_native.ToastDuration::Short
  let _long : @react_native.ToastDuration = @react_native.ToastDuration::Long
  inspect(true, content="true")
}

///|
test "ToastGravity enum" {
  // ToastGravity enum variants exist
  let _top : @react_native.ToastGravity = @react_native.ToastGravity::Top
  let _bottom : @react_native.ToastGravity = @react_native.ToastGravity::Bottom
  let _center : @react_native.ToastGravity = @react_native.ToastGravity::Center
  inspect(true, content="true")
}

// ============================================================================
// Permission API Tests (Android)
// ============================================================================

///|
test "PermissionResult enum" {
  let _granted : @react_native.PermissionResult = @react_native.PermissionResult::Granted
  let _denied : @react_native.PermissionResult = @react_native.PermissionResult::Denied
  let _never : @react_native.PermissionResult = @react_native.PermissionResult::NeverAskAgain
  inspect(true, content="true")
}

///|
test "PermissionRationale creation" {
  let rationale = @react_native.PermissionRationale::new(
    title="Camera Permission",
    message="We need camera access to take photos",
    button_positive=Some("Allow"),
    button_negative=Some("Deny"),
  )
  inspect(rationale.title, content="Camera Permission")
  inspect(rationale.message, content="We need camera access to take photos")
}

// ============================================================================
// ActionSheet API Tests (iOS)
// ============================================================================

///|
test "ActionSheetOptions creation" {
  let options = @react_native.ActionSheetOptions::new(
    options=["Option 1", "Option 2", "Cancel"],
    cancel_button_index=Some(2),
    destructive_button_index=Some(1),
    title=Some("Choose an option"),
  )
  inspect(options.options.length(), content="3")
  inspect(options.cancel_button_index, content="Some(2)")
  inspect(options.title, content="Some(\"Choose an option\")")
}

///|
test "ShareActionSheetOptions creation" {
  let options = @react_native.ShareActionSheetOptions::new(
    url=Some("https://example.com"),
    message=Some("Check this out!"),
    subject=Some("Sharing"),
  )
  inspect(options.url, content="Some(\"https://example.com\")")
  inspect(options.message, content="Some(\"Check this out!\")")
}

// ============================================================================
// Share API Tests
// ============================================================================

///|
test "ShareContent creation" {
  let content = @react_native.ShareContent::new(
    message=Some("Hello World"),
    url=Some("https://example.com"),
    title=Some("Share Title"),
  )
  inspect(content.message, content="Some(\"Hello World\")")
  inspect(content.url, content="Some(\"https://example.com\")")
  inspect(content.title, content="Some(\"Share Title\")")
}

///|
test "ShareOptions creation" {
  let options = @react_native.ShareOptions::new(
    dialog_title=Some("Share via"),
    subject=Some("Email Subject"),
  )
  inspect(options.dialog_title, content="Some(\"Share via\")")
  inspect(options.subject, content="Some(\"Email Subject\")")
}

// ShareResult is internal - tested via share() function

// ============================================================================
// Animated API Tests
// ============================================================================

///|
test "TimingConfig creation" {
  let config = @react_native.TimingConfig::new(
    to_value=1.0,
    duration=Some(300),
    delay=Some(100),
    use_native_driver=Some(true),
  )
  inspect(config.to_value, content="1")
  inspect(config.duration, content="Some(300)")
  inspect(config.delay, content="Some(100)")
  inspect(config.use_native_driver, content="Some(true)")
}

///|
test "SpringConfig creation" {
  let config = @react_native.SpringConfig::new(
    to_value=1.0,
    friction=Some(7.0),
    tension=Some(40.0),
    use_native_driver=Some(true),
  )
  inspect(config.to_value, content="1")
  inspect(config.friction, content="Some(7)")
  inspect(config.tension, content="Some(40)")
}

///|
test "DecayConfig creation" {
  let config = @react_native.DecayConfig::new(
    velocity=0.5,
    deceleration=Some(0.997),
    use_native_driver=Some(true),
  )
  inspect(config.velocity, content="0.5")
  inspect(config.deceleration, content="Some(0.997)")
}

///|
test "Easing enum variants" {
  let _linear : @react_native.Easing = @react_native.Easing::Linear
  let _ease : @react_native.Easing = @react_native.Easing::Ease
  let _ease_in : @react_native.Easing = @react_native.Easing::EaseIn
  let _ease_out : @react_native.Easing = @react_native.Easing::EaseOut
  let _ease_in_out : @react_native.Easing = @react_native.Easing::EaseInOut
  let _quad : @react_native.Easing = @react_native.Easing::Quad
  let _cubic : @react_native.Easing = @react_native.Easing::Cubic
  let _poly : @react_native.Easing = @react_native.Easing::Poly(3.0)
  let _sin : @react_native.Easing = @react_native.Easing::Sin
  let _circle : @react_native.Easing = @react_native.Easing::Circle
  let _exp : @react_native.Easing = @react_native.Easing::Exp
  let _elastic : @react_native.Easing = @react_native.Easing::Elastic(1.0)
  let _back : @react_native.Easing = @react_native.Easing::Back(1.5)
  let _bounce : @react_native.Easing = @react_native.Easing::Bounce
  let _bezier : @react_native.Easing = @react_native.Easing::Bezier(
    0.4, 0.0, 0.2, 1.0,
  )
  inspect(true, content="true")
}

///|
test "Extrapolate enum variants" {
  let _extend : @react_native.Extrapolate = @react_native.Extrapolate::Extend
  let _clamp : @react_native.Extrapolate = @react_native.Extrapolate::Clamp
  let _identity : @react_native.Extrapolate = @react_native.Extrapolate::Identity
  inspect(true, content="true")
}

///|
test "InterpolateConfig creation" {
  let config = @react_native.InterpolateConfig::new(
    input_range=[0.0, 1.0],
    output_range=[@core.any(0), @core.any(100)],
    extrapolate=Some(@react_native.Extrapolate::Clamp),
  )
  inspect(config.input_range.length(), content="2")
  inspect(config.output_range.length(), content="2")
}

// AnimationResult is internal - tested via animation callbacks

// ============================================================================
// Style API Tests
// ============================================================================

///|
test "Style from_any" {
  let obj = @core.new_object()
  obj._set("flex", @core.any(1))
  let style = @react_native.Style::from_any(obj)
  inspect(@core.is_undefined(style.as_any()), content="false")
}

///|
test "StyleProp from_style" {
  let obj = @core.new_object()
  obj._set("flex", @core.any(1))
  let style = @react_native.Style::from_any(obj)
  let style_prop = @react_native.StyleProp::from_style(style)
  inspect(@core.is_undefined(style_prop.as_any()), content="false")
}

///|
test "StyleProp from_styles" {
  let obj1 = @core.new_object()
  obj1._set("flex", @core.any(1))
  let obj2 = @core.new_object()
  obj2._set("padding", @core.any(10))
  let style1 = @react_native.Style::from_any(obj1)
  let style2 = @react_native.Style::from_any(obj2)
  let style_prop = @react_native.StyleProp::from_styles([style1, style2])
  inspect(@core.is_undefined(style_prop.as_any()), content="false")
}

// ============================================================================
// Platform API Tests
// ============================================================================

///|
test "OS enum Windows and MacOS" {
  inspect(@react_native.OS::Windows.to_string(), content="windows")
  inspect(@react_native.OS::MacOS.to_string(), content="macos")
}

// ============================================================================
// Dimensions API Tests
// ============================================================================

// DimensionsChangeEvent is internal - tested via event listeners

// ============================================================================
// URL Event Tests
// ============================================================================

// URLEvent is internal - tested via event listeners

// ============================================================================
// Keyboard Event Tests
// ============================================================================

// KeyboardEvent is internal - tested via keyboard event listeners

// ============================================================================
// Appearance API Tests
// ============================================================================

///|
test "ColorScheme Unspecified" {
  inspect(@react_native.ColorScheme::Unspecified.to_string(), content="null")
}

// AppearanceChangeEvent is internal - tested via appearance change listeners

// ============================================================================
// AppState API Tests
// ============================================================================

///|
test "AppStateStatus Unknown and Extension" {
  inspect(@react_native.AppStateStatus::Unknown.to_string(), content="unknown")
  inspect(
    @react_native.AppStateStatus::Extension.to_string(),
    content="extension",
  )
}

// ============================================================================
// Type-safe Style API Tests
// ============================================================================

///|
test "FlexDirection to_string" {
  inspect(@react_native.FlexDirection::Row.to_string(), content="row")
  inspect(
    @react_native.FlexDirection::RowReverse.to_string(),
    content="row-reverse",
  )
  inspect(@react_native.FlexDirection::Column.to_string(), content="column")
  inspect(
    @react_native.FlexDirection::ColumnReverse.to_string(),
    content="column-reverse",
  )
}

///|
test "JustifyContent to_string" {
  inspect(
    @react_native.JustifyContent::FlexStart.to_string(),
    content="flex-start",
  )
  inspect(@react_native.JustifyContent::FlexEnd.to_string(), content="flex-end")
  inspect(@react_native.JustifyContent::Center.to_string(), content="center")
  inspect(
    @react_native.JustifyContent::SpaceBetween.to_string(),
    content="space-between",
  )
  inspect(
    @react_native.JustifyContent::SpaceAround.to_string(),
    content="space-around",
  )
  inspect(
    @react_native.JustifyContent::SpaceEvenly.to_string(),
    content="space-evenly",
  )
}

///|
test "AlignItems to_string" {
  inspect(@react_native.AlignItems::FlexStart.to_string(), content="flex-start")
  inspect(@react_native.AlignItems::FlexEnd.to_string(), content="flex-end")
  inspect(@react_native.AlignItems::Center.to_string(), content="center")
  inspect(@react_native.AlignItems::Stretch.to_string(), content="stretch")
  inspect(@react_native.AlignItems::Baseline.to_string(), content="baseline")
}

///|
test "Position to_string" {
  inspect(@react_native.Position::Absolute.to_string(), content="absolute")
  inspect(@react_native.Position::Relative.to_string(), content="relative")
}

///|
test "FontWeight to_string" {
  inspect(@react_native.FontWeight::Normal.to_string(), content="normal")
  inspect(@react_native.FontWeight::Bold.to_string(), content="bold")
  inspect(@react_native.FontWeight::W500.to_string(), content="500")
}

///|
test "TextAlign to_string" {
  inspect(@react_native.TextAlign::Left.to_string(), content="left")
  inspect(@react_native.TextAlign::Center.to_string(), content="center")
  inspect(@react_native.TextAlign::Right.to_string(), content="right")
}

///|
test "BorderStyle to_string" {
  inspect(@react_native.BorderStyle::Solid.to_string(), content="solid")
  inspect(@react_native.BorderStyle::Dotted.to_string(), content="dotted")
  inspect(@react_native.BorderStyle::Dashed.to_string(), content="dashed")
}

///|
test "ResizeMode to_string" {
  inspect(@react_native.ResizeMode::Cover.to_string(), content="cover")
  inspect(@react_native.ResizeMode::Contain.to_string(), content="contain")
  inspect(@react_native.ResizeMode::Stretch.to_string(), content="stretch")
}

///|
test "style function creates Style" {
  let s = @react_native.style(
    flex=1,
    flex_direction=@react_native.FlexDirection::Column,
    justify_content=@react_native.JustifyContent::Center,
    align_items=@react_native.AlignItems::Center,
    background_color="#fff",
  )
  inspect(@core.is_undefined(s.as_any()), content="false")
}

///|
test "style function with sizing" {
  let s = @react_native.style(
    width=100.0,
    height=200.0,
    padding=16.0,
    margin=8.0,
  )
  inspect(@core.is_undefined(s.as_any()), content="false")
}

///|
test "style function with text properties" {
  let s = @react_native.style(
    color="#333",
    font_size=16.0,
    font_weight=@react_native.FontWeight::Bold,
    text_align=@react_native.TextAlign::Center,
  )
  inspect(@core.is_undefined(s.as_any()), content="false")
}

///|
test "style function with border" {
  let s = @react_native.style(
    border_width=1.0,
    border_color="#ccc",
    border_radius=8.0,
    border_style=@react_native.BorderStyle::Solid,
  )
  inspect(@core.is_undefined(s.as_any()), content="false")
}

///|
test "style function with position" {
  let s = @react_native.style(
    position=@react_native.Position::Absolute,
    top=0.0,
    left=0.0,
    right=0.0,
    bottom=0.0,
  )
  inspect(@core.is_undefined(s.as_any()), content="false")
}
