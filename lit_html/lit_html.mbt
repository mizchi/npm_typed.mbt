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

///| FFI Functions

///|
extern "js" fn ffi_import_lit_html() -> @core.Promise[LitHtml] =
  #| () => import("lit-html")

///|
/// LitHtml module - contains all lit-html exports
#external
pub type LitHtml

///|
pub fn LitHtml::to_any(self : LitHtml) -> @core.Any = "%identity"

///|
/// Import lit-html module
pub async fn import_lit_html() -> LitHtml {
  ffi_import_lit_html().wait()
}

///| Core Functions

///|
extern "js" fn ffi_html(
  m : LitHtml,
  strings : @core.TemplateStringsArray,
  values : Array[@core.Any],
) -> TemplateResult =
  #| (m, strings, values) => m.html(strings, ...values)

///|
/// Create HTML template using tagged template syntax
/// Use ${@0}, ${@1}, etc. as placeholders
///
/// Example:
/// ```moonbit
/// let tmpl = lit.html("<div>${@0}</div>", args=[@core.any("Hello")])
/// ```
pub fn LitHtml::html(
  self : LitHtml,
  template : String,
  args? : Array[@core.Any] = [],
) -> TemplateResult {
  @core.tag(
    fn(strings, values) { ffi_html(self, strings, values) },
    template,
    args,
  )
}

///|
extern "js" fn ffi_svg(
  m : LitHtml,
  strings : @core.TemplateStringsArray,
  values : Array[@core.Any],
) -> SVGTemplateResult =
  #| (m, strings, values) => m.svg(strings, ...values)

///|
/// Create SVG template using tagged template syntax
pub fn LitHtml::svg(
  self : LitHtml,
  template : String,
  args? : Array[@core.Any] = [],
) -> SVGTemplateResult {
  @core.tag(
    fn(strings, values) { ffi_svg(self, strings, values) },
    template,
    args,
  )
}

///|
extern "js" fn ffi_render(
  m : LitHtml,
  value : @core.Any,
  container : @core.Any,
  options : @core.Any,
) -> @core.Any =
  #| (m, value, container, options) => m.render(value, container, options)

///|
/// Render a TemplateResult to a container element
/// Returns a RootPart that can be used to update or dispose
pub fn LitHtml::render(
  self : LitHtml,
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
  ffi_render(self, value.to_any(), container, opts)
}

///| Special Values

///|
/// nothing - renders nothing (removes content)
pub fn LitHtml::nothing(self : LitHtml) -> @core.Any {
  self.to_any()["nothing"]
}

///|
/// noChange - signals no update needed
pub fn LitHtml::noChange(self : LitHtml) -> @core.Any {
  self.to_any()["noChange"]
}

///| Directives

///|
extern "js" fn ffi_import_directive(name : String) -> @core.Promise[@core.Any] =
  #| (name) => import("lit-html/directives/" + name + ".js")

///|
/// Import a directive module
pub async fn import_directive(name : String) -> @core.Any {
  ffi_import_directive(name).wait()
}

///|
/// Directive module - contains directive function
#external
pub type DirectiveModule

///|
pub fn DirectiveModule::to_any(self : DirectiveModule) -> @core.Any = "%identity"

///| Built-in Directives (lazy loaded)

///|
extern "js" fn ffi_import_repeat() -> @core.Promise[DirectiveModule] =
  #| () => import("lit-html/directives/repeat.js")

///|
/// Import repeat directive
pub async fn import_repeat() -> DirectiveModule {
  ffi_import_repeat().wait()
}

///|
extern "js" fn ffi_repeat(
  m : DirectiveModule,
  items : @core.Any,
  keyFn : @core.Any,
  template : @core.Any,
) -> @core.Any =
  #| (m, items, keyFn, template) => m.repeat(items, keyFn, template)

