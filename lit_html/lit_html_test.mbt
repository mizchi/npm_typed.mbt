///| directive tests - classMap

///|
test "classMap - conditionally applies classes" {
  let classes = @core.new_object()
  classes["active"] = @core.any(true)
  classes["disabled"] = @core.any(false)
  classes["highlight"] = @core.any(true)
  let directive = @lit_html.classMap(classes)
  // classMap returns a directive result
  inspect(@core.typeof_(directive), content="object")
}

///| directive tests - styleMap

///|
test "styleMap - applies inline styles" {
  let styles = @core.new_object()
  styles["color"] = @core.any("red")
  styles["fontSize"] = @core.any("16px")
  styles["backgroundColor"] = @core.any("#f0f0f0")
  let directive = @lit_html.styleMap(styles)
  inspect(@core.typeof_(directive), content="object")
}

///| directive tests - ifDefined

///|
test "ifDefined - with defined value" {
  let value = "defined"
  let result = @lit_html.ifDefined(@core.any(value))
  inspect(@core.typeof_(result), content="string")
}

///|
test "ifDefined - with undefined" {
  let result = @lit_html.ifDefined(@core.undefined())
  // Returns nothing symbol when input is undefined (lit-html behavior)
  inspect(@core.typeof_(result), content="symbol")
}

///| directive tests - unsafe HTML/SVG

///|
test "unsafeHTML - renders raw HTML" {
  let rawHtml = "<strong>Bold</strong> and <em>italic</em>"
  let directive = @lit_html.unsafeHTML(rawHtml)
  inspect(@core.typeof_(directive), content="object")
}

///|
test "unsafeSVG - renders raw SVG" {
  let rawSvg = "<path d=\"M10 10 L90 90\"/>"
  let directive = @lit_html.unsafeSVG(rawSvg)
  inspect(@core.typeof_(directive), content="object")
}

///| directive tests - live

///|
test "live - for input value binding" {
  let inputValue = "current value"
  let directive = @lit_html.live(@core.any(inputValue))
  inspect(@core.typeof_(directive), content="object")
}

///| directive tests - ref

///|
test "createRef - creates ref object" {
  let myRef = @lit_html.createRef()
  inspect(@core.typeof_(myRef), content="object")
}
