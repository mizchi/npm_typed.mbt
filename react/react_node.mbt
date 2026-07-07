///|
/// Renderable React node types.
/// Int, Double, Bool, String, ReactElement, Array of ReactNode, Option of ReactNode
pub(open) trait ReactNode {
  fn to_react_node(Self) -> @core.Any
}

///|
pub impl ReactNode for String with fn to_react_node(self) {
  @core.any(self)
}

///|
pub impl ReactNode for Element with fn to_react_node(self) {
  self.as_any()
}

///|
pub impl ReactNode for Int with fn to_react_node(self) {
  @core.any(self)
}

///|
pub impl ReactNode for Double with fn to_react_node(self) {
  @core.any(self)
}

///|
pub impl ReactNode for Bool with fn to_react_node(self) {
  @core.any(self)
}

///|
pub impl ReactNode for Array[&ReactNode] with fn to_react_node(self) {
  @core.any(self.map(x => x.to_react_node()))
}

///|
pub impl[T : ReactNode] ReactNode for T? with fn to_react_node(self) {
  match self {
    Some(v) => v.to_react_node()
    None => @core.undefined()
  }
}
