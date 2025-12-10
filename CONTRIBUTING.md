# Contributing to npm_typed

MoonBit FFI bindings for npm packages.

## Quick Start

```bash
# Clone and setup
git clone https://github.com/mizchi/npm_typed.git
cd npm_typed
pnpm install
moon update && moon install

# Run tests
moon test --target js
```

## Create a New Library

```bash
./_scripts/new-library.sh <package_name> [npm_package_name]

# Examples
./_scripts/new-library.sh lodash
./_scripts/new-library.sh client_dynamodb @aws-sdk/client-dynamodb
```

This creates:
- `<name>/moon.pkg.json`
- `<name>/<name>.mbt` - FFI bindings
- `<name>/<name>_test.mbt` - Tests
- `<name>/README.mbt.md` - Executable docs (symlinked as README.md)

Test your package:
```bash
moon test --package <package_name> --target js
```

## README.mbt.md Guidelines

Each package has a `README.mbt.md` with executable examples using ```` ```mbt test ```` blocks:

```markdown
## Basic Usage

\`\`\`mbt test
let result = @pkg.function("input")
inspect(result, content="expected")
\`\`\`
```

- Focus on **common use cases** (exhaustive tests go in `*_test.mbt`)
- Use `inspect()` for verifiable output
- Keep examples simple

## Workflow

```bash
# 1. Make changes
# 2. Test
moon test --target js

# 3. Format
moon fmt

# 4. Check interface changes
moon info
git diff **/*.mbti
```

## Commit Messages

Use conventional commits: `feat:`, `fix:`, `docs:`, `test:`, `refactor:`

## Resources

- [MoonBit JS FFI Best Practices](https://www.moonbitlang.com/pearls/moonbit-jsffi)
- [GitHub Issues](https://github.com/mizchi/npm_typed/issues)
