///|
/// MoonBit React Native App

///|
using @react_native {type Style, type StyleProp, type StyleSheet, view, text}

///|
let styles : Map[String, Style] = StyleSheet::create({
  "container": {
    "flex": @core.any(1),
    "backgroundColor": @core.any("#fff"),
    "alignItems": @core.any("center"),
    "justifyContent": @core.any("center"),
  },
  "title": { "color": @core.any("#F00"), "fontSize": @core.any(36) },
})

///|
fn app_component() -> @react.Element {
  view(style=Some(StyleProp::from_style(styles["container"])), children=[
    text(style=Some(StyleProp::from_style(styles["title"])), children=[
      "Hello from MoonBit!",
    ]),
  ])
}

///|
pub fn app() -> @react.Element {
  app_component()
}
