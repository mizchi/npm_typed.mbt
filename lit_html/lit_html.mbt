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

///| Module cache - async import with global cache

///|
extern "js" fn ffi_get_lit_html() -> @core.Promise[@core.Any] =
  #| () => globalThis.__lit_html ?? (globalThis.__lit_html = import("lit-html"))

///|
extern "js" fn ffi_get_repeat() -> @core.Promise[@core.Any] =
  #| () => globalThis.__lit_repeat ?? (globalThis.__lit_repeat = import("lit-html/directives/repeat.js"))

///|
extern "js" fn ffi_get_until() -> @core.Promise[@core.Any] =
  #| () => globalThis.__lit_until ?? (globalThis.__lit_until = import("lit-html/directives/until.js"))

///|
extern "js" fn ffi_get_guard() -> @core.Promise[@core.Any] =
  #| () => globalThis.__lit_guard ?? (globalThis.__lit_guard = import("lit-html/directives/guard.js"))

///|
extern "js" fn ffi_get_when() -> @core.Promise[@core.Any] =
  #| () => globalThis.__lit_when ?? (globalThis.__lit_when = import("lit-html/directives/when.js"))

///|
extern "js" fn ffi_get_choose() -> @core.Promise[@core.Any] =
  #| () => globalThis.__lit_choose ?? (globalThis.__lit_choose = import("lit-html/directives/choose.js"))

///|
extern "js" fn ffi_get_map() -> @core.Promise[@core.Any] =
  #| () => globalThis.__lit_map ?? (globalThis.__lit_map = import("lit-html/directives/map.js"))

///|
extern "js" fn ffi_get_join() -> @core.Promise[@core.Any] =
  #| () => globalThis.__lit_join ?? (globalThis.__lit_join = import("lit-html/directives/join.js"))

///|
extern "js" fn ffi_get_range() -> @core.Promise[@core.Any] =
  #| () => globalThis.__lit_range ?? (globalThis.__lit_range = import("lit-html/directives/range.js"))

///|
extern "js" fn ffi_get_keyed() -> @core.Promise[@core.Any] =
  #| () => globalThis.__lit_keyed ?? (globalThis.__lit_keyed = import("lit-html/directives/keyed.js"))

///| Initialization - call once before using html/svg/nothing/noChange

///|
/// Initialize lit-html module (call once at app startup)
pub async fn init_lit_html() -> Unit {
  ffi_get_lit_html().wait() |> ignore
}

///| Core Functions - html and svg need spread operator

///|
extern "js" fn ffi_html(
  strings : @core.TemplateStringsArray,
  values : Array[@core.Any],
) -> TemplateResult =
  #| (strings, values) => globalThis.__lit_html.html(strings, ...values)

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
  #| (strings, values) => globalThis.__lit_html.svg(strings, ...values)

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

///| Special Values - these are symbols

///|
extern "js" fn ffi_nothing() -> @core.Any =
  #| () => globalThis.__lit_html.nothing

///|
/// nothing - renders nothing (removes content)
pub fn nothing() -> @core.Any {
  ffi_nothing()
}

///|
extern "js" fn ffi_noChange() -> @core.Any =
  #| () => globalThis.__lit_html.noChange

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

///| Directives with complex signatures - need async init

///|
/// Initialize repeat directive (call before using repeat)
pub async fn init_repeat() -> Unit {
  ffi_get_repeat().wait() |> ignore
}

///|
extern "js" fn ffi_repeat(
  items : @core.Any,
  keyFn : @core.Any,
  template : @core.Any,
) -> @core.Any =
  #| (items, keyFn, template) => globalThis.__lit_repeat.repeat(items, keyFn, template)

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
/// Initialize until directive (call before using until)
pub async fn init_until() -> Unit {
  ffi_get_until().wait() |> ignore
}

