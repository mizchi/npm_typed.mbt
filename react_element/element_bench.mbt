///|
/// Benchmark for React element creation and rendering
/// This benchmark tests the performance of creating complex nested components
///
/// ## Performance Analysis Results (2025-12-10)
///
/// ### Benchmark Summary
///
/// | Test                    | Time      | Notes                    |
/// |-------------------------|-----------|--------------------------|
/// | direct jsx (baseline)   | 0.88 µs   | Raw ffi_jsx call         |
/// | wrapper jsx             | 0.92 µs   | +4% overhead             |
/// | with event handler      | 0.95 µs   | +7% overhead             |
/// | nested 5 levels         | 5.37 µs   | ~1.07 µs/element         |
/// | SVG chart               | 13.21 µs  | 14 elements              |
/// | form component          | 19.47 µs  | ~20 elements             |
/// | complex component       | 59.78 µs  | ~70 elements             |
///
/// ### Key Findings
///
/// 1. **Wrapper API overhead is minimal** - Only ~4% overhead compared to direct
///    `ffi_jsx` calls. The MoonBit compiler optimizes the wrapper functions well.
///
/// 2. **Event handler conversion is efficient** - `@js.from_fn1` conversion adds
///    only ~3% additional cost per handler.
///
/// 3. **Current implementation is well-optimized** - Key optimizations already in place:
///    - `children.length()` result caching to avoid multiple calls
///    - Special handling for single child (no array allocation)
///    - Direct props object mutation instead of intermediate objects
///
/// 4. **Cost scales linearly with element count** - Each element costs ~0.85-1.0 µs,
///    which is primarily the React jsx runtime call overhead.
///
/// ### Optimization Attempts
///
/// - Replacing `children.map(_.to_react_node())` with manual for-loop: **No improvement**
///   (MoonBit's `map` is already optimized)
/// - Caching `children.length()`: **Marginal improvement** (code clarity benefit)
///
/// ### Conclusion
///
/// The wrapper API (`div`, `span`, etc.) adds negligible overhead. Performance is
/// dominated by the number of elements created, not by the wrapper abstraction.
/// For typical React applications, this overhead is insignificant compared to
/// actual DOM operations and React reconciliation.

///|
/// Create a complex nested component tree simulating a typical web page
fn create_complex_component() -> @react.Element {
  div(id="app", [
    // Header section
    header([
      nav([
        ul([
          li([a(href="/", ["Home"])]),
          li([a(href="/about", ["About"])]),
          li([a(href="/products", ["Products"])]),
          li([a(href="/contact", ["Contact"])]),
        ]),
      ]),
      h1(["Welcome to Our Store"]),
    ]),
    // Main content section
    main_([
      article([
        h2(["Featured Products"]),
        div(class="product-grid", [
          // Product cards
          div(class="product-card", [
            img(src="/product1.jpg", alt="Product 1"),
            h3(["Product 1"]),
            p(["Description of product 1 with some details."]),
            button(type_="button", ["Add to Cart"]),
          ]),
          div(class="product-card", [
            img(src="/product2.jpg", alt="Product 2"),
            h3(["Product 2"]),
            p(["Description of product 2 with some details."]),
            button(type_="button", ["Add to Cart"]),
          ]),
          div(class="product-card", [
            img(src="/product3.jpg", alt="Product 3"),
            h3(["Product 3"]),
            p(["Description of product 3 with some details."]),
            button(type_="button", ["Add to Cart"]),
          ]),
        ]),
      ]),
      aside([
        h3(["Categories"]),
        ul([
          li([a(href="/category/electronics", ["Electronics"])]),
          li([a(href="/category/clothing", ["Clothing"])]),
          li([a(href="/category/books", ["Books"])]),
          li([a(href="/category/home", ["Home & Garden"])]),
        ]),
      ]),
    ]),
    // Footer section
    footer([
      div([
        section([h4(["About Us"]), p(["We are a leading online retailer."])]),
        section([
          h4(["Contact"]),
          p(["Email: info@example.com"]),
          p(["Phone: 123-456-7890"]),
        ]),
        section([
          h4(["Follow Us"]),
          ul([
            li([a(href="https://facebook.com", ["Facebook"])]),
            li([a(href="https://twitter.com", ["Twitter"])]),
            li([a(href="https://instagram.com", ["Instagram"])]),
          ]),
        ]),
      ]),
    ]),
  ])
}

