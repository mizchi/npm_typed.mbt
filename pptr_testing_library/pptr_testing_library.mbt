///|
/// Puppeteer Testing Library - testing-library queries for Puppeteer
/// https://testing-library.com/docs/pptr-testing-library/intro

///| Core FFI

///|
extern "js" fn ffi_get_document(
  page : @puppeteer.Page,
) -> @core.Promise[@puppeteer.ElementHandle] =
  #| (page) => import("pptr-testing-library").then(m => m.getDocument(page))

///|
extern "js" fn ffi_get_queries_for_element(
  element : @puppeteer.ElementHandle,
) -> @core.Any =
  #| (element) => import("pptr-testing-library").then(m => m.getQueriesForElement(element))

///| Core Functions

///|
/// Get document ElementHandle from a Puppeteer page
/// This is the entry point for using testing-library queries
pub async fn getDocument(page : @puppeteer.Page) -> @puppeteer.ElementHandle {
  ffi_get_document(page).wait()
}

///|
/// Get queries bound to a specific element
/// Returns an object with all query functions
#alias(get_queries_for_element)
pub fn getQueriesForElement(element : @puppeteer.ElementHandle) -> Queries {
  ffi_get_queries_for_element(element).cast()
}

///| Queries type

///|
/// Queries object containing all testing-library query functions
#external
pub type Queries

///|
pub fn Queries::to_any(self : Queries) -> @core.Any = "%identity"

///| Query FFI - ByRole

///|
extern "js" fn ffi_get_by_role(
  document : @puppeteer.ElementHandle,
  role : String,
  options : @core.Any,
) -> @core.Promise[@puppeteer.ElementHandle] =
  #| (doc, role, opts) => import("pptr-testing-library").then(m => m.queries.getByRole(doc, role, opts))

///|
extern "js" fn ffi_query_by_role(
  document : @puppeteer.ElementHandle,
  role : String,
  options : @core.Any,
) -> @core.Promise[@puppeteer.ElementHandle?] =
  #| (doc, role, opts) => import("pptr-testing-library").then(m => m.queries.queryByRole(doc, role, opts))

///|
extern "js" fn ffi_find_by_role(
  document : @puppeteer.ElementHandle,
  role : String,
  options : @core.Any,
) -> @core.Promise[@puppeteer.ElementHandle] =
  #| (doc, role, opts) => import("pptr-testing-library").then(m => m.queries.findByRole(doc, role, opts))

///|
extern "js" fn ffi_get_all_by_role(
  document : @puppeteer.ElementHandle,
  role : String,
  options : @core.Any,
) -> @core.Promise[Array[@puppeteer.ElementHandle]] =
  #| (doc, role, opts) => import("pptr-testing-library").then(m => m.queries.getAllByRole(doc, role, opts))

///| Query FFI - ByText

///|
extern "js" fn ffi_get_by_text(
  document : @puppeteer.ElementHandle,
  text : @core.Any,
  options : @core.Any,
) -> @core.Promise[@puppeteer.ElementHandle] =
  #| (doc, text, opts) => import("pptr-testing-library").then(m => m.queries.getByText(doc, text, opts))

///|
extern "js" fn ffi_query_by_text(
  document : @puppeteer.ElementHandle,
  text : @core.Any,
  options : @core.Any,
) -> @core.Promise[@puppeteer.ElementHandle?] =
  #| (doc, text, opts) => import("pptr-testing-library").then(m => m.queries.queryByText(doc, text, opts))

///|
extern "js" fn ffi_find_by_text(
  document : @puppeteer.ElementHandle,
  text : @core.Any,
  options : @core.Any,
) -> @core.Promise[@puppeteer.ElementHandle] =
  #| (doc, text, opts) => import("pptr-testing-library").then(m => m.queries.findByText(doc, text, opts))

///|
extern "js" fn ffi_get_all_by_text(
  document : @puppeteer.ElementHandle,
  text : @core.Any,
  options : @core.Any,
) -> @core.Promise[Array[@puppeteer.ElementHandle]] =
  #| (doc, text, opts) => import("pptr-testing-library").then(m => m.queries.getAllByText(doc, text, opts))

///| Query FFI - ByLabelText

///|
extern "js" fn ffi_get_by_label_text(
  document : @puppeteer.ElementHandle,
  text : @core.Any,
  options : @core.Any,
) -> @core.Promise[@puppeteer.ElementHandle] =
  #| (doc, text, opts) => import("pptr-testing-library").then(m => m.queries.getByLabelText(doc, text, opts))

