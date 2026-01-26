# @mizchi/npm_typed/react_native

MoonBit bindings for [React Native](https://reactnative.dev/).

## Installation

```bash
moon add mizchi/npm_typed
npm install react-native
```

Add to your `moon.pkg.json`:

```json
{
  "import": [
    "mizchi/js",
    "mizchi/js/core",
    "mizchi/npm_typed/react",
    "mizchi/npm_typed/react_native"
  ]
}
```

## Components

### View

The most fundamental component for building UI:

```moonbit
///|
using @react_native {
  type Style,
  type StyleProp,
  type AlignItems,
  type JustifyContent,
  view,
  text,
  style,
}

///|
let containerStyle : Style = style(
  flex=1,
  justify_content=JustifyContent::Center,
  align_items=AlignItems::Center,
)

///|
fn my_component() -> @react.Element {
  view(style=Some(StyleProp::from_style(containerStyle)), children=[
    text(children=["Hello, React Native!"]),
  ])
}
```

### Text

Display text:

```moonbit
///|
let titleStyle : Style = @react_native.style(
  font_size=24.0,
  font_weight=@react_native.FontWeight::Bold,
  color="#333333",
)

///|
fn styled_text() -> @react.Element {
  @react_native.text(
    style=Some(@react_native.StyleProp::from_style(titleStyle)),
    number_of_lines=2,
    ellipsize_mode="tail",
    children=["Styled Text"],
  )
}
```

### Image

Display images:

```moonbit
///|
let imageStyle : @react_native.Style = @react_native.style(
  width=200.0,
  height=200.0,
  border_radius=10.0,
)

///|
fn image_example() -> @react.Element {
  @react_native.image(
    source=@react_native.ImageSource::uri("https://example.com/image.png"),
    style=Some(@react_native.StyleProp::from_style(imageStyle)),
    resize_mode="cover",
  )
}
```

### ScrollView

Scrollable container:

```moonbit
///|
let scrollStyle : @react_native.Style = @react_native.style(flex=1)

///|
fn scroll_example() -> @react.Element {
  @react_native.scroll_view(
    style=Some(@react_native.StyleProp::from_style(scrollStyle)),
    shows_vertical_scroll_indicator=false,
    children=[
      @react_native.text(children=["Item 1"]),
      @react_native.text(children=["Item 2"]),
      @react_native.text(children=["Item 3"]),
    ],
  )
}
```

### TouchableOpacity

Touchable wrapper with opacity feedback:

```moonbit
///|
fn button_example() -> @react.Element {
  @react_native.touchable_opacity(
    on_press=fn(_) { println("Pressed!") },
    active_opacity=0.7,
    children=[@react_native.text(children=["Press Me"])],
  )
}
```

### TextInput

Text input field:

```moonbit
///|
let inputStyle : @react_native.Style = @react_native.style(
  border_width=1.0,
  border_color="#cccccc",
  padding=10.0,
)

///|
fn input_example() -> @react.Element {
  let (text, set_text) = @react.useState("")
  @react_native.text_input(
    value=text,
    on_change_text=fn(new_text) { set_text(new_text) },
    placeholder="Enter text...",
    style=Some(@react_native.StyleProp::from_style(inputStyle)),
  )
}
```

### FlatList

Performant list rendering:

```moonbit
///|
fn list_example() -> @react.Element {
  let data = ["Apple", "Banana", "Cherry", "Date"]
  @react_native.flat_list(
    data~,
    render_item=fn(info) {
      @react_native.text(key=info.item, children=[info.item])
    },
    key_extractor=Some(fn(item, _) { item }),
  )
}
```

## StyleSheet API

### Type-safe Style API (Recommended)

Use the `style()` function with named arguments for compile-time type checking:

```moonbit
///|
using @react_native {
  type Style,
  type AlignItems,
  type JustifyContent,
  type FontWeight,
  style,
}

///|
let containerStyle : Style = style(
  flex=1,
  background_color="#fff",
  align_items=AlignItems::Center,
  justify_content=JustifyContent::Center,
)

///|
let titleStyle : Style = style(
  font_size=24.0,
  font_weight=FontWeight::Bold,
  color="#333",
)
```

Available enums for style properties:

| Category | Enums |
|----------|-------|
| Layout | `FlexDirection`, `JustifyContent`, `AlignItems`, `AlignSelf`, `AlignContent`, `FlexWrap` |
| Position | `Position`, `Overflow`, `Display` |
| Text | `TextAlign`, `TextAlignVertical`, `FontStyle`, `FontWeight`, `TextDecorationLine`, `TextTransform` |
| Border | `BorderStyle` |
| Image | `ResizeMode` |

### Using StyleSheet::create_typed

Combine `style()` with `StyleSheet::create_typed()` for optimized styles:

```moonbit
///|
let styles = @react_native.StyleSheet::create_typed({
  "container": style(flex=1, background_color="#fff"),
  "title": style(font_size=24.0, font_weight=FontWeight::Bold),
})
```

### Legacy API

The original `StyleSheet::create` with `@core.any()` is still available:

```moonbit
///|
let styles = @react_native.StyleSheet::create({
  "container": { "flex": @core.any(1), "backgroundColor": @core.any("#fff") },
})
```

### Other StyleSheet methods

```moonbit
// Flatten multiple styles

///|
let combined = @react_native.StyleSheet::flatten([style1, style2])

// Predefined styles

///|
let fill = @react_native.StyleSheet::absolute_fill()

///|
let fill_obj = @react_native.StyleSheet::absolute_fill_object()

// Hairline width (1px on most devices)

///|
let width = @react_native.StyleSheet::hairline_width()
```

## Platform API

Check the current platform:

```moonbit
///|
fn platform_specific() -> @react.Element {
  let message = if @react_native.is_ios() {
    "Running on iOS"
  } else if @react_native.is_android() {
    "Running on Android"
  } else {
    "Running on other platform"
  }
  @react_native.text(children=[message])
}
```

Platform-specific values:

```moonbit
///|
fn get_padding() -> Int {
  @react_native.select(ios=20, android=16, default=10).unwrap_or(10)
}
```

## APIs

### Dimensions

Get screen dimensions:

```moonbit
///|
fn dimensions_example() {
  let window = @react_native.get_window_dimensions()
  println("Width: \{window.width}, Height: \{window.height}")
}
```

### Alert

Show alert dialogs:

```moonbit
///|
fn show_alert() {
  @react_native.alert(title="Hello", message=Some("This is an alert message"), buttons=[
    @react_native.AlertButton::new(text="Cancel", style=Cancel),
    @react_native.AlertButton::new(
      text="OK",
      on_press=Some(fn() { println("OK pressed") }),
    ),
  ])
}
```

### Linking

Open URLs:

```moonbit
async fn open_website() {
  @react_native.open_url("https://reactnative.dev")!
}
```

### Keyboard

Dismiss keyboard:

```moonbit
///|
fn dismiss_keyboard() {
  @react_native.keyboard_dismiss()
}
```

### AppState

Listen to app state changes:

```moonbit
///|
fn setup_app_state_listener() {
  let subscription = @react_native.add_app_state_change_listener(fn(state) {
    match state {
      Active => println("App is active")
      Background => println("App is in background")
      Inactive => println("App is inactive")
      _ => ()
    }
  })
  // Later: subscription.remove()
}
```

### Appearance

Get color scheme:

```moonbit
///|
fn get_theme() -> String {
  match @react_native.get_color_scheme() {
    Light => "light"
    Dark => "dark"
    Unspecified => "system"
  }
}
```

## Hooks

### useColorScheme

Get the user's preferred color scheme:

```moonbit
///|
fn themed_component() -> @react.Element {
  let color_scheme = @react_native.use_color_scheme()
  let bg = match color_scheme {
    Dark => "#000"
    _ => "#fff"
  }
  @react_native.view(
    style=Some(
      @react_native.StyleProp::from_style(
        @react_native.style(flex=1, background_color=bg),
      ),
    ),
    children=[],
  )
}
```

### useWindowDimensions

Get current window dimensions (updates on resize):

```moonbit
///|
fn responsive_component() -> @react.Element {
  let dimensions = @react_native.use_window_dimensions()
  @react_native.text(children=[
    "Width: \{dimensions.width}, Height: \{dimensions.height}",
  ])
}
```

## Animated API

### Basic Animation

```moonbit
///|
fn fade_in_example() {
  let opacity = @react_native.AnimatedValue::new(0.0)
  let animation = @react_native.timing(
    opacity,
    @react_native.TimingConfig::new(to_value=1.0, duration=500),
  )
  animation.start(None)
}
```

### Animated Components

Use `animated_view`, `animated_text`, `animated_image` for animated styles.

### Easing

Available easing functions: `Linear`, `Ease`, `EaseIn`, `EaseOut`, `EaseInOut`, `Bounce`, `Elastic`, etc.

## Available Components

| Component | Description |
|-----------|-------------|
| `view` | Basic container component |
| `text` | Text display component |
| `image` | Image display component |
| `image_background` | Image as background |
| `scroll_view` | Scrollable container |
| `flat_list` | Performant flat list |
| `section_list` | Sectioned list |
| `touchable_opacity` | Touchable with opacity feedback |
| `touchable_highlight` | Touchable with highlight feedback |
| `touchable_without_feedback` | Touchable without visual feedback |
| `touchable_native_feedback` | Android native ripple effect |
| `pressable` | Core pressable component |
| `text_input` | Text input field |
| `button` | Basic button |
| `switch_` | Toggle switch |
| `activity_indicator` | Loading indicator |
| `modal` | Modal dialog |
| `safe_area_view` | Safe area wrapper |
| `status_bar` | Status bar control |
| `keyboard_avoiding_view` | Keyboard-aware container |
| `refresh_control` | Pull-to-refresh |
| `drawer_layout_android` | Android drawer layout |
| `input_accessory_view` | iOS input accessory |

## Available APIs

| API | Description |
|-----|-------------|
| `StyleSheet` | Style creation |
| `style()` | Type-safe style function |
| `Platform` | Platform detection |
| `Dimensions` | Screen dimensions |
| `Alert` | Alert dialogs |
| `Linking` | URL handling |
| `Keyboard` | Keyboard control |
| `AppState` | App lifecycle |
| `PixelRatio` | Pixel density |
| `Appearance` | Color scheme |
| `BackHandler` | Android back button |
| `ToastAndroid` | Android toast messages |
| `PermissionsAndroid` | Android permissions |
| `ActionSheetIOS` | iOS action sheets |
| `Share` | Share dialog |
| `Vibration` | Device vibration |
| `AccessibilityInfo` | Accessibility features |
| `Animated` | Animation API |

## Hooks

| Hook | Description |
|------|-------------|
| `use_color_scheme` | Get color scheme preference |
| `use_window_dimensions` | Get window dimensions |
