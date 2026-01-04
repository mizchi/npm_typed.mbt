///|
/// Realworld Example - Server
/// Hono + better-auth + node:sqlite TODO app

///|
type Env = Unit

///|
type ExecutionContext = Unit

///|
type App = @hono.Hono[Env, ExecutionContext]

///|
type Ctx = @hono.Context[Env, ExecutionContext]

///|
using @hono_element {
  div, span, p, h1, strong, a, form, input, button, label, nav, main_
}

// ============ Database ============

///|
let create_todos_sql : String =
  #|CREATE TABLE IF NOT EXISTS todos (
  #|  id INTEGER PRIMARY KEY AUTOINCREMENT,
  #|  user_id TEXT NOT NULL,
  #|  title TEXT NOT NULL,
  #|  completed INTEGER DEFAULT 0,
  #|  created_at TEXT DEFAULT CURRENT_TIMESTAMP
  #|)

///|
/// better-auth required tables
let create_user_sql : String =
  #|CREATE TABLE IF NOT EXISTS user (
  #|  id TEXT PRIMARY KEY,
  #|  name TEXT NOT NULL,
  #|  email TEXT NOT NULL UNIQUE,
  #|  emailVerified INTEGER DEFAULT 0,
  #|  image TEXT,
  #|  createdAt TEXT DEFAULT CURRENT_TIMESTAMP,
  #|  updatedAt TEXT DEFAULT CURRENT_TIMESTAMP
  #|)

///|
let create_session_sql : String =
  #|CREATE TABLE IF NOT EXISTS session (
  #|  id TEXT PRIMARY KEY,
  #|  userId TEXT NOT NULL,
  #|  token TEXT NOT NULL UNIQUE,
  #|  expiresAt TEXT NOT NULL,
  #|  ipAddress TEXT,
  #|  userAgent TEXT,
  #|  createdAt TEXT DEFAULT CURRENT_TIMESTAMP,
  #|  updatedAt TEXT DEFAULT CURRENT_TIMESTAMP,
  #|  FOREIGN KEY (userId) REFERENCES user(id) ON DELETE CASCADE
  #|)

///|
let create_account_sql : String =
  #|CREATE TABLE IF NOT EXISTS account (
  #|  id TEXT PRIMARY KEY,
  #|  userId TEXT NOT NULL,
  #|  accountId TEXT NOT NULL,
  #|  providerId TEXT NOT NULL,
  #|  accessToken TEXT,
  #|  refreshToken TEXT,
  #|  accessTokenExpiresAt TEXT,
  #|  refreshTokenExpiresAt TEXT,
  #|  scope TEXT,
  #|  idToken TEXT,
  #|  password TEXT,
  #|  createdAt TEXT DEFAULT CURRENT_TIMESTAMP,
  #|  updatedAt TEXT DEFAULT CURRENT_TIMESTAMP,
  #|  FOREIGN KEY (userId) REFERENCES user(id) ON DELETE CASCADE
  #|)

///|
let create_verification_sql : String =
  #|CREATE TABLE IF NOT EXISTS verification (
  #|  id TEXT PRIMARY KEY,
  #|  identifier TEXT NOT NULL,
  #|  value TEXT NOT NULL,
  #|  expiresAt TEXT NOT NULL,
  #|  createdAt TEXT DEFAULT CURRENT_TIMESTAMP,
  #|  updatedAt TEXT DEFAULT CURRENT_TIMESTAMP
  #|)

///|
/// Initialize the database with tables
pub fn init_db() -> @sqlite.DatabaseSync {
  // Use file-based database to ensure persistence
  let db = @sqlite.DatabaseSync::new("realworld.db")
  // better-auth tables
  db.exec(create_user_sql)
  db.exec(create_session_sql)
  db.exec(create_account_sql)
  db.exec(create_verification_sql)
  // app tables
  db.exec(create_todos_sql)
  db
}

// ============ Zod Schemas ============

///|
fn create_todo_schema() -> @zod.ZodSchema {
  @zod.object({ "title": @zod.string().min(1) })
}

// ============ CSS Styles ============

