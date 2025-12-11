///|
/// Code Splitting and Chunk Hydration Example
///
/// This example demonstrates:
/// 1. Multiple entry points with code splitting
/// 2. Shared chunks between entries
/// 3. Chunk analysis and hydration

///|
fn main {
  run_chunking_example()
}

///|
/// Run the code splitting example
fn run_chunking_example() -> Unit {
  @js.run_async(
    async fn() -> Unit noraise {
      println("=== Rolldown Code Splitting Example ===\n")

      // Define input with multiple entries
      let entries = @core.new_object()
      entries["main"] = @core.any("./fixtures/main.js")
      entries["admin"] = @core.any("./fixtures/admin.js")

      // Create output options for code splitting
      let output_opts = @rolldown.outputOptions(
        dir="dist",
        format="esm",
        entryFileNames="[name].js",
        chunkFileNames="shared-[name].js",
      )

      // Build with code splitting
      println("Building with multiple entries...")
      let bundle = @rolldown.rolldown(
        @rolldown.inputOptions(
          input=entries,
          cwd="/Users/mizchi/mizchi/npm_typed.mbt/rolldown/_example_chunking",
        ),
      ) catch {
        e => {
          println("Build failed: \{e}")
          return
        }
      }

      // Generate output in memory (not writing to disk)
      let result = bundle.generate(output_opts) catch {
        e => {
          println("Generate failed: \{e}")
          return
        }
      }
      println("Build completed!\n")

      // Analyze generated chunks
      println("--- Generated Chunks ---")
      let output = result.output()
      let length : Int = output["length"].cast()
      println("Total outputs: \{length}\n")

      let mut entry_count = 0
      let mut chunk_count = 0

      for i = 0; i < length; i = i + 1 {
        let item : @core.Any = output[i.to_string()]
        let type_ : String = item["type"].cast()

        if type_ == "chunk" {
          let chunk : @rolldown.OutputChunk = item.cast()
          let file_name = chunk.fileName()
          let is_entry = chunk.isEntry()
          let name = chunk.name()
          let code = chunk.code()

          if is_entry {
            entry_count = entry_count + 1
            println("Entry Chunk: \{file_name}")
          } else {
            chunk_count = chunk_count + 1
            println("Shared Chunk: \{file_name}")
          }
          println("  Name: \{name}")
          println("  Size: \{code.length()} bytes")

          // Check for imports (hydration dependencies)
          if code.contains("import") {
            println("  Has imports: yes (requires hydration)")
          }
          println("")
        } else {
          let asset_name : String = item["fileName"].cast()
          println("Asset: \{asset_name}")
          println("")
        }
      }

      println("--- Summary ---")
      println("Entry chunks: \{entry_count}")
      println("Shared chunks: \{chunk_count}")

      // Demonstrate hydration pattern
      println("\n--- Hydration Pattern ---")
      println("For SSR/Islands architecture:")
      println("1. Server renders HTML with script tags")
      println("2. Entry chunks import shared chunks")
      println("3. Browser loads entry, discovers shared deps")
      println("4. Shared chunks loaded and executed")
      println("5. Entry chunk hydrates the page")

      // Close bundle
      bundle.close() catch {
        _ => ()
      }
      println("\nDone!")
    },
  )
}