///|
extern "js" fn ffi_query_by_label_text(
  document : @puppeteer.ElementHandle,
  text : @core.Any,
  options : @core.Any,
) -> @core.Promise[@puppeteer.ElementHandle?] =
  #| (doc, text, opts) => import("pptr-testing-library").then(m => m.queries.queryByLabelText(doc, text, opts))

///| Query FFI - ByPlaceholderText

///|
extern "js" fn ffi_get_by_placeholder_text(
  document : @puppeteer.ElementHandle,
  text : @core.Any,
  options : @core.Any,
) -> @core.Promise[@puppeteer.ElementHandle] =
  #| (doc, text, opts) => import("pptr-testing-library").then(m => m.queries.getByPlaceholderText(doc, text, opts))

///|
extern "js" fn ffi_query_by_placeholder_text(
  document : @puppeteer.ElementHandle,
  text : @core.Any,
  options : @core.Any,
) -> @core.Promise[@puppeteer.ElementHandle?] =
  #| (doc, text, opts) => import("pptr-testing-library").then(m => m.queries.queryByPlaceholderText(doc, text, opts))

///| Query FFI - ByTestId

///|
extern "js" fn ffi_get_by_test_id(
  document : @puppeteer.ElementHandle,
  testId : String,
) -> @core.Promise[@puppeteer.ElementHandle] =
  #| (doc, testId) => import("pptr-testing-library").then(m => m.queries.getByTestId(doc, testId))

///|
extern "js" fn ffi_query_by_test_id(
  document : @puppeteer.ElementHandle,
  testId : String,
) -> @core.Promise[@puppeteer.ElementHandle?] =
  #| (doc, testId) => import("pptr-testing-library").then(m => m.queries.queryByTestId(doc, testId))

///|
extern "js" fn ffi_find_by_test_id(
  document : @puppeteer.ElementHandle,
  testId : String,
) -> @core.Promise[@puppeteer.ElementHandle] =
  #| (doc, testId) => import("pptr-testing-library").then(m => m.queries.findByTestId(doc, testId))

///| Query FFI - ByAltText

///|
extern "js" fn ffi_get_by_alt_text(
  document : @puppeteer.ElementHandle,
  text : @core.Any,
  options : @core.Any,
) -> @core.Promise[@puppeteer.ElementHandle] =
  #| (doc, text, opts) => import("pptr-testing-library").then(m => m.queries.getByAltText(doc, text, opts))

///|
extern "js" fn ffi_query_by_alt_text(
  document : @puppeteer.ElementHandle,
  text : @core.Any,
  options : @core.Any,
) -> @core.Promise[@puppeteer.ElementHandle?] =
  #| (doc, text, opts) => import("pptr-testing-library").then(m => m.queries.queryByAltText(doc, text, opts))

///| Query FFI - ByTitle

///|
extern "js" fn ffi_get_by_title(
  document : @puppeteer.ElementHandle,
  title : @core.Any,
  options : @core.Any,
) -> @core.Promise[@puppeteer.ElementHandle] =
  #| (doc, title, opts) => import("pptr-testing-library").then(m => m.queries.getByTitle(doc, title, opts))

///|
extern "js" fn ffi_query_by_title(
  document : @puppeteer.ElementHandle,
  title : @core.Any,
  options : @core.Any,
) -> @core.Promise[@puppeteer.ElementHandle?] =
  #| (doc, title, opts) => import("pptr-testing-library").then(m => m.queries.queryByTitle(doc, title, opts))

///| Query FFI - ByDisplayValue

///|
extern "js" fn ffi_get_by_display_value(
  document : @puppeteer.ElementHandle,
  value : @core.Any,
  options : @core.Any,
) -> @core.Promise[@puppeteer.ElementHandle] =
  #| (doc, value, opts) => import("pptr-testing-library").then(m => m.queries.getByDisplayValue(doc, value, opts))

///|
extern "js" fn ffi_query_by_display_value(
  document : @puppeteer.ElementHandle,
  value : @core.Any,
  options : @core.Any,
) -> @core.Promise[@puppeteer.ElementHandle?] =
  #| (doc, value, opts) => import("pptr-testing-library").then(m => m.queries.queryByDisplayValue(doc, value, opts))

///| Public Query Functions - ByRole

