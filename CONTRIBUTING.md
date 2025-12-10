# Contributing to js.mbt

Thank you for your interest in contributing to js.mbt! This document provides guidelines and instructions for contributing to the project.

## Table of Contents

- [Getting Started](#getting-started)
- [Development Setup](#development-setup)
- [Running Tests](#running-tests)
- [Code Style](#code-style)
- [Submitting Changes](#submitting-changes)

## Getting Started

mizchi/npm_typed is a collection of MoonBit FFI bindings for npm packages.

### Creating a New Library Binding

Use the boilerplate script to create a new library:

```bash
# Basic usage
./_scripts/new-library.sh <package_name>

# With custom npm package name
./_scripts/new-library.sh <package_name> <npm_package_name>

# Examples
./_scripts/new-library.sh lodash
./_scripts/new-library.sh client_dynamodb @aws-sdk/client-dynamodb
```

This creates:
- `<package_name>/moon.pkg.json` - Package configuration
- `<package_name>/<package_name>.mbt` - FFI bindings
- `<package_name>/<package_name>_test.mbt` - Tests
- `<package_name>/README.mbt.md` - Executable documentation
- `<package_name>/README.md` - Symlink to README.mbt.md

After creating, run tests with:
```bash
moon test --package <package_name> --target js
```

### Prerequisites

- [MoonBit](https://www.moonbitlang.com/) - Install the MoonBit toolchain
- [Node.js](https://nodejs.org/) (v18 or later) - For Node.js tests
- [pnpm](https://pnpm.io/) - Package manager for JavaScript dependencies
- Optional
  - [Deno](https://deno.land/) - For running Deno tests
  - [Bun](https://bun.com/docs) - For running Bun tests
  - Playwright and Chrome - For browser tests

## Development Setup

1. Clone the repository:
```bash
git clone https://github.com/mizchi/js.mbt.git
cd js.mbt

# install node.js deps
pnpm install

# moonbit test and build
moon test
moon build
```


## Running Tests

The project has three types of tests:

### 1. MoonBit Core Tests

Run the standard MoonBit test suite:

```bash
moon test
```

### 2. Deno Runtime Tests

Build the project and run Deno-specific tests:

```bash
moon build
deno test --allow-all target/js/release/build/examples/deno/deno.js

# or just test-deno
```
### 3. Playwright Tests

Playwright tests require browser installation and run separately from the main test suite.

```bash
# Install Chromium browser (first time only)
npx playwright install chromium

# Run Playwright tests
PLAYWRIGHT_TEST=1 moon test --no-parallelize -p mizchi/js/npm/playwright
```

These tests cover:
- Browser automation (Chromium, Firefox, WebKit)
- Page navigation and content
- Locators and element interactions
- Forms, clicks, and user actions

> **Note**: Playwright tests run in a separate CI workflow and only trigger on changes to `src/npm/playwright/**` or `src/npm/playwright_test/**`. See [Playwright README](src/npm/playwright/README.md) for more details.

### Running All Tests

To verify all tests pass:

```bash
# 1. MoonBit tests
moon test

# 2. Deno tests
moon build --target js
deno test -A target/js/release/build/examples/deno/deno.js
```

## Code Style

### MoonBit Code

- Follow the [MoonBit style guide](https://docs.moonbitlang.com)
- Use `moon fmt` to format code automatically
- Organize code in blocks separated by `///|`
- Keep deprecated code in `deprecated.mbt` files

### Documentation

- Document all public APIs with doc comments
- Include usage examples where appropriate
- Reference MDN documentation for web APIs

### README.mbt.md - Executable Documentation

Each package should have a `README.mbt.md` file that serves as **living documentation** with executable examples.

**Purpose:**
- `README.mbt.md`: User-facing documentation showing **how to use** the API (concise examples)
- `*_test.mbt`: Comprehensive test coverage (exhaustive edge cases)

**Guidelines:**
- Focus on **common use cases**, not exhaustive API coverage
- Each ```` ```mbt test ```` block should demonstrate a specific feature
- Use `inspect()` for verifiable output (snapshot testing)
- Keep examples simple and self-explanatory
- Avoid testing internal details or edge cases (those belong in `*_test.mbt`)

**Example structure:**
```markdown
# Package Name

Brief description.

## Installation
... installation instructions ...

## Basic Usage
\`\`\`mbt test
// Show the most common use case
let result = @pkg.basic_function("input")
inspect(result, content="expected output")
\`\`\`

## Feature A
\`\`\`mbt test
// Demonstrate Feature A
...
\`\`\`
```

**Running doc tests:**
```bash
moon test --package <package_name> --target js
```

### Testing

- Write tests for new functionality
- Use `moon test --update` to update snapshots when behavior changes intentionally
- Ensure `moon info` shows expected interface changes in `.mbti` files

## Submitting Changes

### Pull Request Process

1. **Fork the repository** and create your branch from `main`:
```bash
git checkout -b feature/my-new-feature
```

2. **Make your changes**:
   - Write clear, descriptive commit messages
   - Add tests for new functionality
   - Update documentation as needed

3. **Test your changes**:
```bash
moon test
moon build --target js
deno test --allow-all target/js/release/build/examples/deno/deno.js
pnpm test:cloudflare
```

4. **Format your code**:
```bash
moon fmt
```

5. **Check interface changes**:
```bash
moon info
git diff **/*.mbti
```

6. **Push to your fork** and submit a pull request

### Commit Messages

- Use clear and descriptive commit messages
- Follow conventional commits format when possible:
  - `feat:` for new features
  - `fix:` for bug fixes
  - `docs:` for documentation changes
  - `test:` for test additions or modifications
  - `refactor:` for code refactoring

### Pull Request Guidelines

- Provide a clear description of the changes
- Reference any related issues
- Ensure all tests pass
- Keep pull requests focused on a single feature or fix
- Update the README.md if adding new features

## Questions or Issues?

If you have questions or run into issues:

- Check existing [GitHub Issues](https://github.com/mizchi/js.mbt/issues)
- Open a new issue for bugs or feature requests
- Include relevant code samples and error messages

## License

By contributing to js.mbt, you agree that your contributions will be licensed under the MIT License.
