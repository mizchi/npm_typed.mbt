///|
test "inputOptions - creates input options object" {
  let opts = @rolldown.inputOptions(input=@core.any("src/main.js"))
  inspect(@core.typeof_(opts), content="object")
  inspect(opts["input"].cast() |> String::to_string, content="src/main.js")
}

///|
test "inputOptions - with multiple entries" {
  let entries = @core.new_object()
  entries["main"] = @core.any("src/main.js")
  entries["utils"] = @core.any("src/utils.js")
  let opts = @rolldown.inputOptions(input=entries)
  inspect(@core.typeof_(opts), content="object")
  inspect(@core.typeof_(opts["input"]), content="object")
}

///|
test "inputOptions - with platform option" {
  let opts = @rolldown.inputOptions(
    input=@core.any("src/main.js"),
    platform="node",
  )
  inspect(opts["platform"].cast() |> String::to_string, content="node")
}

///|
test "outputOptions - creates output options object" {
  let opts = @rolldown.outputOptions(file="dist/bundle.js", format="esm")
  inspect(@core.typeof_(opts), content="object")
  inspect(opts["file"].cast() |> String::to_string, content="dist/bundle.js")
  inspect(opts["format"].cast() |> String::to_string, content="esm")
}

///|
test "outputOptions - with dir option" {
  let opts = @rolldown.outputOptions(dir="dist", format="cjs")
  inspect(opts["dir"].cast() |> String::to_string, content="dist")
  inspect(opts["format"].cast() |> String::to_string, content="cjs")
}

///|
test "outputOptions - with sourcemap" {
  let opts = @rolldown.outputOptions(
    file="bundle.js",
    sourcemap=@core.any(true),
  )
  inspect(opts["sourcemap"].cast() |> Bool::to_string, content="true")
}

///|
test "buildOptions - creates build options with input and output" {
  let output = @rolldown.outputOptions(file="dist/bundle.js", format="esm")
  let opts = @rolldown.buildOptions(input=@core.any("src/main.js"), output~)
  inspect(@core.typeof_(opts), content="object")
  inspect(opts["input"].cast() |> String::to_string, content="src/main.js")
  inspect(@core.typeof_(opts["output"]), content="object")
}

///|
test "buildOptions - with external modules" {
  let external = @core.new_array()
  external._call("push", [@core.any("lodash"), @core.any("react")]) |> ignore
  let opts = @rolldown.buildOptions(input=@core.any("src/main.js"), external~)
  inspect(@core.typeof_(opts["external"]), content="object")
}

///|
test "define_plugin - creates plugin with name" {
  let plugin = @rolldown.define_plugin("test-plugin")
  inspect(plugin["name"].cast() |> String::to_string, content="test-plugin")
}

///|
test "define_plugin - with transform hook" {
  let plugin = @rolldown.define_plugin("transform-plugin", transform=fn(
    code,
    _id,
  ) {
    Some(code + "\n// transformed")
  })
  inspect(
    plugin["name"].cast() |> String::to_string,
    content="transform-plugin",
  )
  assert_false(@core.is_nullish(plugin["transform"]))
}

///|
test "define_plugin - with multiple hooks" {
  let plugin = @rolldown.define_plugin(
    "multi-hook-plugin",
    buildStart=fn(_opts) { () },
    resolveId=fn(_source, _importer, _opts) { None },
    load=fn(_id) { None },
    transform=fn(_code, _id) { None },
    buildEnd=fn(_err) { () },
  )
  inspect(
    plugin["name"].cast() |> String::to_string,
    content="multi-hook-plugin",
  )
  assert_false(@core.is_nullish(plugin["buildStart"]))
  assert_false(@core.is_nullish(plugin["resolveId"]))
  assert_false(@core.is_nullish(plugin["load"]))
  assert_false(@core.is_nullish(plugin["transform"]))
  assert_false(@core.is_nullish(plugin["buildEnd"]))
}

///|
test "OutputChunk::from_any - creates struct from any" {
  let obj = @core.new_object()
  obj["fileName"] = @core.any("main.js")
  obj["code"] = @core.any("console.log('hello')")
  obj["isEntry"] = @core.any(true)
  obj["name"] = @core.any("main")
  obj["type"] = @core.any("chunk")
  obj["moduleIds"] = @core.any(([] : Array[String]))
  let chunk = @rolldown.OutputChunk::from_any(obj)
  inspect(chunk.fileName, content="main.js")
  inspect(chunk.code, content="console.log('hello')")
  inspect(chunk.isEntry, content="true")
  inspect(chunk.name, content="main")
}

///|
test "OutputAsset::from_any - creates struct from any" {
  let obj = @core.new_object()
  obj["fileName"] = @core.any("style.css")
  obj["source"] = @core.any("body { color: red; }")
  obj["type"] = @core.any("asset")
  obj["name"] = @core.any("style")
  let asset = @rolldown.OutputAsset::from_any(obj)
  inspect(asset.fileName, content="style.css")
  inspect(asset.type_, content="asset")
}

///|
test "RolldownOutput::from_any - creates struct from any" {
  let arr = @core.new_array()
  let output = @core.new_object()
  output["output"] = arr
  let result = @rolldown.RolldownOutput::from_any(output)
  inspect(result.output.length(), content="0")
}