///|
/// Get element by role (throws if not found)
#alias(get_by_role)
pub async fn getByRole(
  document : @puppeteer.ElementHandle,
  role : String,
  name? : String,
  hidden? : Bool,
) -> @puppeteer.ElementHandle {
  let opts = @core.new_object()
  if name is Some(v) {
    opts["name"] = @core.any(v)
  }
  if hidden is Some(v) {
    opts["hidden"] = @core.any(v)
  }
  ffi_get_by_role(document, role, opts).wait()
}

///|
/// Query element by role (returns null if not found)
#alias(query_by_role)
pub async fn queryByRole(
  document : @puppeteer.ElementHandle,
  role : String,
  name? : String,
  hidden? : Bool,
) -> @puppeteer.ElementHandle? {
  let opts = @core.new_object()
  if name is Some(v) {
    opts["name"] = @core.any(v)
  }
  if hidden is Some(v) {
    opts["hidden"] = @core.any(v)
  }
  ffi_query_by_role(document, role, opts).wait()
}

///|
/// Find element by role (async, waits for element)
#alias(find_by_role)
pub async fn findByRole(
  document : @puppeteer.ElementHandle,
  role : String,
  name? : String,
  hidden? : Bool,
) -> @puppeteer.ElementHandle {
  let opts = @core.new_object()
  if name is Some(v) {
    opts["name"] = @core.any(v)
  }
  if hidden is Some(v) {
    opts["hidden"] = @core.any(v)
  }
  ffi_find_by_role(document, role, opts).wait()
}

///|
/// Get all elements by role
#alias(get_all_by_role)
pub async fn getAllByRole(
  document : @puppeteer.ElementHandle,
  role : String,
  name? : String,
  hidden? : Bool,
) -> Array[@puppeteer.ElementHandle] {
  let opts = @core.new_object()
  if name is Some(v) {
    opts["name"] = @core.any(v)
  }
  if hidden is Some(v) {
    opts["hidden"] = @core.any(v)
  }
  ffi_get_all_by_role(document, role, opts).wait()
}

///| Public Query Functions - ByText

///|
/// Get element by text content
#alias(get_by_text)
pub async fn getByText(
  document : @puppeteer.ElementHandle,
  text : String,
  exact? : Bool,
) -> @puppeteer.ElementHandle {
  let opts = @core.new_object()
  if exact is Some(v) {
    opts["exact"] = @core.any(v)
  }
  ffi_get_by_text(document, @core.any(text), opts).wait()
}

///|
/// Query element by text content
#alias(query_by_text)
pub async fn queryByText(
  document : @puppeteer.ElementHandle,
  text : String,
  exact? : Bool,
) -> @puppeteer.ElementHandle? {
  let opts = @core.new_object()
  if exact is Some(v) {
    opts["exact"] = @core.any(v)
  }
  ffi_query_by_text(document, @core.any(text), opts).wait()
}

///|
/// Find element by text content
#alias(find_by_text)
pub async fn findByText(
  document : @puppeteer.ElementHandle,
  text : String,
  exact? : Bool,
) -> @puppeteer.ElementHandle {
  let opts = @core.new_object()
  if exact is Some(v) {
    opts["exact"] = @core.any(v)
  }
  ffi_find_by_text(document, @core.any(text), opts).wait()
}

///|
/// Get all elements by text content
#alias(get_all_by_text)
pub async fn getAllByText(
  document : @puppeteer.ElementHandle,
  text : String,
  exact? : Bool,
) -> Array[@puppeteer.ElementHandle] {
  let opts = @core.new_object()
  if exact is Some(v) {
    opts["exact"] = @core.any(v)
  }
  ffi_get_all_by_text(document, @core.any(text), opts).wait()
}

///| Public Query Functions - ByLabelText

///|
/// Get element by label text
#alias(get_by_label_text)
pub async fn getByLabelText(
  document : @puppeteer.ElementHandle,
  text : String,
  exact? : Bool,
) -> @puppeteer.ElementHandle {
  let opts = @core.new_object()
  if exact is Some(v) {
    opts["exact"] = @core.any(v)
  }
  ffi_get_by_label_text(document, @core.any(text), opts).wait()
}

///|
/// Query element by label text
#alias(query_by_label_text)
pub async fn queryByLabelText(
  document : @puppeteer.ElementHandle,
  text : String,
  exact? : Bool,
) -> @puppeteer.ElementHandle? {
  let opts = @core.new_object()
  if exact is Some(v) {
    opts["exact"] = @core.any(v)
  }
  ffi_query_by_label_text(document, @core.any(text), opts).wait()
}

