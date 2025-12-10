# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0] - 2025-12-10

### Initial Release

This package was split from [mizchi/js](https://github.com/mizchi/js.mbt) v0.8.8 to provide focused npm package bindings.

#### What's Included

- **60+ npm package bindings** for popular libraries:
  - UI Frameworks: React, Preact, Vue, Ink
  - Web Frameworks: Hono
  - AI/LLM: Vercel AI SDK, MCP SDK
  - Database: PGlite, DuckDB, Drizzle
  - Build Tools: Vite, esbuild, Terser
  - Testing: Vitest, Playwright, Testing Library
  - And many more utilities

#### New Features

- `peerDependencies` in each package's `package.json` for version compatibility
- `README.mbt.md` executable documentation with `mbt test` blocks
- `_scripts/new-library.sh` boilerplate generator for new bindings
- `_scripts/gen-package-json.ts` for regenerating package.json files

#### Migration from mizchi/js

If you were using npm bindings from `mizchi/js/npm/*`, update your imports:

```diff
- "mizchi/js/npm/react"
+ "mizchi/npm_typed/react"
```

#### Dependencies

- Requires `mizchi/js` >= 0.9.0 as peer dependency
- Requires MoonBit nightly `2025-12-09` or later for ESM `#module` directive support
