///|
/// defineConfig example
pub fn config_example() -> Unit {
  println("=== defineConfig Example ===")

  // Create configuration using defineConfig with labeled arguments
  // This returns a @core.Any object directly
  let config = @vite.defineConfig(
    root=".",
    base="/",
    mode="development",
    server=@mbtconv.from_map({
      "port": @core.any(3000),
      "host": @core.any("localhost"),
      "open": @core.any(false),
    }).cast(),
    build=@mbtconv.from_map({
      "outDir": @core.any("dist"),
      "sourcemap": @core.any(true),
      "minify": @core.any(true),
    }).cast(),
  )
  println("✓ Config created with defineConfig")
  println("Config: \{config}")
}