///| Public Query Functions - ByPlaceholderText

///|
/// Get element by placeholder text
#alias(get_by_placeholder_text)
pub async fn getByPlaceholderText(
  document : @puppeteer.ElementHandle,
  text : String,
  exact? : Bool,
) -> @puppeteer.ElementHandle {
  let opts = @core.new_object()
  if exact is Some(v) {
    opts["exact"] = @core.any(v)
  }
  ffi_get_by_placeholder_text(document, @core.any(text), opts).wait()
}

///|
/// Query element by placeholder text
#alias(query_by_placeholder_text)
pub async fn queryByPlaceholderText(
  document : @puppeteer.ElementHandle,
  text : String,
  exact? : Bool,
) -> @puppeteer.ElementHandle? {
  let opts = @core.new_object()
  if exact is Some(v) {
    opts["exact"] = @core.any(v)
  }
  ffi_query_by_placeholder_text(document, @core.any(text), opts).wait()
}

///| Public Query Functions - ByTestId

///|
/// Get element by test ID
#alias(get_by_test_id)
pub async fn getByTestId(
  document : @puppeteer.ElementHandle,
  testId : String,
) -> @puppeteer.ElementHandle {
  ffi_get_by_test_id(document, testId).wait()
}

///|
/// Query element by test ID
#alias(query_by_test_id)
pub async fn queryByTestId(
  document : @puppeteer.ElementHandle,
  testId : String,
) -> @puppeteer.ElementHandle? {
  ffi_query_by_test_id(document, testId).wait()
}

///|
/// Find element by test ID
#alias(find_by_test_id)
pub async fn findByTestId(
  document : @puppeteer.ElementHandle,
  testId : String,
) -> @puppeteer.ElementHandle {
  ffi_find_by_test_id(document, testId).wait()
}

///| Public Query Functions - ByAltText

///|
/// Get element by alt text
#alias(get_by_alt_text)
pub async fn getByAltText(
  document : @puppeteer.ElementHandle,
  text : String,
  exact? : Bool,
) -> @puppeteer.ElementHandle {
  let opts = @core.new_object()
  if exact is Some(v) {
    opts["exact"] = @core.any(v)
  }
  ffi_get_by_alt_text(document, @core.any(text), opts).wait()
}

///|
/// Query element by alt text
#alias(query_by_alt_text)
pub async fn queryByAltText(
  document : @puppeteer.ElementHandle,
  text : String,
  exact? : Bool,
) -> @puppeteer.ElementHandle? {
  let opts = @core.new_object()
  if exact is Some(v) {
    opts["exact"] = @core.any(v)
  }
  ffi_query_by_alt_text(document, @core.any(text), opts).wait()
}

///| Public Query Functions - ByTitle

///|
/// Get element by title attribute
#alias(get_by_title)
pub async fn getByTitle(
  document : @puppeteer.ElementHandle,
  title : String,
  exact? : Bool,
) -> @puppeteer.ElementHandle {
  let opts = @core.new_object()
  if exact is Some(v) {
    opts["exact"] = @core.any(v)
  }
  ffi_get_by_title(document, @core.any(title), opts).wait()
}

///|
/// Query element by title attribute
#alias(query_by_title)
pub async fn queryByTitle(
  document : @puppeteer.ElementHandle,
  title : String,
  exact? : Bool,
) -> @puppeteer.ElementHandle? {
  let opts = @core.new_object()
  if exact is Some(v) {
    opts["exact"] = @core.any(v)
  }
  ffi_query_by_title(document, @core.any(title), opts).wait()
}

///| Public Query Functions - ByDisplayValue

///|
/// Get element by display value
#alias(get_by_display_value)
pub async fn getByDisplayValue(
  document : @puppeteer.ElementHandle,
  value : String,
  exact? : Bool,
) -> @puppeteer.ElementHandle {
  let opts = @core.new_object()
  if exact is Some(v) {
    opts["exact"] = @core.any(v)
  }
  ffi_get_by_display_value(document, @core.any(value), opts).wait()
}

///|
/// Query element by display value
#alias(query_by_display_value)
pub async fn queryByDisplayValue(
  document : @puppeteer.ElementHandle,
  value : String,
  exact? : Bool,
) -> @puppeteer.ElementHandle? {
  let opts = @core.new_object()
  if exact is Some(v) {
    opts["exact"] = @core.any(v)
  }
  ffi_query_by_display_value(document, @core.any(value), opts).wait()
}
