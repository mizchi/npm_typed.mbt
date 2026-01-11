///|
test "logical position to physical" {
  let logical : @dpi.LogicalPosition = { x: 100.0, y: 200.0 }
  let physical = logical.to_physical(2.0)
  inspect(physical, content="{x: 200, y: 400}")
}

///|
test "physical position to logical" {
  let physical : @dpi.PhysicalPosition = { x: 200, y: 400 }
  let logical = physical.to_logical(2.0)
  inspect(logical, content="{x: 100, y: 200}")
}

///|
test "logical size to physical" {
  let logical : @dpi.LogicalSize = { width: 800.0, height: 600.0 }
  let physical = logical.to_physical(2.0)
  inspect(physical, content="{width: 1600, height: 1200}")
}

///|
test "physical size to logical" {
  let physical : @dpi.PhysicalSize = { width: 1600, height: 1200 }
  let logical = physical.to_logical(2.0)
  inspect(logical, content="{width: 800, height: 600}")
}

///|
test "position union type" {
  let pos : @dpi.Position = @dpi.Position::Logical({ x: 100.0, y: 200.0 })
  let physical = pos.to_physical(2.0)
  inspect(physical, content="{x: 200, y: 400}")
  let logical = pos.to_logical(1.0)
  inspect(logical, content="{x: 100, y: 200}")
}

///|
test "size union type" {
  let size : @dpi.Size = @dpi.Size::Physical({ width: 1600, height: 1200 })
  let logical = size.to_logical(2.0)
  inspect(logical, content="{width: 800, height: 600}")
  let physical = size.to_physical(1.0)
  inspect(physical, content="{width: 1600, height: 1200}")
}

///|
test "position to_any" {
  let pos : @dpi.LogicalPosition = { x: 10.0, y: 20.0 }
  let any_obj = pos.to_any()
  let t : String = any_obj["type"].cast()
  let x : Double = any_obj["x"].cast()
  inspect(t, content="Logical")
  inspect(x, content="10")
}

///|
test "size to_any" {
  let size : @dpi.PhysicalSize = { width: 100, height: 200 }
  let any_obj = size.to_any()
  let t : String = any_obj["type"].cast()
  let w : Int = any_obj["width"].cast()
  inspect(t, content="Physical")
  inspect(w, content="100")
}
