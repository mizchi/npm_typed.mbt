///|
/// lit-html - Efficient, Expressive, Extensible HTML templates in JavaScript
/// https://lit.dev/docs/libraries/standalone-templates/

///| Core Types

///|
/// TemplateResult - result of html`` tagged template
#external
pub type TemplateResult

///|
pub fn TemplateResult::to_any(self : TemplateResult) -> @core.Any = "%identity"

///|
/// SVGTemplateResult - result of svg`` tagged template
#external
pub type SVGTemplateResult

///|
pub fn SVGTemplateResult::to_any(self : SVGTemplateResult) -> @core.Any = "%identity"

///| Core Functions - html and svg need spread operator, so use inline JS

///|
extern "js" fn ffi_html(
  strings : @core.TemplateStringsArray,
  values : Array[@core.Any],
) -> TemplateResult =
  #| (strings, values) => require("lit-html").html(strings, ...values)

///|
/// Create HTML template using tagged template syntax
/// Use ${@0}, ${@1}, etc. as placeholders
///
/// Example:
/// ```moonbit
/// let tmpl = html("<div>${@0}</div>", args=[@core.any("Hello")])
/// ```
pub fn html(template : String, args? : Array[@core.Any] = []) -> TemplateResult {
  @core.tag(fn(strings, values) { ffi_html(strings, values) }, template, args)
}

///|
extern "js" fn ffi_svg(
  strings : @core.TemplateStringsArray,
  values : Array[@core.Any],
) -> SVGTemplateResult =
  #| (strings, values) => require("lit-html").svg(strings, ...values)

///|
/// Create SVG template using tagged template syntax
pub fn svg(
  template : String,
  args? : Array[@core.Any] = [],
) -> SVGTemplateResult {
  @core.tag(fn(strings, values) { ffi_svg(strings, values) }, template, args)
}

///|
#module("lit-html")
extern "js" fn ffi_render(
  value : @core.Any,
  container : @core.Any,
  options : @core.Any,
) -> @core.Any = "render"

///|
/// Render a TemplateResult to a container element
/// Returns a RootPart that can be used to update or dispose
pub fn render(
  value : TemplateResult,
  container : @core.Any,
  host? : @core.Any,
  renderBefore? : @core.Any,
  creationScope? : @core.Any,
) -> @core.Any {
  let opts = @core.new_object()
  if host is Some(v) {
    opts["host"] = v
  }
  if renderBefore is Some(v) {
    opts["renderBefore"] = v
  }
  if creationScope is Some(v) {
    opts["creationScope"] = v
  }
  ffi_render(value.to_any(), container, opts)
}

///| Special Values - these are symbols, need inline JS

///|
extern "js" fn ffi_nothing() -> @core.Any =
  #| () => require("lit-html").nothing

///|
/// nothing - renders nothing (removes content)
pub fn nothing() -> @core.Any {
  ffi_nothing()
}

///|
extern "js" fn ffi_noChange() -> @core.Any =
  #| () => require("lit-html").noChange

///|
/// noChange - signals no update needed
pub fn noChange() -> @core.Any {
  ffi_noChange()
}

///| Directives - using #module for direct imports

///|
#module("lit-html/directives/class-map.js")
extern "js" fn ffi_classMap(classInfo : @core.Any) -> @core.Any = "classMap"

///|
/// classMap directive - conditionally apply classes
/// classInfo is { className: boolean }
pub fn classMap(classInfo : @core.Any) -> @core.Any {
  ffi_classMap(classInfo)
}

///|
#module("lit-html/directives/style-map.js")
extern "js" fn ffi_styleMap(styleInfo : @core.Any) -> @core.Any = "styleMap"

///|
/// styleMap directive - apply inline styles from object
/// styleInfo is { property: value }
pub fn styleMap(styleInfo : @core.Any) -> @core.Any {
  ffi_styleMap(styleInfo)
}

///|
#module("lit-html/directives/if-defined.js")
extern "js" fn ffi_ifDefined(value : @core.Any) -> @core.Any = "ifDefined"

///|
/// ifDefined directive - only sets attribute if value is defined
pub fn ifDefined(value : @core.Any) -> @core.Any {
  ffi_ifDefined(value)
}

///|
#module("lit-html/directives/unsafe-html.js")
extern "js" fn ffi_unsafeHTML(value : String) -> @core.Any = "unsafeHTML"

///|
/// unsafeHTML directive - render string as HTML (use with caution!)
pub fn unsafeHTML(value : String) -> @core.Any {
  ffi_unsafeHTML(value)
}

///|
#module("lit-html/directives/unsafe-svg.js")
extern "js" fn ffi_unsafeSVG(value : String) -> @core.Any = "unsafeSVG"

///|
/// unsafeSVG directive - render string as SVG (use with caution!)
pub fn unsafeSVG(value : String) -> @core.Any {
  ffi_unsafeSVG(value)
}

///|
#module("lit-html/directives/cache.js")
extern "js" fn ffi_cache(value : @core.Any) -> @core.Any = "cache"

///|
/// cache directive - caches rendered DOM when switching templates
pub fn cache(value : TemplateResult) -> @core.Any {
  ffi_cache(value.to_any())
}

///|
#module("lit-html/directives/live.js")
extern "js" fn ffi_live(value : @core.Any) -> @core.Any = "live"

///|
/// live directive - checks live DOM value before setting
pub fn live(value : @core.Any) -> @core.Any {
  ffi_live(value)
}

///|
#module("lit-html/directives/ref.js")
extern "js" fn ffi_ref(refOrCallback : @core.Any) -> @core.Any = "ref"

