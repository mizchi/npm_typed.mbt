///|
async test "import_lit_html - imports lit-html module" {
  let lit = @lit_html.import_lit_html()
  inspect(@core.typeof_(lit.to_any()), content="object")
}

///|
async test "LitHtml::html - creates TemplateResult" {
  let lit = @lit_html.import_lit_html()
  let tmpl = lit.html("<div>Hello</div>")
  inspect(@core.typeof_(tmpl.to_any()), content="object")
}

///|
async test "LitHtml::html - with interpolation" {
  let lit = @lit_html.import_lit_html()
  let tmpl = lit.html("<div>${@0}</div>", args=[@core.any("World")])
  inspect(@core.typeof_(tmpl.to_any()), content="object")
}

///|
async test "LitHtml::svg - creates SVGTemplateResult" {
  let lit = @lit_html.import_lit_html()
  let tmpl = lit.svg("<circle cx=\"50\" cy=\"50\" r=\"40\"/>")
  inspect(@core.typeof_(tmpl.to_any()), content="object")
}

///|
async test "LitHtml::nothing - returns nothing symbol" {
  let lit = @lit_html.import_lit_html()
  let nothing = lit.nothing()
  inspect(@core.typeof_(nothing), content="symbol")
}

///|
async test "LitHtml::noChange - returns noChange symbol" {
  let lit = @lit_html.import_lit_html()
  let noChange = lit.noChange()
  inspect(@core.typeof_(noChange), content="symbol")
}

///|
async test "import_class_map - imports classMap directive" {
  let classMapModule = @lit_html.import_class_map()
  inspect(@core.typeof_(classMapModule.to_any()), content="object")
}

///|
async test "DirectiveModule::classMap - applies classes" {
  let classMapModule = @lit_html.import_class_map()
  let classes = @core.new_object()
  classes["active"] = @core.any(true)
  classes["disabled"] = @core.any(false)
  let result = classMapModule.classMap(classes)
  inspect(@core.typeof_(result), content="object")
}

///|
async test "import_style_map - imports styleMap directive" {
  let styleMapModule = @lit_html.import_style_map()
  inspect(@core.typeof_(styleMapModule.to_any()), content="object")
}

///|
async test "DirectiveModule::styleMap - applies styles" {
  let styleMapModule = @lit_html.import_style_map()
  let styles = @core.new_object()
  styles["color"] = @core.any("red")
  styles["fontSize"] = @core.any("14px")
  let result = styleMapModule.styleMap(styles)
  inspect(@core.typeof_(result), content="object")
}

///|
async test "import_if_defined - imports ifDefined directive" {
  let ifDefinedModule = @lit_html.import_if_defined()
  inspect(@core.typeof_(ifDefinedModule.to_any()), content="object")
}

///|
async test "DirectiveModule::ifDefined - with value" {
  let ifDefinedModule = @lit_html.import_if_defined()
  let result = ifDefinedModule.ifDefined(@core.any("some-value"))
  // ifDefined returns the value if defined
  inspect(@core.typeof_(result), content="string")
}

///|
async test "import_unsafe_html - imports unsafeHTML directive" {
  let unsafeHtmlModule = @lit_html.import_unsafe_html()
  inspect(@core.typeof_(unsafeHtmlModule.to_any()), content="object")
}

///|
async test "DirectiveModule::unsafeHTML - renders HTML string" {
  let unsafeHtmlModule = @lit_html.import_unsafe_html()
  let result = unsafeHtmlModule.unsafeHTML("<strong>Bold</strong>")
  inspect(@core.typeof_(result), content="object")
}

///|
async test "import_cache - imports cache directive" {
  let cacheModule = @lit_html.import_cache()
  inspect(@core.typeof_(cacheModule.to_any()), content="object")
}

///|
async test "import_ref - imports ref directive" {
  let refModule = @lit_html.import_ref()
  inspect(@core.typeof_(refModule.to_any()), content="object")
}

///|
async test "DirectiveModule::createRef - creates Ref object" {
  let refModule = @lit_html.import_ref()
  let ref_ = refModule.createRef()
  inspect(@core.typeof_(ref_), content="object")
}

///|
async test "import_guard - imports guard directive" {
  let guardModule = @lit_html.import_guard()
  inspect(@core.typeof_(guardModule.to_any()), content="object")
}

///|
async test "import_live - imports live directive" {
  let liveModule = @lit_html.import_live()
  inspect(@core.typeof_(liveModule.to_any()), content="object")
}

///|
async test "DirectiveModule::live - wraps value" {
  let liveModule = @lit_html.import_live()
  let result = liveModule.live(@core.any("value"))
  inspect(@core.typeof_(result), content="object")
}

///|
async test "import_when - imports when directive" {
  let whenModule = @lit_html.import_when()
  inspect(@core.typeof_(whenModule.to_any()), content="object")
}

///|
async test "import_choose - imports choose directive" {
  let chooseModule = @lit_html.import_choose()
  inspect(@core.typeof_(chooseModule.to_any()), content="object")
}

///|
async test "import_map - imports map directive" {
  let mapModule = @lit_html.import_map()
  inspect(@core.typeof_(mapModule.to_any()), content="object")
}

///|
async test "import_join - imports join directive" {
  let joinModule = @lit_html.import_join()
  inspect(@core.typeof_(joinModule.to_any()), content="object")
}

///|
async test "import_range - imports range directive" {
  let rangeModule = @lit_html.import_range()
  inspect(@core.typeof_(rangeModule.to_any()), content="object")
}

///|
async test "import_repeat - imports repeat directive" {
  let repeatModule = @lit_html.import_repeat()
  inspect(@core.typeof_(repeatModule.to_any()), content="object")
}

///|
async test "import_until - imports until directive" {
  let untilModule = @lit_html.import_until()
  inspect(@core.typeof_(untilModule.to_any()), content="object")
}

///|
async test "import_keyed - imports keyed directive" {
  let keyedModule = @lit_html.import_keyed()
  inspect(@core.typeof_(keyedModule.to_any()), content="object")
}