///|
priv struct Styles {
  html : @hono.CssClass
  body : @hono.CssClass
  container : @hono.CssClass
  card : @hono.CssClass
  button : @hono.CssClass
  button_danger : @hono.CssClass
  input : @hono.CssClass
  todo_item : @hono.CssClass
  nav : @hono.CssClass
  nav_link : @hono.CssClass
}

///|
fn create_styles(hono_css : @hono.HonoCss) -> Styles {
  {
    html: hono_css.css(
      "margin: 0; padding: 0; font-family: system-ui, sans-serif;",
    ),
    body: hono_css.css("margin: 0; padding: 0; background: #f5f5f5;"),
    container: hono_css.css("max-width: 800px; margin: 0 auto; padding: 2rem;"),
    card: hono_css.css(
      "background: white; border-radius: 8px; padding: 1.5rem; margin-bottom: 1rem; box-shadow: 0 2px 4px rgba(0,0,0,0.1);",
    ),
    button: hono_css.css(
      "padding: 0.5rem 1rem; background: #007bff; color: white; border: none; border-radius: 4px; cursor: pointer;",
    ),
    button_danger: hono_css.css(
      "padding: 0.5rem 1rem; background: #dc3545; color: white; border: none; border-radius: 4px; cursor: pointer;",
    ),
    input: hono_css.css(
      "padding: 0.5rem; border: 1px solid #ddd; border-radius: 4px; margin-right: 0.5rem;",
    ),
    todo_item: hono_css.css(
      "display: flex; align-items: center; gap: 1rem; padding: 0.5rem 0; border-bottom: 1px solid #eee;",
    ),
    nav: hono_css.css("background: #333; color: white; padding: 1rem;"),
    nav_link: hono_css.css(
      "color: white; text-decoration: none; margin-right: 1rem;",
    ),
  }
}

// ============ Auth Setup ============

///|
pub fn create_auth(db : @sqlite.DatabaseSync) -> @better_auth.Auth {
  @better_auth.betterAuth(
    database=ffi_sqlite_adapter(db),
    providers=[@better_auth.EmailPassword::{ enabled: true }],
    secret="realworld-secret-key-change-in-production",
  )
}

///|
extern "js" fn ffi_sqlite_adapter(db : @sqlite.DatabaseSync) -> @core.Any =
  #|(db) => db

// ============ Middleware ============

///|
/// Get current user from session using database lookup
fn get_session_user(
  db : @sqlite.DatabaseSync,
  c : Ctx,
) -> @better_auth.User? {
  // Get session token from cookie
  let cookie = @hono.get_cookie(c, "better-auth.session_token")
  match cookie {
    None => None
    Some(token) => {
      // Find session in database
      let stmt = db.prepare(
        "SELECT s.userId, u.id, u.name, u.email, u.emailVerified, u.image FROM session s JOIN user u ON s.userId = u.id WHERE s.token = ?",
      )
      let results = stmt.all(anonymous_parameters=[token |> @core.any])
      if results.length() > 0 {
        Some(results[0].cast())
      } else {
        None
      }
    }
  }
}

///|
extern "js" fn ffi_get_request_headers(c : Ctx) -> @core.Any =
  #|(c) => c.req.raw.headers

// ============ Layout ============

///|
priv struct LayoutProps {
  title : String
  children : Array[&@hono.HonoNode]
  user : @better_auth.User?
  styles : Styles
  hono_css : @hono.HonoCss
}

///|
fn default_layout(props : LayoutProps) -> @hono.JSXNode {
  @hono.jsx(
    "html",
    [
      @hono.jsx("head", [
        @hono.jsx("title", [props.title]),
        @hono.jsx("meta", [], props={ "charset": @core.any("UTF-8") }),
        props.hono_css.style_component(),
      ]),
      @hono.jsx(
        "body",
        [
          nav(
            [
              div(
                [
                  strong(["Realworld TODO"]),
                  a(["Home"], href="/", class=props.styles.nav_link),
                  match props.user {
                    Some(user) =>
                      span([
                        span(["Welcome, ", user.email()]),
                        a([" | Logout"], href="/auth/logout", class=props.styles.nav_link),
                      ])
                    None =>
                      span([
                        a(["Login"], href="/auth/login", class=props.styles.nav_link),
                        a(["Register"], href="/auth/register", class=props.styles.nav_link),
                      ])
                  },
                ],
                class=props.styles.container,
              ),
            ],
            class=props.styles.nav,
          ),
          main_(props.children, class=props.styles.container),
        ],
        class=props.styles.body,
      ),
    ],
    class=props.styles.html,
  )
}