///|
/// Benchmark: Create complex component (element creation only)
test "benchmark: create complex component" (b : @bench.T) {
  b.bench(fn() { b.keep(create_complex_component()) })
}

///|
/// Benchmark: Create simple form with multiple inputs
fn create_form_component() -> @react.Element {
  form([
    div([
      label(["First Name:"], htmlFor="firstName"),
      input(
        type_="text",
        id="firstName",
        name="firstName",
        placeholder="Enter first name",
      ),
    ]),
    div([
      label(["Last Name:"], htmlFor="lastName"),
      input(
        type_="text",
        id="lastName",
        name="lastName",
        placeholder="Enter last name",
      ),
    ]),
    div([
      label(["Email:"], htmlFor="email"),
      input(type_="email", id="email", name="email", placeholder="Enter email"),
    ]),
    div([
      label(["Message:"], htmlFor="message"),
      textarea(id="message", placeholder="Enter your message", []),
    ]),
    div([
      label(["Country:"], htmlFor="country"),
      select(id="country", name="country", [
        option(value="us", ["USA"]),
        option(value="ca", ["Canada"]),
        option(value="uk", ["UK"]),
        option(value="jp", ["Japan"]),
      ]),
    ]),
    button(type_="submit", ["Submit"]),
  ])
}

///|
test "benchmark: create form component" (b : @bench.T) {
  b.bench(fn() { b.keep(create_form_component()) })
}

///|

///|

///|
/// Benchmark: Create SVG chart
fn create_svg_chart() -> @react.Element {
  svg(width=400, height=300, [
    // Background
    rect(x=0, y=0, width=400, height=300, fill="white", stroke="black"),
    // Data bars
    rect(x=50, y=250, width=40, height=50, fill="blue"),
    rect(x=100, y=200, width=40, height=100, fill="blue"),
    rect(x=150, y=150, width=40, height=150, fill="blue"),
    rect(x=200, y=180, width=40, height=120, fill="blue"),
    rect(x=250, y=220, width=40, height=80, fill="blue"),
    // Labels
    text(x=200, y=30, ["Chart Title"]),
    text(x=70, y=280, ["2020"]),
    text(x=120, y=280, ["2021"]),
    text(x=170, y=280, ["2022"]),
    text(x=220, y=280, ["2023"]),
    text(x=270, y=280, ["2024"]),
  ])
}

///|
test "benchmark: create SVG chart" (b : @bench.T) {
  b.bench(fn() { b.keep(create_svg_chart()) })
}

///|
/// Baseline: Direct jsx runtime call without wrapper
fn create_simple_div_direct() -> @react.Element {
  let props = @core.new_object()
  props._set("id", "test" |> @core.any)
  props._set("children", "Hello" |> @core.any)
  @react.createElementWithKey(@core.any("div"), props, None)
}

///|
test "benchmark: direct jsx (baseline)" (b : @bench.T) {
  b.bench(fn() { b.keep(create_simple_div_direct()) })
}

///|
/// Compare: Wrapper function call
fn create_simple_div_wrapper() -> @react.Element {
  div(id="test", ["Hello"])
}

///|
test "benchmark: wrapper jsx" (b : @bench.T) {
  b.bench(fn() { b.keep(create_simple_div_wrapper()) })
}

///|
/// Compare: Wrapper with event handler
fn create_div_with_handler() -> @react.Element {
  div(id="test", on_click=fn(_e) { () }, ["Hello"])
}

///|
test "benchmark: wrapper with handler" (b : @bench.T) {
  b.bench(fn() { b.keep(create_div_with_handler()) })
}

///|
/// Compare: Nested elements (5 levels deep)
fn create_nested_5() -> @react.Element {
  div([div([div([div([div(["deep"])])])])])
}

///|
test "benchmark: nested 5 levels" (b : @bench.T) {
  b.bench(fn() { b.keep(create_nested_5()) })
}

///|
