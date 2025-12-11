///|
/// SSR Example with Vite Environment API
///
/// This example demonstrates how to:
/// 1. Create a Vite dev server in middleware mode
/// 2. Use Environment API for SSR module loading
/// 3. Transform HTML with Vite
/// 4. Render SSR content

///|
/// HTML template for SSR
let html_template : String =
  #|<!DOCTYPE html>
  #|<html>
  #|<head>
  #|  <title>Vite SSR Example</title>
  #|</head>
  #|<body>
  #|  <div id="app"><!--ssr-outlet--></div>
  #|  <script type="module" src="/src/entry-client.js"></script>
  #|</body>
  #|</html>

///|
fn main {
  ssr_example()
}

///|
/// SSR example using Vite Environment API
fn ssr_example() -> Unit {
  @js.run_async(
    async fn() -> Unit noraise {
      println("=== Vite SSR Example ===")

      // Create Vite server with middleware mode for SSR
      let server_config = @core.new_object()
      server_config["middlewareMode"] = @core.any(true)
      let server = @vite.createServer(
        root="/",
        logLevel="info",
        server=server_config,
      ) catch {
        e => {
          println("Failed to create Vite server: \{e}")
          return
        }
      }
      println("✓ Vite server created")

      // Access the SSR environment
      let ssr_env = server.ssr()
      println("✓ SSR environment: \{ssr_env.name()}")
      println("  Mode: \{ssr_env.mode()}")

      // Check if environment is runnable (has a runner)
      if ssr_env.isRunnable() {
        println("✓ SSR environment is runnable")
        let runner = ssr_env.runner()
        println("  Runner closed: \{runner.isClosed()}")
      } else {
        println("✓ SSR environment is not runnable (using ssrLoadModule)")
      }

      // Demonstrate transformIndexHtml
      println("\n--- Transform HTML ---")
      let transformed_html = server.transformIndexHtml("/", html_template) catch {
        e => {
          println("Failed to transform HTML: \{e}")
          html_template
        }
      }
      // The transformed HTML should have Vite's HMR client injected
      let has_hmr = transformed_html.contains("@vite") ||
        transformed_html.contains("vite/client")
      println("✓ HTML transformed (has HMR: \{has_hmr})")

      // Demonstrate module graph access
      println("\n--- Module Graph ---")
      let _ = ssr_env.moduleGraph()
      println("✓ Module graph accessed")

      // Close the server
      println("\n--- Cleanup ---")
      server.close() catch {
        e => println("Failed to close server: \{e}")
      }
      println("✓ Server closed")
    },
  )
}