///|
/// repeat directive - efficiently renders lists with keys
pub fn DirectiveModule::repeat(
  self : DirectiveModule,
  items : Array[@core.Any],
  keyFn : (@core.Any) -> @core.Any,
  template : (@core.Any, Int) -> TemplateResult,
) -> @core.Any {
  ffi_repeat(
    self,
    @core.any(items),
    @core.any(keyFn),
    @core.any(fn(item : @core.Any, index : @core.Any) {
      template(item, index.cast())
    }),
  )
}

///|
extern "js" fn ffi_import_until() -> @core.Promise[DirectiveModule] =
  #| () => import("lit-html/directives/until.js")

///|
/// Import until directive
pub async fn import_until() -> DirectiveModule {
  ffi_import_until().wait()
}

///|
extern "js" fn ffi_until(
  m : DirectiveModule,
  values : Array[@core.Any],
) -> @core.Any =
  #| (m, values) => m.until(...values)

///|
/// until directive - renders placeholder until promise resolves
pub fn DirectiveModule::until(
  self : DirectiveModule,
  values : Array[@core.Any],
) -> @core.Any {
  ffi_until(self, values)
}

///|
extern "js" fn ffi_import_if_defined() -> @core.Promise[DirectiveModule] =
  #| () => import("lit-html/directives/if-defined.js")

///|
/// Import ifDefined directive
pub async fn import_if_defined() -> DirectiveModule {
  ffi_import_if_defined().wait()
}

///|
extern "js" fn ffi_if_defined(
  m : DirectiveModule,
  value : @core.Any,
) -> @core.Any =
  #| (m, value) => m.ifDefined(value)

///|
/// ifDefined directive - only sets attribute if value is defined
pub fn DirectiveModule::ifDefined(
  self : DirectiveModule,
  value : @core.Any,
) -> @core.Any {
  ffi_if_defined(self, value)
}

///|
extern "js" fn ffi_import_class_map() -> @core.Promise[DirectiveModule] =
  #| () => import("lit-html/directives/class-map.js")

///|
/// Import classMap directive
pub async fn import_class_map() -> DirectiveModule {
  ffi_import_class_map().wait()
}

///|
extern "js" fn ffi_class_map(
  m : DirectiveModule,
  classInfo : @core.Any,
) -> @core.Any =
  #| (m, classInfo) => m.classMap(classInfo)

///|
/// classMap directive - conditionally apply classes
/// classInfo is { className: boolean }
pub fn DirectiveModule::classMap(
  self : DirectiveModule,
  classInfo : @core.Any,
) -> @core.Any {
  ffi_class_map(self, classInfo)
}

///|
extern "js" fn ffi_import_style_map() -> @core.Promise[DirectiveModule] =
  #| () => import("lit-html/directives/style-map.js")

///|
/// Import styleMap directive
pub async fn import_style_map() -> DirectiveModule {
  ffi_import_style_map().wait()
}

///|
extern "js" fn ffi_style_map(
  m : DirectiveModule,
  styleInfo : @core.Any,
) -> @core.Any =
  #| (m, styleInfo) => m.styleMap(styleInfo)

///|
/// styleMap directive - apply inline styles from object
/// styleInfo is { property: value }
pub fn DirectiveModule::styleMap(
  self : DirectiveModule,
  styleInfo : @core.Any,
) -> @core.Any {
  ffi_style_map(self, styleInfo)
}

///|
extern "js" fn ffi_import_unsafe_html() -> @core.Promise[DirectiveModule] =
  #| () => import("lit-html/directives/unsafe-html.js")

///|
/// Import unsafeHTML directive
pub async fn import_unsafe_html() -> DirectiveModule {
  ffi_import_unsafe_html().wait()
}

///|
extern "js" fn ffi_unsafe_html(
  m : DirectiveModule,
  value : String,
) -> @core.Any =
  #| (m, value) => m.unsafeHTML(value)

///|
/// unsafeHTML directive - render string as HTML (use with caution!)
pub fn DirectiveModule::unsafeHTML(
  self : DirectiveModule,
  value : String,
) -> @core.Any {
  ffi_unsafe_html(self, value)
}

