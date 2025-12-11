///|
/// SSR Example with Vite + Hono
///
/// This example demonstrates a practical SSR setup:
/// 1. Create Vite dev server in middleware mode
/// 2. Use Hono for routing
/// 3. Handle SSR requests with Environment API
/// 4. Serve static assets through Vite

///|
/// HTML template with SSR placeholder
let index_html : String =
  #|<!DOCTYPE html>
  #|<html lang="en">
  #|<head>
  #|  <meta charset="UTF-8">
  #|  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  #|  <title>Vite + Hono SSR</title>
  #|</head>
  #|<body>
  #|  <div id="app"><!--ssr-outlet--></div>
  #|  <script type="module" src="/src/entry-client.js"></script>
  #|</body>
  #|</html>

///|
fn main {
  run_ssr_server()
}

///|
/// Run the SSR server with Vite and Hono
fn run_ssr_server() -> Unit {
  @js.run_async(async fn() -> Unit noraise {
    println("=== Vite + Hono SSR Server ===\n")

    // Create Vite server in middleware mode
    let server_opts = @core.new_object()
    server_opts["middlewareMode"] = @core.any(true)
    let vite = @vite.createServer(root=".", logLevel="info", server=server_opts) catch {
      e => {
        println("Failed to create Vite server: \{e}")
        return
      }
    }
    println("✓ Vite server created")

    // Create Hono app
    let app : @hono.Hono[Unit, Unit] = @hono.Hono::new() catch {
      e => {
        println("Failed to create Hono app: \{e}")
        return
      }
    }
    println("✓ Hono app created")

    // SSR handler for all routes
    let _ = app.get("*", async fn(c) -> @http.Response {
      let url = c.req.path()

      // Transform HTML with Vite (injects HMR client)
      let html = vite.transformIndexHtml(url, index_html) catch {
        _ => index_html
      }

      // In a real app, you would:
      // 1. Load the server entry with vite.ssrLoadModule() or env.runner.import()
      // 2. Call the render function to get SSR HTML
      // 3. Replace <!--ssr-outlet--> with the rendered content

      // For this example, we'll just inject a simple SSR message
      let ssr_content = "<h1>Hello from SSR!</h1><p>Path: \{url}</p>"
      let final_html = html
        .to_string()
        .replace(old="<!--ssr-outlet-->", new=ssr_content)
      c.html(final_html)
    })

    // Get Vite's connect middleware for static file serving
    let middlewares = vite.middlewares()
    println("✓ Vite middlewares attached")

    // In production, you would use:
    // - Hono's serve-static for static files
    // - Pre-built SSR bundle instead of ssrLoadModule

    // Demonstrate Environment API access
    let ssr_env = vite.ssr()
    println("\nSSR Environment:")
    println("  Name: \{ssr_env.name}")
    println("  Mode: \{ssr_env.mode}")
    println("  Runnable: \{ssr_env.isRunnable()}")
    println("  Fetchable: \{ssr_env.isFetchable()}")

    // Access module graph
    let graph = ssr_env.moduleGraph
    ignore(graph)
    println("  ModuleGraph: available")

    // Access hot channel for HMR
    let hot = ssr_env.hot
    ignore(hot)
    println("  HotChannel: available")

    // Cleanup
    println("\n--- Server Info ---")
    println("Middlewares: \{@core.typeof_(middlewares)}")

    // Close server (in a real app, you'd keep it running)
    vite.close() catch {
      e => println("Failed to close: \{e}")
    }
    println("\n✓ Server closed")
  })
}
