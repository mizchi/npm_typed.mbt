///|
/// Tauri DPI - Display scaling utilities
/// https://v2.tauri.app/reference/javascript/api/namespacedpi/

///|
/// Logical position (scaled by DPI factor)
pub(all) struct LogicalPosition {
  x : Double
  y : Double
} derive(Show, ToJson)

///|
pub fn LogicalPosition::to_physical(
  self : LogicalPosition,
  scale_factor : Double,
) -> PhysicalPosition {
  { x: (self.x * scale_factor).to_int(), y: (self.y * scale_factor).to_int() }
}

///|
pub fn LogicalPosition::to_any(self : LogicalPosition) -> @core.Any {
  let obj = @core.new_object()
  obj["type"] = @core.any("Logical")
  obj["x"] = @core.any(self.x)
  obj["y"] = @core.any(self.y)
  obj
}

///|
/// Physical position (actual screen pixels)
pub(all) struct PhysicalPosition {
  x : Int
  y : Int
} derive(Show, ToJson)

///|
pub fn PhysicalPosition::to_logical(
  self : PhysicalPosition,
  scale_factor : Double,
) -> LogicalPosition {
  { x: self.x.to_double() / scale_factor, y: self.y.to_double() / scale_factor }
}

///|
pub fn PhysicalPosition::to_any(self : PhysicalPosition) -> @core.Any {
  let obj = @core.new_object()
  obj["type"] = @core.any("Physical")
  obj["x"] = @core.any(self.x)
  obj["y"] = @core.any(self.y)
  obj
}

///|
/// Logical size (scaled by DPI factor)
pub(all) struct LogicalSize {
  width : Double
  height : Double
} derive(Show, ToJson)

///|
pub fn LogicalSize::to_physical(
  self : LogicalSize,
  scale_factor : Double,
) -> PhysicalSize {
  {
    width: (self.width * scale_factor).to_int(),
    height: (self.height * scale_factor).to_int(),
  }
}

///|
pub fn LogicalSize::to_any(self : LogicalSize) -> @core.Any {
  let obj = @core.new_object()
  obj["type"] = @core.any("Logical")
  obj["width"] = @core.any(self.width)
  obj["height"] = @core.any(self.height)
  obj
}

///|
/// Physical size (actual screen pixels)
pub(all) struct PhysicalSize {
  width : Int
  height : Int
} derive(Show, ToJson)

///|
pub fn PhysicalSize::to_logical(
  self : PhysicalSize,
  scale_factor : Double,
) -> LogicalSize {
  {
    width: self.width.to_double() / scale_factor,
    height: self.height.to_double() / scale_factor,
  }
}

///|
pub fn PhysicalSize::to_any(self : PhysicalSize) -> @core.Any {
  let obj = @core.new_object()
  obj["type"] = @core.any("Physical")
  obj["width"] = @core.any(self.width)
  obj["height"] = @core.any(self.height)
  obj
}

///|
/// Position union type
pub(all) enum Position {
  Logical(LogicalPosition)
  Physical(PhysicalPosition)
}

///|
pub fn Position::to_logical(
  self : Position,
  scale_factor : Double,
) -> LogicalPosition {
  match self {
    Logical(p) => p
    Physical(p) => p.to_logical(scale_factor)
  }
}

///|
pub fn Position::to_physical(
  self : Position,
  scale_factor : Double,
) -> PhysicalPosition {
  match self {
    Logical(p) => p.to_physical(scale_factor)
    Physical(p) => p
  }
}

///|
pub fn Position::to_any(self : Position) -> @core.Any {
  match self {
    Logical(p) => p.to_any()
    Physical(p) => p.to_any()
  }
}

///|
/// Size union type
pub(all) enum Size {
  Logical(LogicalSize)
  Physical(PhysicalSize)
}

///|
pub fn Size::to_logical(self : Size, scale_factor : Double) -> LogicalSize {
  match self {
    Logical(s) => s
    Physical(s) => s.to_logical(scale_factor)
  }
}

///|
pub fn Size::to_physical(self : Size, scale_factor : Double) -> PhysicalSize {
  match self {
    Logical(s) => s.to_physical(scale_factor)
    Physical(s) => s
  }
}

///|
pub fn Size::to_any(self : Size) -> @core.Any {
  match self {
    Logical(s) => s.to_any()
    Physical(s) => s.to_any()
  }
}
