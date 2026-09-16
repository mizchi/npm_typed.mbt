# Changelog

## [0.1.17] - 2026-09-16

### Changed

- Bumped `moonbitlang/async` to `0.22.0`; `mizchi/js` and the split `mizchi/js_*`
  modules stay on `0.13.0` and are now listed alphabetically in `moon.mod`.
- Verified against moon `0.1.20260915` / moonc `v0.10.13`; `.versions` refreshed.
- `moon check` is warning-free again (was 168 warnings):
  - intentional-panic `guard` in tests/examples now uses `guard!`
  - remaining `Array[T]` parameters and results in `extern "js"` signatures moved
    to `FixedArray[T]`, with public wrappers still taking/returning `Array[T]`
  - `Array::new(capacity=)` → `Array(capacity=)`, `StringBuilder::new()` →
    `StringBuilder()`, empty `{}` map literals → `Map([])`
  - dropped unused package imports and `?=Some(..)` argument anti-pattern
- Narrowed or removed stale per-package `warnings = "-N"` suppressions: dropped
  entirely from `claude_code`, `drizzle`, `pg`, `hono_element`, `preact_element`,
  `react_element`, `vue_element` and `react/examples/router_app`.

### Docs

- Package configs are `moon.pkg` / `moon.mod`, not the legacy `*.json` files.
  Install snippets in all READMEs, `_scripts/new-library.sh`, `CLAUDE.md`,
  `CONTRIBUTING.md` and the cheatsheet were updated accordingly, including the
  `mizchi/js/core` → `mizchi/js_core` rename.
- Root README documents the split `mizchi/js_*` modules.
- `semver/README.md` and `zod/README.md` are now symlinks to their executable
  `README.mbt.md` instead of drifted hand-written copies.

### Fixed

- CI's changed-package test loop probed for `moon.pkg.json`, so it never ran any
  package tests; it now looks for `moon.pkg`.

## [0.1.16] - 2026-09-16

### Changed

- Update JavaScript bindings to 0.13.0 and migrate imports to the split modules.
- Convert dynamic argument arrays to `FixedArray` at JavaScript call boundaries while retaining the existing public `Array` parameters.
- Regenerate public interfaces for the new dependency paths.

## [0.1.14] - 2026-04-23

### Changed

- Updated npm dependencies across the workspace
- Bumped `moonbitlang/async` to `0.18.0`
- Bumped `mizchi/js` dependency to `0.10.17`
- Eliminated source warnings and regenerated MoonBit package metadata

## [0.1.13] - 2026-04-09

### Changed

- Bumped `mizchi/js` dependency to `0.10.16`

## [0.1.12] - 2026-04-09

### Changed

- Replaced legacy `supported-targets` manifests with `supported_targets`
- Added explicit `supported_targets = "js"` to JS-only packages that depended on `mizchi/js`

## [0.1.4] - 2025-12-12

### Added

- Community contribution guidelines in three languages (English, Japanese, Chinese)
  - `_docs/guideline.md` - English
  - `_docs/guideline.ja.md` - 日本語
  - `_docs/guideline.cn.md` - 中文
- Updated CONTRIBUTING.md with links to multilingual guidelines

### Changed

- Updated `.mbti` interface files via `moon info`

## [0.1.3] - 2025-12-11

### Added

- FFI bindings for Google zx shell scripting library

### Changed

- Refactored unplugin to use labeled arguments for UnpluginOptions
- Code formatting with `moon fmt`