///|
extern "js" fn ffi_import_cache() -> @core.Promise[DirectiveModule] =
  #| () => import("lit-html/directives/cache.js")

///|
/// Import cache directive
pub async fn import_cache() -> DirectiveModule {
  ffi_import_cache().wait()
}

///|
extern "js" fn ffi_cache(m : DirectiveModule, value : @core.Any) -> @core.Any =
  #| (m, value) => m.cache(value)

///|
/// cache directive - caches rendered DOM when switching templates
pub fn DirectiveModule::cache(
  self : DirectiveModule,
  value : TemplateResult,
) -> @core.Any {
  ffi_cache(self, value.to_any())
}

///|
extern "js" fn ffi_import_ref() -> @core.Promise[DirectiveModule] =
  #| () => import("lit-html/directives/ref.js")

///|
/// Import ref directive
pub async fn import_ref() -> DirectiveModule {
  ffi_import_ref().wait()
}

///|
extern "js" fn ffi_ref(
  m : DirectiveModule,
  refOrCallback : @core.Any,
) -> @core.Any =
  #| (m, refOrCallback) => m.ref(refOrCallback)

///|
/// ref directive - get reference to rendered element
pub fn DirectiveModule::ref_(
  self : DirectiveModule,
  callback : (@core.Any) -> Unit,
) -> @core.Any {
  ffi_ref(self, @core.any(callback))
}

///|
extern "js" fn ffi_create_ref(m : DirectiveModule) -> @core.Any =
  #| (m) => m.createRef()

///|
/// Create a Ref object for use with ref directive
pub fn DirectiveModule::createRef(self : DirectiveModule) -> @core.Any {
  ffi_create_ref(self)
}

///|
extern "js" fn ffi_import_guard() -> @core.Promise[DirectiveModule] =
  #| () => import("lit-html/directives/guard.js")

///|
/// Import guard directive
pub async fn import_guard() -> DirectiveModule {
  ffi_import_guard().wait()
}

///|
extern "js" fn ffi_guard(
  m : DirectiveModule,
  deps : Array[@core.Any],
  valueFn : @core.Any,
) -> @core.Any =
  #| (m, deps, valueFn) => m.guard(deps, valueFn)

///|
/// guard directive - only re-renders when dependencies change
pub fn DirectiveModule::guard_(
  self : DirectiveModule,
  deps : Array[@core.Any],
  valueFn : () -> TemplateResult,
) -> @core.Any {
  ffi_guard(self, deps, @core.any(fn() { valueFn().to_any() }))
}

///|
extern "js" fn ffi_import_live() -> @core.Promise[DirectiveModule] =
  #| () => import("lit-html/directives/live.js")

///|
/// Import live directive
pub async fn import_live() -> DirectiveModule {
  ffi_import_live().wait()
}

///|
extern "js" fn ffi_live(m : DirectiveModule, value : @core.Any) -> @core.Any =
  #| (m, value) => m.live(value)

///|
/// live directive - checks live DOM value before setting
pub fn DirectiveModule::live(
  self : DirectiveModule,
  value : @core.Any,
) -> @core.Any {
  ffi_live(self, value)
}

///|
extern "js" fn ffi_import_when() -> @core.Promise[DirectiveModule] =
  #| () => import("lit-html/directives/when.js")

///|
/// Import when directive
pub async fn import_when() -> DirectiveModule {
  ffi_import_when().wait()
}

///|
extern "js" fn ffi_when(
  m : DirectiveModule,
  condition : Bool,
  trueCase : @core.Any,
  falseCase : @core.Any,
) -> @core.Any =
  #| (m, condition, trueCase, falseCase) => m.when(condition, trueCase, falseCase)

///|
/// when directive - conditional rendering
pub fn DirectiveModule::when(
  self : DirectiveModule,
  condition : Bool,
  trueCase : () -> TemplateResult,
  falseCase? : () -> TemplateResult,
) -> @core.Any {
  let false_fn = match falseCase {
    Some(f) => @core.any(fn() { f().to_any() })
    None => @core.undefined()
  }
  ffi_when(self, condition, @core.any(fn() { trueCase().to_any() }), false_fn)
}

