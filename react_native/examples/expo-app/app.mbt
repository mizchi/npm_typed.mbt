///|
/// MoonBit React Native Sample App

///|
using @react_native {
  type Style,
  type StyleProp,
  type AlignItems,
  type FlexDirection,
  type FontWeight,
  view,
  text,
  style,
}

// ============================================================================
// Styles
// ============================================================================

///|
let containerStyle : Style = style(
  flex=1,
  background_color="#f5f5f5",
  padding_top=80.0,
  padding_horizontal=24.0,
  padding_bottom=24.0,
)

///|
let headerStyle : Style = style(
  background_color="#fff",
  padding=24.0,
  border_radius=12.0,
  margin_bottom=16.0,
  align_items=AlignItems::Center,
)

///|
let titleStyle : Style = style(
  font_size=28.0,
  font_weight=FontWeight::Bold,
  color="#333",
  margin_bottom=8.0,
)

///|
let subtitleStyle : Style = style(font_size=16.0, color="#666")

///|
let cardStyle : Style = style(
  background_color="#fff",
  padding=20.0,
  border_radius=12.0,
  margin_bottom=12.0,
)

///|
let cardTitleStyle : Style = style(
  font_size=18.0,
  font_weight=FontWeight::W600,
  color="#333",
  margin_bottom=8.0,
)

///|
let cardTextStyle : Style = style(
  font_size=14.0,
  color="#666",
  line_height=20.0,
)

///|
let emojiStyle : Style = style(font_size=32.0, margin_right=12.0)

///|
let rowStyle : Style = style(
  flex_direction=FlexDirection::Row,
  align_items=AlignItems::Center,
)

///|
let footerStyle : Style = style(
  margin_top=16.0,
  padding=16.0,
  background_color="#fff",
  border_radius=12.0,
  align_items=AlignItems::Center,
)

///|
let footerTextStyle : Style = style(font_size=12.0, color="#999")

// ============================================================================
// App Component
// ============================================================================

///|
fn app_component() -> @react.Element {
  view(style=Some(StyleProp::from_style(containerStyle)), children=[
    // Header
    view(style=Some(StyleProp::from_style(headerStyle)), children=[
      text(style=Some(StyleProp::from_style(titleStyle)), children=[
        "🌙 MoonBit × React Native",
      ]),
      text(style=Some(StyleProp::from_style(subtitleStyle)), children=[
        "Type-safe mobile development",
      ]),
    ]),
    // Feature cards
    view(style=Some(StyleProp::from_style(cardStyle)), children=[
      view(style=Some(StyleProp::from_style(rowStyle)), children=[
        text(style=Some(StyleProp::from_style(emojiStyle)), children=["✨"]),
        view(children=[
          text(style=Some(StyleProp::from_style(cardTitleStyle)), children=[
            "Type Safety",
          ]),
          text(style=Some(StyleProp::from_style(cardTextStyle)), children=[
            "Compile-time type checking with MoonBit",
          ]),
        ]),
      ]),
    ]),
    view(style=Some(StyleProp::from_style(cardStyle)), children=[
      view(style=Some(StyleProp::from_style(rowStyle)), children=[
        text(style=Some(StyleProp::from_style(emojiStyle)), children=["⚡"]),
        view(children=[
          text(style=Some(StyleProp::from_style(cardTitleStyle)), children=[
            "FFI Bindings",
          ]),
          text(style=Some(StyleProp::from_style(cardTextStyle)), children=[
            "Seamless JavaScript interop",
          ]),
        ]),
      ]),
    ]),
    view(style=Some(StyleProp::from_style(cardStyle)), children=[
      view(style=Some(StyleProp::from_style(rowStyle)), children=[
        text(style=Some(StyleProp::from_style(emojiStyle)), children=["🎨"]),
        view(children=[
          text(style=Some(StyleProp::from_style(cardTitleStyle)), children=[
            "Type-safe Styles",
          ]),
          text(style=Some(StyleProp::from_style(cardTextStyle)), children=[
            "Enums for all style properties",
          ]),
        ]),
      ]),
    ]),
    // Footer
    view(style=Some(StyleProp::from_style(footerStyle)), children=[
      text(style=Some(StyleProp::from_style(footerTextStyle)), children=[
        "Built with MoonBit FFI",
      ]),
    ]),
  ])
}

///|
pub fn app() -> @react.Element {
  app_component()
}