// ============ App ============

///|
pub async fn create_app(
  db : @sqlite.DatabaseSync,
  auth : @better_auth.Auth,
) -> App {
  let hono_css = @hono.import_hono_css()
  let styles = create_styles(hono_css)
  let app : App = @hono.Hono::new()

  // Mount better-auth routes
  let _ = @hono.mount_auth(app, auth)

  // Home page - TODO list
  app
  .get("/", async fn(c) {
    let user = get_session_user(db, c)
    match user {
      Some(u) => {
        let todos = get_todos(db, u.id())
        let content = default_layout({
          title: "My TODOs",
          user: Some(u),
          styles,
          hono_css,
          children: [
            div(
              [
                h1(["My TODOs"]),
                // Add TODO form
                form(
                  [
                    input(
                      type_="text",
                      name="title",
                      placeholder="Add a new TODO...",
                      required=true,
                      class=styles.input,
                    ),
                    button(["Add"], type_="submit", class=styles.button),
                  ],
                  props={
                    "method": @core.any("POST"),
                    "action": @core.any("/todos"),
                  },
                ),
              ],
              class=styles.card,
            ),
            div(
              todos.map(fn(todo) {
                let id : Int = todo._get("id").cast()
                let title : String = todo._get("title").cast()
                let completed : Int = todo._get("completed").cast()
                div(
                  [
                    input(
                      type_="checkbox",
                      checked=(completed == 1),
                      props={
                        "onchange": @core.any("this.form.submit()"),
                        "form": @core.any("toggle-" + id.to_string()),
                      },
                    ),
                    span(
                      [title],
                      style=if completed == 1 {
                        { "text-decoration": "line-through", "color": "#888" }
                      } else {
                        {}
                      },
                    ),
                    form(
                      [
                        input(
                          type_="hidden",
                          name="completed",
                          value=if completed == 1 { "false" } else { "true" },
                        ),
                      ],
                      id="toggle-" + id.to_string(),
                      props={
                        "method": @core.any("POST"),
                        "action": @core.any(
                          "/todos/" + id.to_string() + "/toggle",
                        ),
                      },
                      style={ "display": "none" },
                    ),
                    form(
                      [button(["Delete"], type_="submit", class=styles.button_danger)],
                      props={
                        "method": @core.any("POST"),
                        "action": @core.any(
                          "/todos/" + id.to_string() + "/delete",
                        ),
                      },
                      style={ "margin-left": "auto" },
                    ),
                  ],
                  class=styles.todo_item,
                )
              }),
              class=styles.card,
            ),
          ],
        })
        c.html_jsx(content)
      }
      None => c.redirect("/auth/login")
    }
  })

  // Create TODO
  .post("/todos", async fn(c) {
    let user = get_session_user(db, c)
    match user {
      Some(u) => {
        let body : @core.Any = ffi_parse_body(c).wait() |> @core.identity()
        let schema = create_todo_schema()
        match schema.safeParse(body) {
          Ok(data) => {
            let title : String = data["title"].cast()
            create_todo(db, u.id(), title)
          }
          Err(_) => ()
        }
        c.redirect("/")
      }
      None => c.redirect("/auth/login")
    }
  })

  // Toggle TODO
  .post("/todos/:id/toggle", async fn(c) {
    let user = get_session_user(db, c)
    match user {
      Some(u) => {
        match c.req.param("id") {
          Some(id) => {
            let body = ffi_parse_body(c).wait()
            let completed : String = body._get("completed").cast()
            toggle_todo(db, u.id(), @strconv.parse_int(id), completed == "true")
          }
          None => ()
        }
        c.redirect("/")
      }
      None => c.redirect("/auth/login")
    }
  })

  // Delete TODO
  .post("/todos/:id/delete", async fn(c) {
    let user = get_session_user(db, c)
    match user {
      Some(u) => {
        match c.req.param("id") {
          Some(id) => delete_todo(db, u.id(), @strconv.parse_int(id))
          None => ()
        }
        c.redirect("/")
      }
      None => c.redirect("/auth/login")
    }
  })

  // Auth pages
  .get("/auth/login", async fn(c) {
    let user = get_session_user(db, c)
    if user is Some(_) {
      return c.redirect("/")
    }
    let content = default_layout({
      title: "Login",
      user: None,
      styles,
      hono_css,
      children: [
        div(
          [
            h1(["Login"]),
            form(
              [
                div([
                  label(["Email"]),
                  input(type_="email", name="email", required=true, class=styles.input),
                ]),
                div([
                  label(["Password"]),
                  input(
                    type_="password",
                    name="password",
                    required=true,
                    class=styles.input,
                  ),
                ]),
                button(["Login"], type_="submit", class=styles.button),
              ],
              props={
                "method": @core.any("POST"),
                "action": @core.any("/auth/login"),
              },
            ),
            p([
              "Don't have an account? ",
              a(["Register"], href="/auth/register"),
            ]),
          ],
          class=styles.card,
        ),
      ],
    })
    c.html_jsx(content)
  })
  .post("/auth/login", async fn(c) {
    let body = ffi_parse_body(c).wait()
    let email : String = body._get("email").cast()
    let password : String = body._get("password").cast()
    let response = auth.api().signInEmail(email~, password~)
    if not(response.hasError()) {
      let token = response.token()
      @hono.set_cookie(
        c,
        "better-auth.session_token",
        token,
        path="/",
        httpOnly=true,
        maxAge=86400 * 7,
      )
      c.redirect("/")
    } else {
      let error_msg = response.errorMessage().unwrap_or("Unknown error")
      let content = default_layout({
        title: "Login Error",
        user: None,
        styles,
        hono_css,
        children: [
          div(
            [
              h1(["Login Failed"]),
              p([error_msg]),
              a(["Try again"], href="/auth/login"),
            ],
            class=styles.card,
          ),
        ],
      })
      c.html_jsx(content, status=401)
    }
  })
  .get("/auth/register", async fn(c) {
    let user = get_session_user(db, c)
    if user is Some(_) {
      return c.redirect("/")
    }
    let content = default_layout({
      title: "Register",
      user: None,
      styles,
      hono_css,
      children: [
        div(
          [
            h1(["Register"]),
            form(
              [
                div([
                  label(["Name"]),
                  input(type_="text", name="name", required=true, class=styles.input),
                ]),
                div([
                  label(["Email"]),
                  input(type_="email", name="email", required=true, class=styles.input),
                ]),
                div([
                  label(["Password"]),
                  input(
                    type_="password",
                    name="password",
                    required=true,
                    props={ "minlength": @core.any(8) },
                    class=styles.input,
                  ),
                ]),
                button(["Register"], type_="submit", class=styles.button),
              ],
              props={
                "method": @core.any("POST"),
                "action": @core.any("/auth/register"),
              },
            ),
            p([
              "Already have an account? ",
              a(["Login"], href="/auth/login"),
            ]),
          ],
          class=styles.card,
        ),
      ],
    })
    c.html_jsx(content)
  })
  .post("/auth/register", async fn(c) {
    let body = ffi_parse_body(c).wait()
    let name : String = body._get("name").cast()
    let email : String = body._get("email").cast()
    let password : String = body._get("password").cast()
    let response = auth.api().signUpEmail(name~, email~, password~)
    if not(response.hasError()) {
      c.redirect("/auth/login")
    } else {
      let error_msg = response.errorMessage().unwrap_or("Unknown error")
      let content = default_layout({
        title: "Register Error",
        user: None,
        styles,
        hono_css,
        children: [
          div(
            [
              h1(["Registration Failed"]),
              p([error_msg]),
              a(["Try again"], href="/auth/register"),
            ],
            class=styles.card,
          ),
        ],
      })
      c.html_jsx(content, status=400)
    }
  })
  .get("/auth/logout", async fn(c) {
    let headers = ffi_get_request_headers(c)
    auth.api().signOut(headers)
    c.redirect("/auth/login")
  })

  // API endpoints for client
  .get("/api/todos", async fn(c) {
    let user = get_session_user(db, c)
    match user {
      Some(u) => {
        let todos = get_todos(db, u.id())
        c.json(todos |> @core.any)
      }
      None => {
        let obj = @core.new_object()
        obj["error"] = "Unauthorized" |> @core.any
        c.json(obj, status=401)
      }
    }
  })
  .post("/api/todos", async fn(c) {
    let user = get_session_user(db, c)
    match user {
      Some(u) => {
        let body : @core.Any = c.req.json() |> @core.identity()
        let schema = create_todo_schema()
        match schema.safeParse(body) {
          Ok(data) => {
            let title : String = data["title"].cast()
            create_todo(db, u.id(), title)
            let obj = @core.new_object()
            obj["success"] = true |> @core.any
            c.json(obj)
          }
          Err(_) => {
            let obj = @core.new_object()
            obj["error"] = "Invalid data" |> @core.any
            c.json(obj, status=400)
          }
        }
      }
      None => {
        let obj = @core.new_object()
        obj["error"] = "Unauthorized" |> @core.any
        c.json(obj, status=401)
      }
    }
  })
  .delete("/api/todos/:id", async fn(c) {
    let user = get_session_user(db, c)
    match user {
      Some(u) =>
        match c.req.param("id") {
          Some(id) => {
            delete_todo(db, u.id(), @strconv.parse_int(id))
            let obj = @core.new_object()
            obj["success"] = true |> @core.any
            c.json(obj)
          }
          None => {
            let obj = @core.new_object()
            obj["error"] = "Invalid id" |> @core.any
            c.json(obj, status=400)
          }
        }
      None => {
        let obj = @core.new_object()
        obj["error"] = "Unauthorized" |> @core.any
        c.json(obj, status=401)
      }
    }
  })
  |> ignore
  app
}

