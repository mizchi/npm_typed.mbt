///|
/// Test npm semver package FFI bindings
test "parse" {
  let result = parse("1.2.3")
  debug_inspect(
    result,
    content=(
      #|Some("1.2.3")
    ),
  )
}

///|
test "valid" {
  let result = valid("1.2.3")
  debug_inspect(
    result,
    content=(
      #|Some("1.2.3")
    ),
  )
  let invalid = valid("not a version")
  debug_inspect(invalid, content="None")
}

///|
test "clean" {
  let result = clean("  =v1.2.3   ")
  debug_inspect(
    result,
    content=(
      #|Some("1.2.3")
    ),
  )
}

///|
test "compare" {
  debug_inspect(compare("1.2.3", "1.2.4"), content="-1")
  debug_inspect(compare("1.2.4", "1.2.3"), content="1")
  debug_inspect(compare("1.2.3", "1.2.3"), content="0")
}

///|
test "comparison operators" {
  debug_inspect(gt("1.2.4", "1.2.3"), content="true")
  debug_inspect(gte("1.2.3", "1.2.3"), content="true")
  debug_inspect(lt("1.2.3", "1.2.4"), content="true")
  debug_inspect(lte("1.2.3", "1.2.3"), content="true")
  debug_inspect(eq("1.2.3", "1.2.3"), content="true")
  debug_inspect(neq("1.2.3", "1.2.4"), content="true")
}

///|
test "satisfies" {
  debug_inspect(
    satisfies("1.2.3", "1.x || >=2.5.0 || 5.0.0 - 7.2.3"),
    content="true",
  )
  debug_inspect(
    satisfies("2.6.0", "1.x || >=2.5.0 || 5.0.0 - 7.2.3"),
    content="true",
  )
  debug_inspect(
    satisfies("0.5.0", "1.x || >=2.5.0 || 5.0.0 - 7.2.3"),
    content="false",
  )
}

///|
test "inc" {
  debug_inspect(
    inc("1.2.3", "major"),
    content=(
      #|Some("2.0.0")
    ),
  )
  debug_inspect(
    inc("1.2.3", "minor"),
    content=(
      #|Some("1.3.0")
    ),
  )
  debug_inspect(
    inc("1.2.3", "patch"),
    content=(
      #|Some("1.2.4")
    ),
  )
  debug_inspect(
    inc("1.2.3", "prerelease", identifier="beta"),
    content=(
      #|Some("1.2.4-beta.0")
    ),
  )
}

///|
test "major, minor, patch" {
  debug_inspect(major("1.2.3"), content="1")
  debug_inspect(minor("1.2.3"), content="2")
  debug_inspect(patch("1.2.3"), content="3")
}

///|
test "prerelease" {
  let result = prerelease("1.2.3-alpha.1")
  // prerelease returns JS array or null
  assert_true(@core.is_array(result))
  let null_result = prerelease("1.2.3")
  assert_true(@core.is_null(null_result))
}

///|
test "diff" {
  debug_inspect(
    diff("1.2.3", "1.2.4"),
    content=(
      #|Some("patch")
    ),
  )
  debug_inspect(
    diff("1.2.3", "1.3.0"),
    content=(
      #|Some("minor")
    ),
  )
  debug_inspect(
    diff("1.2.3", "2.0.0"),
    content=(
      #|Some("major")
    ),
  )
}

///|
test "coerce" {
  debug_inspect(
    coerce("v1.2.3"),
    content=(
      #|Some("1.2.3")
    ),
  )
  debug_inspect(
    coerce("1.2.3.4"),
    content=(
      #|Some("1.2.3")
    ),
  )
  debug_inspect(
    coerce("1.2"),
    content=(
      #|Some("1.2.0")
    ),
  )
}

///|
test "valid_range" {
  debug_inspect(
    valid_range("1.x || >=2.5.0"),
    content=(
      #|Some(">=1.0.0 <2.0.0-0||>=2.5.0")
    ),
  )
  debug_inspect(valid_range("not a range"), content="None")
}

///|
test "sort" {
  let versions = ["1.2.3", "1.0.0", "2.0.0", "1.5.0"]
  debug_inspect(
    sort(versions),
    content=(
      #|["1.0.0", "1.2.3", "1.5.0", "2.0.0"]
    ),
  )
  debug_inspect(
    rsort(versions),
    content=(
      #|["2.0.0", "1.5.0", "1.2.3", "1.0.0"]
    ),
  )
}

///|
test "compare_loose" {
  debug_inspect(compare_loose("1.2.3", "1.2.4"), content="-1")
}

///|
test "max_satisfying and min_satisfying" {
  let versions = ["1.2.3", "1.0.0", "2.0.0", "1.5.0"]
  debug_inspect(
    max_satisfying(versions, "^1.0.0"),
    content=(
      #|Some("1.5.0")
    ),
  )
  debug_inspect(
    min_satisfying(versions, "^1.0.0"),
    content=(
      #|Some("1.0.0")
    ),
  )
}

///|
test "gtr and ltr" {
  debug_inspect(gtr("2.0.0", "^1.0.0"), content="true")
  debug_inspect(ltr("0.5.0", "^1.0.0"), content="true")
}

///|
test "outside" {
  debug_inspect(outside("2.0.0", "^1.0.0", ">"), content="true")
  debug_inspect(outside("0.5.0", "^1.0.0", "<"), content="true")
}
