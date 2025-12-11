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
  let opts = @rolldown.inputOptions(input=@core.any("src/main.js"), platform="node")
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
  let opts = @rolldown.outputOptions(file="bundle.js", sourcemap=@core.any(true))
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
