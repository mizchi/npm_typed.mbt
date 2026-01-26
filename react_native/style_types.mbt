///| Type-safe Style API for React Native
/// Provides named arguments for type-safe style definitions

// ============================================================================
// Layout Enums
// ============================================================================

///|
/// FlexDirection - Controls the direction of the main axis
pub(all) enum FlexDirection {
  Row
  RowReverse
  Column
  ColumnReverse
}

///|
pub fn FlexDirection::to_string(self : FlexDirection) -> String {
  match self {
    Row => "row"
    RowReverse => "row-reverse"
    Column => "column"
    ColumnReverse => "column-reverse"
  }
}

///|
/// JustifyContent - Alignment along the main axis
pub(all) enum JustifyContent {
  FlexStart
  FlexEnd
  Center
  SpaceBetween
  SpaceAround
  SpaceEvenly
}

///|
pub fn JustifyContent::to_string(self : JustifyContent) -> String {
  match self {
    FlexStart => "flex-start"
    FlexEnd => "flex-end"
    Center => "center"
    SpaceBetween => "space-between"
    SpaceAround => "space-around"
    SpaceEvenly => "space-evenly"
  }
}

///|
/// AlignItems - Alignment along the cross axis
pub(all) enum AlignItems {
  FlexStart
  FlexEnd
  Center
  Stretch
  Baseline
}

///|
pub fn AlignItems::to_string(self : AlignItems) -> String {
  match self {
    FlexStart => "flex-start"
    FlexEnd => "flex-end"
    Center => "center"
    Stretch => "stretch"
    Baseline => "baseline"
  }
}

///|
/// AlignSelf - Override alignItems for individual items
pub(all) enum AlignSelf {
  Auto
  FlexStart
  FlexEnd
  Center
  Stretch
  Baseline
}

///|
pub fn AlignSelf::to_string(self : AlignSelf) -> String {
  match self {
    Auto => "auto"
    FlexStart => "flex-start"
    FlexEnd => "flex-end"
    Center => "center"
    Stretch => "stretch"
    Baseline => "baseline"
  }
}

///|
/// AlignContent - Alignment of wrapped lines
pub(all) enum AlignContent {
  FlexStart
  FlexEnd
  Center
  Stretch
  SpaceBetween
  SpaceAround
}

///|
pub fn AlignContent::to_string(self : AlignContent) -> String {
  match self {
    FlexStart => "flex-start"
    FlexEnd => "flex-end"
    Center => "center"
    Stretch => "stretch"
    SpaceBetween => "space-between"
    SpaceAround => "space-around"
  }
}

///|
/// FlexWrap - Whether to wrap children
pub(all) enum FlexWrap {
  NoWrap
  Wrap
  WrapReverse
}

///|
pub fn FlexWrap::to_string(self : FlexWrap) -> String {
  match self {
    NoWrap => "nowrap"
    Wrap => "wrap"
    WrapReverse => "wrap-reverse"
  }
}

///|
/// Position - Positioning type
pub(all) enum Position {
  Absolute
  Relative
}

///|
pub fn Position::to_string(self : Position) -> String {
  match self {
    Absolute => "absolute"
    Relative => "relative"
  }
}

///|
/// Overflow - How to handle overflow
pub(all) enum Overflow {
  Visible
  Hidden
  Scroll
}

///|
pub fn Overflow::to_string(self : Overflow) -> String {
  match self {
    Visible => "visible"
    Hidden => "hidden"
    Scroll => "scroll"
  }
}

///|
/// Display - Display type
pub(all) enum Display {
  None
  Flex
}

///|
pub fn Display::to_string(self : Display) -> String {
  match self {
    None => "none"
    Flex => "flex"
  }
}

// ============================================================================
// Text Enums
// ============================================================================

///|
/// TextAlign - Text horizontal alignment
pub(all) enum TextAlign {
  Auto
  Left
  Right
  Center
  Justify
}

///|
pub fn TextAlign::to_string(self : TextAlign) -> String {
  match self {
    Auto => "auto"
    Left => "left"
    Right => "right"
    Center => "center"
    Justify => "justify"
  }
}

///|
/// TextAlignVertical - Text vertical alignment (Android)
pub(all) enum TextAlignVertical {
  Auto
  Top
  Bottom
  Center
}

///|
pub fn TextAlignVertical::to_string(self : TextAlignVertical) -> String {
  match self {
    Auto => "auto"
    Top => "top"
    Bottom => "bottom"
    Center => "center"
  }
}

///|
/// FontStyle - Font style
pub(all) enum FontStyle {
  Normal
  Italic
}

