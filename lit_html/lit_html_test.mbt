///|
test "html - creates TemplateResult" {
  let tmpl = @lit_html.html("<div>Hello</div>")
  inspect(@core.typeof_(tmpl.to_any()), content="object")
}

///|
test "html - with interpolation" {
  let tmpl = @lit_html.html("<div>${@0}</div>", args=[@core.any("World")])
  inspect(@core.typeof_(tmpl.to_any()), content="object")
}

///|
test "svg - creates SVGTemplateResult" {
  let tmpl = @lit_html.svg("<circle cx=\"50\" cy=\"50\" r=\"40\"/>")
  inspect(@core.typeof_(tmpl.to_any()), content="object")
}

///|
test "nothing - returns nothing symbol" {
  let nothing = @lit_html.nothing()
  inspect(@core.typeof_(nothing), content="symbol")
}

///|
test "noChange - returns noChange symbol" {
  let noChange = @lit_html.noChange()
  inspect(@core.typeof_(noChange), content="symbol")
}

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
  // ifDefined returns the value if defined
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
test "cache - wraps template" {
  let tmpl = @lit_html.html("<div>cached</div>")
  let result = @lit_html.cache(tmpl)
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

///|
test "keyed - wraps template with key" {
  let tmpl = @lit_html.html("<div>item</div>")
  let result = @lit_html.keyed(@core.any("key1"), tmpl)
  inspect(@core.typeof_(result), content="object")
}

///|
test "until - wraps values" {
  let result = @lit_html.until([@core.any("loading...")])
  inspect(@core.typeof_(result), content="object")
}

///|
test "join - joins items" {
  let result = @lit_html.join([@core.any("a"), @core.any("b")], @core.any(", "))
  inspect(@core.typeof_(result), content="object")
}

///|
test "range - generates sequence" {
  let result = @lit_html.range(5)
  inspect(@core.typeof_(result), content="object")
}

///|
test "range - with start and end" {
  let result = @lit_html.range(1, end=10, step=2)
  inspect(@core.typeof_(result), content="object")
}
