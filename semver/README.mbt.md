# mizchi/npm_typed/semver

MoonBit FFI bindings for the [npm semver package](https://www.npmjs.com/package/semver).

## Installation

```bash
moon add mizchi/js
moon add mizchi/npm_typed
npm install semver
```

Add to your `moon.pkg.json`:

```json
{
  "import": [
    "mizchi/js",
    "mizchi/js/core",
    "mizchi/npm_typed/semver"
  ]
}
```

## Version Parsing

```mbt check
///|
test {
  // Parse a version string
  debug_inspect(@semver.parse("1.2.3"), content="Some(\"1.2.3\")")

  // Validate version
  debug_inspect(@semver.valid("1.2.3"), content="Some(\"1.2.3\")")
  debug_inspect(@semver.valid("not a version"), content="None")

  // Clean version string
  debug_inspect(@semver.clean("  =v1.2.3   "), content="Some(\"1.2.3\")")

  // Coerce to valid semver
  debug_inspect(@semver.coerce("v1.2.3"), content="Some(\"1.2.3\")")
  debug_inspect(@semver.coerce("1.2"), content="Some(\"1.2.0\")")
}
```

## Version Comparison

```mbt check
///|
test {
  // Compare versions (-1, 0, 1)
  debug_inspect(@semver.compare("1.2.3", "1.2.4"), content="-1")
  debug_inspect(@semver.compare("1.2.4", "1.2.3"), content="1")
  debug_inspect(@semver.compare("1.2.3", "1.2.3"), content="0")

  // Comparison operators
  debug_inspect(@semver.gt("1.2.4", "1.2.3"), content="true")
  debug_inspect(@semver.gte("1.2.3", "1.2.3"), content="true")
  debug_inspect(@semver.lt("1.2.3", "1.2.4"), content="true")
  debug_inspect(@semver.lte("1.2.3", "1.2.3"), content="true")
  debug_inspect(@semver.eq("1.2.3", "1.2.3"), content="true")
  debug_inspect(@semver.neq("1.2.3", "1.2.4"), content="true")
}
```

## Range Matching

```mbt check
///|
test {
  // Check if version satisfies range
  debug_inspect(
    @semver.satisfies("1.2.3", "1.x || >=2.5.0 || 5.0.0 - 7.2.3"),
    content="true",
  )
  debug_inspect(
    @semver.satisfies("2.6.0", "1.x || >=2.5.0 || 5.0.0 - 7.2.3"),
    content="true",
  )
  debug_inspect(
    @semver.satisfies("0.5.0", "1.x || >=2.5.0 || 5.0.0 - 7.2.3"),
    content="false",
  )

  // Validate range
  debug_inspect(
    @semver.valid_range("1.x || >=2.5.0"),
    content="Some(\">=1.0.0 <2.0.0-0||>=2.5.0\")",
  )
  debug_inspect(@semver.valid_range("not a range"), content="None")

  // Greater than / Less than range
  debug_inspect(@semver.gtr("2.0.0", "^1.0.0"), content="true")
  debug_inspect(@semver.ltr("0.5.0", "^1.0.0"), content="true")
}
```

## Version Manipulation

```mbt check
///|
test {
  // Increment version
  debug_inspect(@semver.inc("1.2.3", "major"), content="Some(\"2.0.0\")")
  debug_inspect(@semver.inc("1.2.3", "minor"), content="Some(\"1.3.0\")")
  debug_inspect(@semver.inc("1.2.3", "patch"), content="Some(\"1.2.4\")")
  debug_inspect(
    @semver.inc("1.2.3", "prerelease", identifier="beta"),
    content="Some(\"1.2.4-beta.0\")",
  )

  // Get version diff
  debug_inspect(@semver.diff("1.2.3", "1.2.4"), content="Some(\"patch\")")
  debug_inspect(@semver.diff("1.2.3", "1.3.0"), content="Some(\"minor\")")
  debug_inspect(@semver.diff("1.2.3", "2.0.0"), content="Some(\"major\")")
}
```

## Version Parts

```mbt check
///|
test {
  // Extract version components
  debug_inspect(@semver.major("1.2.3"), content="1")
  debug_inspect(@semver.minor("1.2.3"), content="2")
  debug_inspect(@semver.patch("1.2.3"), content="3")
}
```

## Array Operations

```mbt check
///|
test {
  let versions = ["1.2.3", "1.0.0", "2.0.0", "1.5.0"]

  // Sort versions
  debug_inspect(
    @semver.sort(versions),
    content="[\"1.0.0\", \"1.2.3\", \"1.5.0\", \"2.0.0\"]",
  )
  debug_inspect(
    @semver.rsort(versions),
    content="[\"2.0.0\", \"1.5.0\", \"1.2.3\", \"1.0.0\"]",
  )

  // Find max/min satisfying
  debug_inspect(
    @semver.max_satisfying(versions, "^1.0.0"),
    content="Some(\"1.5.0\")",
  )
  debug_inspect(
    @semver.min_satisfying(versions, "^1.0.0"),
    content="Some(\"1.0.0\")",
  )
}
```

## See Also

- [npm semver documentation](https://github.com/npm/node-semver#usage)
