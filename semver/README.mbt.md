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

```mbt test
// Parse a version string
inspect(@semver.parse("1.2.3"), content="Some(\"1.2.3\")")

// Validate version
inspect(@semver.valid("1.2.3"), content="Some(\"1.2.3\")")
inspect(@semver.valid("not a version"), content="None")

// Clean version string
inspect(@semver.clean("  =v1.2.3   "), content="Some(\"1.2.3\")")

// Coerce to valid semver
inspect(@semver.coerce("v1.2.3"), content="Some(\"1.2.3\")")
inspect(@semver.coerce("1.2"), content="Some(\"1.2.0\")")
```

## Version Comparison

```mbt test
// Compare versions (-1, 0, 1)
inspect(@semver.compare("1.2.3", "1.2.4"), content="-1")
inspect(@semver.compare("1.2.4", "1.2.3"), content="1")
inspect(@semver.compare("1.2.3", "1.2.3"), content="0")

// Comparison operators
inspect(@semver.gt("1.2.4", "1.2.3"), content="true")
inspect(@semver.gte("1.2.3", "1.2.3"), content="true")
inspect(@semver.lt("1.2.3", "1.2.4"), content="true")
inspect(@semver.lte("1.2.3", "1.2.3"), content="true")
inspect(@semver.eq("1.2.3", "1.2.3"), content="true")
inspect(@semver.neq("1.2.3", "1.2.4"), content="true")
```

## Range Matching

```mbt test
// Check if version satisfies range
inspect(
  @semver.satisfies("1.2.3", "1.x || >=2.5.0 || 5.0.0 - 7.2.3"),
  content="true",
)
inspect(
  @semver.satisfies("2.6.0", "1.x || >=2.5.0 || 5.0.0 - 7.2.3"),
  content="true",
)
inspect(
  @semver.satisfies("0.5.0", "1.x || >=2.5.0 || 5.0.0 - 7.2.3"),
  content="false",
)

// Validate range
inspect(
  @semver.valid_range("1.x || >=2.5.0"),
  content="Some(\">=1.0.0 <2.0.0-0||>=2.5.0\")",
)
inspect(@semver.valid_range("not a range"), content="None")

// Greater than / Less than range
inspect(@semver.gtr("2.0.0", "^1.0.0"), content="true")
inspect(@semver.ltr("0.5.0", "^1.0.0"), content="true")
```

## Version Manipulation

```mbt test
// Increment version
inspect(@semver.inc("1.2.3", "major"), content="Some(\"2.0.0\")")
inspect(@semver.inc("1.2.3", "minor"), content="Some(\"1.3.0\")")
inspect(@semver.inc("1.2.3", "patch"), content="Some(\"1.2.4\")")
inspect(
  @semver.inc("1.2.3", "prerelease", identifier="beta"),
  content="Some(\"1.2.4-beta.0\")",
)

// Get version diff
inspect(@semver.diff("1.2.3", "1.2.4"), content="Some(\"patch\")")
inspect(@semver.diff("1.2.3", "1.3.0"), content="Some(\"minor\")")
inspect(@semver.diff("1.2.3", "2.0.0"), content="Some(\"major\")")
```

## Version Parts

```mbt test
// Extract version components
inspect(@semver.major("1.2.3"), content="1")
inspect(@semver.minor("1.2.3"), content="2")
inspect(@semver.patch("1.2.3"), content="3")
```

## Array Operations

```mbt test
let versions = ["1.2.3", "1.0.0", "2.0.0", "1.5.0"]

// Sort versions
inspect(
  @semver.sort(versions),
  content="[\"1.0.0\", \"1.2.3\", \"1.5.0\", \"2.0.0\"]",
)
inspect(
  @semver.rsort(versions),
  content="[\"2.0.0\", \"1.5.0\", \"1.2.3\", \"1.0.0\"]",
)

// Find max/min satisfying
inspect(@semver.max_satisfying(versions, "^1.0.0"), content="Some(\"1.5.0\")")
inspect(@semver.min_satisfying(versions, "^1.0.0"), content="Some(\"1.0.0\")")
```

## See Also

- [npm semver documentation](https://github.com/npm/node-semver#usage)
