///|
/// PreactNode trait - types that can be children in Preact
pub(open) trait PreactNode {
  fn to_preact_node(Self) -> @core.Any
}

///|
pub impl PreactNode for VNode with fn to_preact_node(self) {
  self.as_any()
}

///|
pub impl PreactNode for String with fn to_preact_node(self) {
  @core.any(self)
}

///|
pub impl PreactNode for Int with fn to_preact_node(self) {
  @core.any(self)
}

///|
pub impl PreactNode for Double with fn to_preact_node(self) {
  @core.any(self)
}

///|
pub impl PreactNode for Bool with fn to_preact_node(self) {
  @core.any(self)
}

///|
pub impl PreactNode for Array[&PreactNode] with fn to_preact_node(self) {
  @core.any(self.map(node => node.to_preact_node()))
}

///|
pub impl[T : PreactNode] PreactNode for T? with fn to_preact_node(self) {
  match self {
    Some(v) => v.to_preact_node()
    None => @core.null()
  }
}