///|
extern "js" fn ffi_until(values : Array[@core.Any]) -> @core.Any =
  #| (values) => globalThis.__lit_until.until(...values)

///|
/// until directive - renders placeholder until promise resolves
pub fn until(values : Array[@core.Any]) -> @core.Any {
  ffi_until(values)
}

///|
/// Initialize guard directive (call before using guard_)
pub async fn init_guard() -> Unit {
  ffi_get_guard().wait() |> ignore
}

///|
extern "js" fn ffi_guard(
  deps : Array[@core.Any],
  valueFn : @core.Any,
) -> @core.Any =
  #| (deps, valueFn) => globalThis.__lit_guard.guard(deps, valueFn)

///|
/// guard directive - only re-renders when dependencies change
pub fn guard_(
  deps : Array[@core.Any],
  valueFn : () -> TemplateResult,
) -> @core.Any {
  ffi_guard(deps, @core.any(fn() { valueFn().to_any() }))
}

///|
/// Initialize when directive (call before using when)
pub async fn init_when() -> Unit {
  ffi_get_when().wait() |> ignore
}

///|
extern "js" fn ffi_when(
  condition : Bool,
  trueCase : @core.Any,
  falseCase : @core.Any,
) -> @core.Any =
  #| (condition, trueCase, falseCase) => globalThis.__lit_when.when(condition, trueCase, falseCase)

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
/// Initialize choose directive (call before using choose)
pub async fn init_choose() -> Unit {
  ffi_get_choose().wait() |> ignore
}

///|
extern "js" fn ffi_choose(
  value : @core.Any,
  cases : @core.Any,
  defaultCase : @core.Any,
) -> @core.Any =
  #| (value, cases, defaultCase) => globalThis.__lit_choose.choose(value, cases, defaultCase)

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
/// Initialize map directive (call before using map_)
pub async fn init_map() -> Unit {
  ffi_get_map().wait() |> ignore
}

///|
extern "js" fn ffi_map(items : @core.Any, f : @core.Any) -> @core.Any =
  #| (items, f) => globalThis.__lit_map.map(items, f)

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
/// Initialize join directive (call before using join)
pub async fn init_join() -> Unit {
  ffi_get_join().wait() |> ignore
}

///|
extern "js" fn ffi_join(items : @core.Any, joiner : @core.Any) -> @core.Any =
  #| (items, joiner) => globalThis.__lit_join.join(items, joiner)

///|
/// join directive - join items with separator
pub fn join(items : Array[@core.Any], joiner : @core.Any) -> @core.Any {
  ffi_join(@core.any(items), joiner)
}

///|
/// Initialize range directive (call before using range)
pub async fn init_range() -> Unit {
  ffi_get_range().wait() |> ignore
}

///|
extern "js" fn ffi_range(start : Int, end : Int, step : Int) -> @core.Any =
  #| (start, end, step) => globalThis.__lit_range.range(start, end, step)

///|
/// range directive - generate sequence of numbers
pub fn range(start : Int, end? : Int, step? : Int = 1) -> @core.Any {
  match end {
    Some(e) => ffi_range(start, e, step)
    None => ffi_range(0, start, step)
  }
}

///|
/// Initialize keyed directive (call before using keyed)
pub async fn init_keyed() -> Unit {
  ffi_get_keyed().wait() |> ignore
}

///|
extern "js" fn ffi_keyed(key : @core.Any, value : @core.Any) -> @core.Any =
  #| (key, value) => globalThis.__lit_keyed.keyed(key, value)

///|
/// keyed directive - force re-render when key changes
pub fn keyed(key : @core.Any, value : TemplateResult) -> @core.Any {
  ffi_keyed(key, value.to_any())
}

///|
/// Initialize all directives at once
pub async fn init_all() -> Unit {
  init_lit_html()
  init_repeat()
  init_until()
  init_guard()
  init_when()
  init_choose()
  init_map()
  init_join()
  init_range()
  init_keyed()
}