///|
pub fn FontStyle::to_string(self : FontStyle) -> String {
  match self {
    Normal => "normal"
    Italic => "italic"
  }
}

///|
/// FontWeight - Font weight
pub(all) enum FontWeight {
  Normal
  Bold
  W100
  W200
  W300
  W400
  W500
  W600
  W700
  W800
  W900
}

///|
pub fn FontWeight::to_string(self : FontWeight) -> String {
  match self {
    Normal => "normal"
    Bold => "bold"
    W100 => "100"
    W200 => "200"
    W300 => "300"
    W400 => "400"
    W500 => "500"
    W600 => "600"
    W700 => "700"
    W800 => "800"
    W900 => "900"
  }
}

///|
/// TextDecorationLine - Text decoration
pub(all) enum TextDecorationLine {
  None
  Underline
  LineThrough
  UnderlineLineThrough
}

///|
pub fn TextDecorationLine::to_string(self : TextDecorationLine) -> String {
  match self {
    None => "none"
    Underline => "underline"
    LineThrough => "line-through"
    UnderlineLineThrough => "underline line-through"
  }
}

///|
/// TextTransform - Text case transformation
pub(all) enum TextTransform {
  None
  Capitalize
  Uppercase
  Lowercase
}

///|
pub fn TextTransform::to_string(self : TextTransform) -> String {
  match self {
    None => "none"
    Capitalize => "capitalize"
    Uppercase => "uppercase"
    Lowercase => "lowercase"
  }
}

// ============================================================================
// Border Enums
// ============================================================================

///|
/// BorderStyle - Border line style
pub(all) enum BorderStyle {
  Solid
  Dotted
  Dashed
}

///|
pub fn BorderStyle::to_string(self : BorderStyle) -> String {
  match self {
    Solid => "solid"
    Dotted => "dotted"
    Dashed => "dashed"
  }
}

// ============================================================================
// Image Enums
// ============================================================================

///|
/// ResizeMode - Image resize mode
pub(all) enum ResizeMode {
  Cover
  Contain
  Stretch
  Repeat
  Center
}

///|
pub fn ResizeMode::to_string(self : ResizeMode) -> String {
  match self {
    Cover => "cover"
    Contain => "contain"
    Stretch => "stretch"
    Repeat => "repeat"
    Center => "center"
  }
}

// ============================================================================
// Type-safe style() function
// ============================================================================

