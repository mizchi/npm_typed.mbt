# Changelog

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