///|
/// ref directive - get reference to rendered element
pub fn ref_(callback : (@core.Any) -> Unit) -> @core.Any {
  ffi_ref(@core.any(callback))
}

///|
#module("lit-html/directives/ref.js")
extern "js" fn ffi_createRef() -> @core.Any = "createRef"

///|
/// Create a Ref object for use with ref directive
pub fn createRef() -> @core.Any {
  ffi_createRef()
}

///| Directives with complex signatures - need wrapper functions

///|
extern "js" fn ffi_repeat(
  items : @core.Any,
  keyFn : @core.Any,
  template : @core.Any,
) -> @core.Any =
  #| (items, keyFn, template) => require("lit-html/directives/repeat.js").repeat(items, keyFn, template)

///|
/// repeat directive - efficiently renders lists with keys
pub fn repeat(
  items : Array[@core.Any],
  keyFn : (@core.Any) -> @core.Any,
  template : (@core.Any, Int) -> TemplateResult,
) -> @core.Any {
  ffi_repeat(
    @core.any(items),
    @core.any(keyFn),
    @core.any(fn(item : @core.Any, index : @core.Any) {
      template(item, index.cast())
    }),
  )
}

///|
extern "js" fn ffi_until(values : Array[@core.Any]) -> @core.Any =
  #| (values) => require("lit-html/directives/until.js").until(...values)

///|
/// until directive - renders placeholder until promise resolves
pub fn until(values : Array[@core.Any]) -> @core.Any {
  ffi_until(values)
}

///|
extern "js" fn ffi_guard(
  deps : Array[@core.Any],
  valueFn : @core.Any,
) -> @core.Any =
  #| (deps, valueFn) => require("lit-html/directives/guard.js").guard(deps, valueFn)

///|
/// guard directive - only re-renders when dependencies change
pub fn guard_(
  deps : Array[@core.Any],
  valueFn : () -> TemplateResult,
) -> @core.Any {
  ffi_guard(deps, @core.any(fn() { valueFn().to_any() }))
}

///|
extern "js" fn ffi_when(
  condition : Bool,
  trueCase : @core.Any,
  falseCase : @core.Any,
) -> @core.Any =
  #| (condition, trueCase, falseCase) => require("lit-html/directives/when.js").when(condition, trueCase, falseCase)

///|
/// when directive - conditional rendering
pub fn when(
  condition : Bool,
  trueCase : () -> TemplateResult,
  falseCase? : () -> TemplateResult,
) -> @core.Any {
  let false_fn = match falseCase {
    Some(f) => @core.any(fn() { f().to_any() })
    None => @core.undefined()
  }
  ffi_when(condition, @core.any(fn() { trueCase().to_any() }), false_fn)
}

///|
extern "js" fn ffi_choose(
  value : @core.Any,
  cases : @core.Any,
  defaultCase : @core.Any,
) -> @core.Any =
  #| (value, cases, defaultCase) => require("lit-html/directives/choose.js").choose(value, cases, defaultCase)

///|
extern "js" fn ffi_make_case_pair(
  key : @core.Any,
  valueFn : @core.Any,
) -> @core.Any =
  #| (key, valueFn) => [key, valueFn]

///|
extern "js" fn ffi_push_array(arr : @core.Any, item : @core.Any) -> Unit =
  #| (arr, item) => { arr.push(item) }

///|
/// choose directive - switch-like conditional rendering
pub fn choose(
  value : @core.Any,
  cases : Array[(@core.Any, () -> TemplateResult)],
  defaultCase? : () -> TemplateResult,
) -> @core.Any {
  let js_cases = @core.new_array()
  for case_ in cases {
    let (key, tmpl) = case_
    let pair = ffi_make_case_pair(key, @core.any(fn() { tmpl().to_any() }))
    ffi_push_array(js_cases, pair)
  }
  let default_fn = match defaultCase {
    Some(f) => @core.any(fn() { f().to_any() })
    None => @core.undefined()
  }
  ffi_choose(value, js_cases, default_fn)
}

///|
extern "js" fn ffi_map(items : @core.Any, f : @core.Any) -> @core.Any =
  #| (items, f) => require("lit-html/directives/map.js").map(items, f)

///|
/// map directive - transform items to templates
pub fn map_(
  items : Array[@core.Any],
  f : (@core.Any, Int) -> TemplateResult,
) -> @core.Any {
  ffi_map(
    @core.any(items),
    @core.any(fn(item : @core.Any, index : @core.Any) { f(item, index.cast()) }),
  )
}

///|
extern "js" fn ffi_join(items : @core.Any, joiner : @core.Any) -> @core.Any =
  #| (items, joiner) => require("lit-html/directives/join.js").join(items, joiner)

///|
/// join directive - join items with separator
pub fn join(items : Array[@core.Any], joiner : @core.Any) -> @core.Any {
  ffi_join(@core.any(items), joiner)
}

///|
extern "js" fn ffi_range(start : Int, end : Int, step : Int) -> @core.Any =
  #| (start, end, step) => require("lit-html/directives/range.js").range(start, end, step)

///|
/// range directive - generate sequence of numbers
pub fn range(start : Int, end? : Int, step? : Int = 1) -> @core.Any {
  match end {
    Some(e) => ffi_range(start, e, step)
    None => ffi_range(0, start, step)
  }
}

///|
extern "js" fn ffi_keyed(key : @core.Any, value : @core.Any) -> @core.Any =
  #| (key, value) => require("lit-html/directives/keyed.js").keyed(key, value)

///|
/// keyed directive - force re-render when key changes
pub fn keyed(key : @core.Any, value : TemplateResult) -> @core.Any {
  ffi_keyed(key, value.to_any())
}