///|
/// Create a type-safe Style with named arguments
pub fn style(
  // Layout
  flex? : Int,
  flex_grow? : Int,
  flex_shrink? : Int,
  flex_basis? : Double,
  flex_direction? : FlexDirection,
  justify_content? : JustifyContent,
  align_items? : AlignItems,
  align_self? : AlignSelf,
  align_content? : AlignContent,
  flex_wrap? : FlexWrap,
  // Sizing
  width? : Double,
  height? : Double,
  min_width? : Double,
  max_width? : Double,
  min_height? : Double,
  max_height? : Double,
  aspect_ratio? : Double,
  // Margin
  margin? : Double,
  margin_top? : Double,
  margin_right? : Double,
  margin_bottom? : Double,
  margin_left? : Double,
  margin_horizontal? : Double,
  margin_vertical? : Double,
  // Padding
  padding? : Double,
  padding_top? : Double,
  padding_right? : Double,
  padding_bottom? : Double,
  padding_left? : Double,
  padding_horizontal? : Double,
  padding_vertical? : Double,
  // Position
  position? : Position,
  top? : Double,
  right? : Double,
  bottom? : Double,
  left? : Double,
  z_index? : Int,
  // Border
  border_width? : Double,
  border_top_width? : Double,
  border_right_width? : Double,
  border_bottom_width? : Double,
  border_left_width? : Double,
  border_color? : String,
  border_top_color? : String,
  border_right_color? : String,
  border_bottom_color? : String,
  border_left_color? : String,
  border_radius? : Double,
  border_top_left_radius? : Double,
  border_top_right_radius? : Double,
  border_bottom_left_radius? : Double,
  border_bottom_right_radius? : Double,
  border_style? : BorderStyle,
  // Background
  background_color? : String,
  opacity? : Double,
  // Text
  color? : String,
  font_size? : Double,
  font_weight? : FontWeight,
  font_style? : FontStyle,
  font_family? : String,
  text_align? : TextAlign,
  text_align_vertical? : TextAlignVertical,
  text_decoration_line? : TextDecorationLine,
  text_transform? : TextTransform,
  line_height? : Double,
  letter_spacing? : Double,
  // Shadow (iOS)
  shadow_color? : String,
  shadow_offset_width? : Double,
  shadow_offset_height? : Double,
  shadow_opacity? : Double,
  shadow_radius? : Double,
  // Shadow (Android)
  elevation? : Int,
  // Display & Overflow
  display? : Display,
  overflow? : Overflow,
  // Image
  resize_mode? : ResizeMode,
  tint_color? : String,
  // Transform (simplified - single values)
  rotate? : String,
  scale? : Double,
  translate_x? : Double,
  translate_y? : Double,
) -> Style {
  let obj = @core.new_object()

  // Layout
  if flex is Some(v) {
    obj._set("flex", @core.any(v))
  }
  if flex_grow is Some(v) {
    obj._set("flexGrow", @core.any(v))
  }
  if flex_shrink is Some(v) {
    obj._set("flexShrink", @core.any(v))
  }
  if flex_basis is Some(v) {
    obj._set("flexBasis", @core.any(v))
  }
  if flex_direction is Some(v) {
    obj._set("flexDirection", @core.any(v.to_string()))
  }
  if justify_content is Some(v) {
    obj._set("justifyContent", @core.any(v.to_string()))
  }
  if align_items is Some(v) {
    obj._set("alignItems", @core.any(v.to_string()))
  }
  if align_self is Some(v) {
    obj._set("alignSelf", @core.any(v.to_string()))
  }
  if align_content is Some(v) {
    obj._set("alignContent", @core.any(v.to_string()))
  }
  if flex_wrap is Some(v) {
    obj._set("flexWrap", @core.any(v.to_string()))
  }

  // Sizing
  if width is Some(v) {
    obj._set("width", @core.any(v))
  }
  if height is Some(v) {
    obj._set("height", @core.any(v))
  }
  if min_width is Some(v) {
    obj._set("minWidth", @core.any(v))
  }
  if max_width is Some(v) {
    obj._set("maxWidth", @core.any(v))
  }
  if min_height is Some(v) {
    obj._set("minHeight", @core.any(v))
  }
  if max_height is Some(v) {
    obj._set("maxHeight", @core.any(v))
  }
  if aspect_ratio is Some(v) {
    obj._set("aspectRatio", @core.any(v))
  }

  // Margin
  if margin is Some(v) {
    obj._set("margin", @core.any(v))
  }
  if margin_top is Some(v) {
    obj._set("marginTop", @core.any(v))
  }
  if margin_right is Some(v) {
    obj._set("marginRight", @core.any(v))
  }
  if margin_bottom is Some(v) {
    obj._set("marginBottom", @core.any(v))
  }
  if margin_left is Some(v) {
    obj._set("marginLeft", @core.any(v))
  }
  if margin_horizontal is Some(v) {
    obj._set("marginHorizontal", @core.any(v))
  }
  if margin_vertical is Some(v) {
    obj._set("marginVertical", @core.any(v))
  }

  // Padding
  if padding is Some(v) {
    obj._set("padding", @core.any(v))
  }
  if padding_top is Some(v) {
    obj._set("paddingTop", @core.any(v))
  }
  if padding_right is Some(v) {
    obj._set("paddingRight", @core.any(v))
  }
  if padding_bottom is Some(v) {
    obj._set("paddingBottom", @core.any(v))
  }
  if padding_left is Some(v) {
    obj._set("paddingLeft", @core.any(v))
  }
  if padding_horizontal is Some(v) {
    obj._set("paddingHorizontal", @core.any(v))
  }
  if padding_vertical is Some(v) {
    obj._set("paddingVertical", @core.any(v))
  }

  // Position
  if position is Some(v) {
    obj._set("position", @core.any(v.to_string()))
  }
  if top is Some(v) {
    obj._set("top", @core.any(v))
  }
  if right is Some(v) {
    obj._set("right", @core.any(v))
  }
  if bottom is Some(v) {
    obj._set("bottom", @core.any(v))
  }
  if left is Some(v) {
    obj._set("left", @core.any(v))
  }
  if z_index is Some(v) {
    obj._set("zIndex", @core.any(v))
  }

  // Border width
  if border_width is Some(v) {
    obj._set("borderWidth", @core.any(v))
  }
  if border_top_width is Some(v) {
    obj._set("borderTopWidth", @core.any(v))
  }
  if border_right_width is Some(v) {
    obj._set("borderRightWidth", @core.any(v))
  }
  if border_bottom_width is Some(v) {
    obj._set("borderBottomWidth", @core.any(v))
  }
  if border_left_width is Some(v) {
    obj._set("borderLeftWidth", @core.any(v))
  }

  // Border color
  if border_color is Some(v) {
    obj._set("borderColor", @core.any(v))
  }
  if border_top_color is Some(v) {
    obj._set("borderTopColor", @core.any(v))
  }
  if border_right_color is Some(v) {
    obj._set("borderRightColor", @core.any(v))
  }
  if border_bottom_color is Some(v) {
    obj._set("borderBottomColor", @core.any(v))
  }
  if border_left_color is Some(v) {
    obj._set("borderLeftColor", @core.any(v))
  }

  // Border radius
  if border_radius is Some(v) {
    obj._set("borderRadius", @core.any(v))
  }
  if border_top_left_radius is Some(v) {
    obj._set("borderTopLeftRadius", @core.any(v))
  }
  if border_top_right_radius is Some(v) {
    obj._set("borderTopRightRadius", @core.any(v))
  }
  if border_bottom_left_radius is Some(v) {
    obj._set("borderBottomLeftRadius", @core.any(v))
  }
  if border_bottom_right_radius is Some(v) {
    obj._set("borderBottomRightRadius", @core.any(v))
  }
  if border_style is Some(v) {
    obj._set("borderStyle", @core.any(v.to_string()))
  }

  // Background
  if background_color is Some(v) {
    obj._set("backgroundColor", @core.any(v))
  }
  if opacity is Some(v) {
    obj._set("opacity", @core.any(v))
  }

  // Text
  if color is Some(v) {
    obj._set("color", @core.any(v))
  }
  if font_size is Some(v) {
    obj._set("fontSize", @core.any(v))
  }
  if font_weight is Some(v) {
    obj._set("fontWeight", @core.any(v.to_string()))
  }
  if font_style is Some(v) {
    obj._set("fontStyle", @core.any(v.to_string()))
  }
  if font_family is Some(v) {
    obj._set("fontFamily", @core.any(v))
  }
  if text_align is Some(v) {
    obj._set("textAlign", @core.any(v.to_string()))
  }
  if text_align_vertical is Some(v) {
    obj._set("textAlignVertical", @core.any(v.to_string()))
  }
  if text_decoration_line is Some(v) {
    obj._set("textDecorationLine", @core.any(v.to_string()))
  }
  if text_transform is Some(v) {
    obj._set("textTransform", @core.any(v.to_string()))
  }
  if line_height is Some(v) {
    obj._set("lineHeight", @core.any(v))
  }
  if letter_spacing is Some(v) {
    obj._set("letterSpacing", @core.any(v))
  }

  // Shadow (iOS)
  if shadow_color is Some(v) {
    obj._set("shadowColor", @core.any(v))
  }
  if shadow_offset_width is Some(sc_w) {
    let offset = @core.new_object()
    offset._set("width", @core.any(sc_w))
    if shadow_offset_height is Some(sc_h) {
      offset._set("height", @core.any(sc_h))
    } else {
      offset._set("height", @core.any(0))
    }
    obj._set("shadowOffset", offset)
  } else if shadow_offset_height is Some(sc_h) {
    let offset = @core.new_object()
    offset._set("width", @core.any(0))
    offset._set("height", @core.any(sc_h))
    obj._set("shadowOffset", offset)
  }
  if shadow_opacity is Some(v) {
    obj._set("shadowOpacity", @core.any(v))
  }
  if shadow_radius is Some(v) {
    obj._set("shadowRadius", @core.any(v))
  }

  // Shadow (Android)
  if elevation is Some(v) {
    obj._set("elevation", @core.any(v))
  }

  // Display & Overflow
  if display is Some(v) {
    obj._set("display", @core.any(v.to_string()))
  }
  if overflow is Some(v) {
    obj._set("overflow", @core.any(v.to_string()))
  }

  // Image
  if resize_mode is Some(v) {
    obj._set("resizeMode", @core.any(v.to_string()))
  }
  if tint_color is Some(v) {
    obj._set("tintColor", @core.any(v))
  }

  // Transform
  let transforms : Array[@core.Any] = []
  if rotate is Some(v) {
    let t = @core.new_object()
    t._set("rotate", @core.any(v))
    transforms.push(t)
  }
  if scale is Some(v) {
    let t = @core.new_object()
    t._set("scale", @core.any(v))
    transforms.push(t)
  }
  if translate_x is Some(v) {
    let t = @core.new_object()
    t._set("translateX", @core.any(v))
    transforms.push(t)
  }
  if translate_y is Some(v) {
    let t = @core.new_object()
    t._set("translateY", @core.any(v))
    transforms.push(t)
  }
  if transforms.length() > 0 {
    obj._set("transform", @core.any(transforms))
  }
  Style::from_any(obj)
}