///|
extern "js" fn ffi_import_choose() -> @core.Promise[DirectiveModule] =
  #| () => import("lit-html/directives/choose.js")

///|
/// Import choose directive
pub async fn import_choose() -> DirectiveModule {
  ffi_import_choose().wait()
}

///|
extern "js" fn ffi_choose(
  m : DirectiveModule,
  value : @core.Any,
  cases : @core.Any,
  defaultCase : @core.Any,
) -> @core.Any =
  #| (m, value, cases, defaultCase) => m.choose(value, cases, defaultCase)

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
pub fn DirectiveModule::choose(
  self : DirectiveModule,
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
  ffi_choose(self, value, js_cases, default_fn)
}

///|
extern "js" fn ffi_import_map() -> @core.Promise[DirectiveModule] =
  #| () => import("lit-html/directives/map.js")

///|
/// Import map directive
pub async fn import_map() -> DirectiveModule {
  ffi_import_map().wait()
}

///|
extern "js" fn ffi_map(
  m : DirectiveModule,
  items : @core.Any,
  f : @core.Any,
) -> @core.Any =
  #| (m, items, f) => m.map(items, f)

///|
/// map directive - transform items to templates
pub fn DirectiveModule::map(
  self : DirectiveModule,
  items : Array[@core.Any],
  f : (@core.Any, Int) -> TemplateResult,
) -> @core.Any {
  ffi_map(
    self,
    @core.any(items),
    @core.any(fn(item : @core.Any, index : @core.Any) { f(item, index.cast()) }),
  )
}

///|
extern "js" fn ffi_import_join() -> @core.Promise[DirectiveModule] =
  #| () => import("lit-html/directives/join.js")

///|
/// Import join directive
pub async fn import_join() -> DirectiveModule {
  ffi_import_join().wait()
}

///|
extern "js" fn ffi_join(
  m : DirectiveModule,
  items : @core.Any,
  joiner : @core.Any,
) -> @core.Any =
  #| (m, items, joiner) => m.join(items, joiner)

///|
/// join directive - join items with separator
pub fn DirectiveModule::join(
  self : DirectiveModule,
  items : Array[@core.Any],
  joiner : @core.Any,
) -> @core.Any {
  ffi_join(self, @core.any(items), joiner)
}

///|
extern "js" fn ffi_import_range() -> @core.Promise[DirectiveModule] =
  #| () => import("lit-html/directives/range.js")

///|
/// Import range directive
pub async fn import_range() -> DirectiveModule {
  ffi_import_range().wait()
}

///|
extern "js" fn ffi_range(
  m : DirectiveModule,
  start : Int,
  end : Int,
  step : Int,
) -> @core.Any =
  #| (m, start, end, step) => m.range(start, end, step)

///|
/// range directive - generate sequence of numbers
pub fn DirectiveModule::range(
  self : DirectiveModule,
  start : Int,
  end? : Int,
  step? : Int = 1,
) -> @core.Any {
  match end {
    Some(e) => ffi_range(self, start, e, step)
    None => ffi_range(self, 0, start, step)
  }
}

///|
extern "js" fn ffi_import_keyed() -> @core.Promise[DirectiveModule] =
  #| () => import("lit-html/directives/keyed.js")

///|
/// Import keyed directive
pub async fn import_keyed() -> DirectiveModule {
  ffi_import_keyed().wait()
}

///|
extern "js" fn ffi_keyed(
  m : DirectiveModule,
  key : @core.Any,
  value : @core.Any,
) -> @core.Any =
  #| (m, key, value) => m.keyed(key, value)

///|
/// keyed directive - force re-render when key changes
pub fn DirectiveModule::keyed(
  self : DirectiveModule,
  key : @core.Any,
  value : TemplateResult,
) -> @core.Any {
  ffi_keyed(self, key, value.to_any())
}
