# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.3] - 2025-12-12

### Added

- **zx**: Google zx shell scripting library bindings
  - `zx()` function using `@core.tag` for template literal syntax
  - `exec()` async convenience function
  - `ToZxArg` trait for type-safe argument passing
  - `arg()` helper function for easy argument conversion
  - ProcessPromise methods: nothrow, quiet, verbose, timeout, pipe
  - Utility functions: cd, sleep, echo, stdin, which, retry
  - Configuration: set_verbose, set_shell, set_cwd, set_env, set_timeout

- **framer-motion**: Animation library bindings with DOM types

- **zustand**: State management library bindings (zustand/vanilla) with generic typed API

- **immer**: Immutable state library bindings with generic typed API

- **clsx**: Class name utility bindings with typed API

- **classnames**: Class name utility bindings with typed API

- **lit-html**: Template literal HTML library bindings

- **valibot**: Schema validation library bindings with generic typed API

- **pptr-testing-library**: Puppeteer Testing Library bindings

- **rollup_types**: Shared Rollup types package for rolldown/vite

### Changed

- **unplugin**: Convert UnpluginOptions to labeled arguments
- **lit_html**: Use `#module` directive and `import()` for browser compatibility
- **rolldown**: Convert types to structs and add Plugin API
- **vite**: Convert types to structs and reorganize examples

## [0.1.2] - 2025-12-11

### Added

- **rolldown**: Rolldown bundler FFI bindings
- **vite**: SSR examples and Environment API support

### Changed

- Updated for mizchi/js 0.10.0 compatibility

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
