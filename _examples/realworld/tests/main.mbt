///|
/// Realworld TODO App E2E Tests (MoonBit version)
/// Run with: npx playwright test realworld_mbt.spec.js

///| Helper to generate unique test data
fn generate_timestamp() -> String {
  @js.Date::now().to_string()
}

///|
fn generate_test_user() -> (String, String, String) {
  let ts = generate_timestamp()
  let name = "Test User " + ts
  let email = "test" + ts + "@example.com"
  let password = "testpass123"
  (name, email, password)
}

///|
/// Helper to register and login a user
async fn register_and_login(
  page : @playwright.Page,
  name : String,
  email : String,
  password : String
) -> Unit {
  // Register
  let _ = page.goto("/auth/register")
  page.fill("input[name=\"name\"]", name)
  page.fill("input[name=\"email\"]", email)
  page.fill("input[name=\"password\"]", password)
  page.click("button[type=\"submit\"]")
  page.waitForURL("/auth/login")
  // Login
  page.fill("input[name=\"email\"]", email)
  page.fill("input[name=\"password\"]", password)
  page.click("button[type=\"submit\"]")
  page.waitForURL("/")
}

///|
fn main {
  let t = @playwright_test.test_fn()
  let expect = @playwright_test.expect_fn()

  // Authentication Tests
  t.describe(
    "Authentication",
    @core.any(
      fn() {
        t.run(
          "should show login page for unauthenticated users",
          @core.any(
            async fn(fixtures : @core.Any) {
              let page : @playwright.Page = fixtures["page"].cast()
              let _ = page.goto("/")
              expect.page(page).toHaveURL("/auth/login")
              expect.locator(page.locator("h1")).toHaveText("Login")
            },
          ),
        )

        t.run(
          "should show register page",
          @core.any(
            async fn(fixtures : @core.Any) {
              let page : @playwright.Page = fixtures["page"].cast()
              let _ = page.goto("/auth/register")
              expect.locator(page.locator("h1")).toHaveText("Register")
              expect.locator(page.locator("input[name=\"name\"]")).toBeVisible()
              expect.locator(page.locator("input[name=\"email\"]")).toBeVisible()
              expect
              .locator(page.locator("input[name=\"password\"]"))
              .toBeVisible()
            },
          ),
        )

        t.run(
          "should register a new user",
          @core.any(
            async fn(fixtures : @core.Any) {
              let page : @playwright.Page = fixtures["page"].cast()
              let (name, email, password) = generate_test_user()
              let _ = page.goto("/auth/register")
              page.fill("input[name=\"name\"]", name)
              page.fill("input[name=\"email\"]", email)
              page.fill("input[name=\"password\"]", password)
              page.click("button[type=\"submit\"]")
              // Should redirect to login page after registration
              expect.page(page).toHaveURL("/auth/login")
            },
          ),
        )

        t.run(
          "should login with registered user",
          @core.any(
            async fn(fixtures : @core.Any) {
              let page : @playwright.Page = fixtures["page"].cast()
              let (name, email, password) = generate_test_user()
              register_and_login(page, name, email, password)
              // Should redirect to home page
              expect.page(page).toHaveURL("/")
              expect.locator(page.locator("h1")).toHaveText("My TODOs")
              expect.locator(page.getByText("Welcome, " + email)).toBeVisible()
            },
          ),
        )

        t.run(
          "should show error for invalid login",
          @core.any(
            async fn(fixtures : @core.Any) {
              let page : @playwright.Page = fixtures["page"].cast()
              let _ = page.goto("/auth/login")
              page.fill("input[name=\"email\"]", "nonexistent@example.com")
              page.fill("input[name=\"password\"]", "wrongpassword")
              page.click("button[type=\"submit\"]")
              // Should show error
              expect.locator(page.locator("h1")).toHaveText("Login Failed")
            },
          ),
        )
      },
    ),
  )

  // TODO CRUD Tests
  t.describe(
    "TODO CRUD",
    @core.any(
      fn() {
        t.run(
          "should add a new todo",
          @core.any(
            async fn(fixtures : @core.Any) {
              let page : @playwright.Page = fixtures["page"].cast()
              let (name, email, password) = generate_test_user()
              register_and_login(page, name, email, password)
              // Add a todo
              let ts = generate_timestamp()
              let todo_title = "Test TODO " + ts
              page.fill("input[name=\"title\"]", todo_title)
              page.click("button[type=\"submit\"]")
              // Should show the new todo
              expect.locator(page.getByText(todo_title)).toBeVisible()
            },
          ),
        )

        t.run(
          "should toggle todo completion",
          @core.any(
            async fn(fixtures : @core.Any) {
              let page : @playwright.Page = fixtures["page"].cast()
              let (name, email, password) = generate_test_user()
              register_and_login(page, name, email, password)
              // Add a todo
              let ts = generate_timestamp()
              let todo_title = "Toggle TODO " + ts
              page.fill("input[name=\"title\"]", todo_title)
              page.click("button[type=\"submit\"]")
              page.waitForLoadState(state="networkidle")
              expect.locator(page.getByText(todo_title)).toBeVisible()
              // Toggle to completed
              let checkbox = page.locator("input[type=\"checkbox\"]").first()
              checkbox.click()
              page.waitForLoadState(state="networkidle")
              // Verify the todo text has line-through style
              let todo_span = page.locator("span").filter(hasText=todo_title)
              expect
              .locator(todo_span)
              .toHaveCSS("text-decoration-line", "line-through")
            },
          ),
        )

        t.run(
          "should delete a todo",
          @core.any(
            async fn(fixtures : @core.Any) {
              let page : @playwright.Page = fixtures["page"].cast()
              let (name, email, password) = generate_test_user()
              register_and_login(page, name, email, password)
              // Add a todo
              let ts = generate_timestamp()
              let todo_title = "Delete TODO " + ts
              page.fill("input[name=\"title\"]", todo_title)
              page.click("button[type=\"submit\"]")
              page.waitForLoadState(state="networkidle")
              expect.locator(page.getByText(todo_title)).toBeVisible()
              // Find and click the first delete button
              page.getByRole("button", name="Delete").first().click()
              page.waitForLoadState(state="networkidle")
              // Verify todo is removed
              expect.locator(page.getByText(todo_title)).not_().toBeVisible()
            },
          ),
        )

        t.run(
          "should persist todos across page reloads",
          @core.any(
            async fn(fixtures : @core.Any) {
              let page : @playwright.Page = fixtures["page"].cast()
              let (name, email, password) = generate_test_user()
              register_and_login(page, name, email, password)
              // Add a todo
              let ts = generate_timestamp()
              let todo_title = "Persist TODO " + ts
              page.fill("input[name=\"title\"]", todo_title)
              page.click("button[type=\"submit\"]")
              expect.locator(page.getByText(todo_title)).toBeVisible()
              // Reload page
              let _ = page.reload()
              // Todo should still be there
              expect.locator(page.getByText(todo_title)).toBeVisible()
            },
          ),
        )
      },
    ),
  )

  // Session persistence test
  t.describe(
    "Session persistence",
    @core.any(
      fn() {
        t.run(
          "should maintain session across navigation",
          @core.any(
            async fn(fixtures : @core.Any) {
              let page : @playwright.Page = fixtures["page"].cast()
              let (name, email, password) = generate_test_user()
              register_and_login(page, name, email, password)
              // Navigate to different pages
              page.click("a[href=\"/\"]")
              expect.locator(page.locator("h1")).toHaveText("My TODOs")
              // User should still be logged in
              expect.locator(page.getByText("Welcome, " + email)).toBeVisible()
            },
          ),
        )
      },
    ),
  )
}
