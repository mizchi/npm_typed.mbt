///|
test "classMap - applies classes" {
  let classes = @core.new_object()
  classes["active"] = @core.any(true)
  classes["disabled"] = @core.any(false)
  let result = @lit_html.classMap(classes)
  inspect(@core.typeof_(result), content="object")
}

///|
test "styleMap - applies styles" {
  let styles = @core.new_object()
  styles["color"] = @core.any("red")
  styles["fontSize"] = @core.any("14px")
  let result = @lit_html.styleMap(styles)
  inspect(@core.typeof_(result), content="object")
}

///|
test "ifDefined - with value" {
  let result = @lit_html.ifDefined(@core.any("some-value"))
  inspect(@core.typeof_(result), content="string")
}

///|
test "unsafeHTML - renders HTML string" {
  let result = @lit_html.unsafeHTML("<strong>Bold</strong>")
  inspect(@core.typeof_(result), content="object")
}

///|
test "unsafeSVG - renders SVG string" {
  let result = @lit_html.unsafeSVG("<circle/>")
  inspect(@core.typeof_(result), content="object")
}

///|
test "live - wraps value" {
  let result = @lit_html.live(@core.any("value"))
  inspect(@core.typeof_(result), content="object")
}

///|
test "createRef - creates Ref object" {
  let ref_ = @lit_html.createRef()
  inspect(@core.typeof_(ref_), content="object")
}