// ============ DB Operations ============

///|
fn get_todos(db : @sqlite.DatabaseSync, user_id : String) -> Array[@core.Any] {
  let stmt = db.prepare(
    "SELECT * FROM todos WHERE user_id = ? ORDER BY created_at DESC",
  )
  stmt.all(anonymous_parameters=[user_id |> @core.any]).map(fn(x) { x.cast() })
}

///|
fn create_todo(
  db : @sqlite.DatabaseSync,
  user_id : String,
  title : String,
) -> Unit {
  let stmt = db.prepare("INSERT INTO todos (user_id, title) VALUES (?, ?)")
  stmt.run(anonymous_parameters=[user_id |> @core.any, title |> @core.any])
  |> ignore
}

///|
fn toggle_todo(
  db : @sqlite.DatabaseSync,
  user_id : String,
  id : Int,
  completed : Bool,
) -> Unit {
  let stmt = db.prepare(
    "UPDATE todos SET completed = ? WHERE id = ? AND user_id = ?",
  )
  stmt.run(anonymous_parameters=[
    if completed {
      1 |> @core.any
    } else {
      0 |> @core.any
    },
    id |> @core.any,
    user_id |> @core.any,
  ])
  |> ignore
}

///|
fn delete_todo(db : @sqlite.DatabaseSync, user_id : String, id : Int) -> Unit {
  let stmt = db.prepare("DELETE FROM todos WHERE id = ? AND user_id = ?")
  stmt.run(anonymous_parameters=[id |> @core.any, user_id |> @core.any])
  |> ignore
}

// ============ FFI ============

///|
extern "js" fn ffi_parse_body(c : Ctx) -> @js.Promise[@core.Any] =
  #|(c) => c.req.parseBody()

///|
pub async fn serve(app : App, port : Int) -> Unit {
  ffi_serve(app |> @core.identity, port).wait()
}

///|
extern "js" fn ffi_serve(app : @core.Any, port : Int) -> @js.Promise[Unit] =
  #|(app, port) => import('@hono/node-server').then(({ serve }) => {
  #|  serve({ fetch: app.fetch, port });
  #|  console.log(`Server running at http://localhost:${port}`);
  #|})
