# Community Contribution Guide

[日本語](guideline.ja.md) | [中文](guideline.cn.md)

## Help Us Expand npm_typed

Like [DefinitelyTyped](https://github.com/DefinitelyTyped/DefinitelyTyped) provides TypeScript definitions for npm packages, this project aims to provide MoonBit FFI bindings for the npm ecosystem.

We welcome contributions from the community! Whether you want to add bindings for your favorite npm package or improve existing ones, this guide will help you get started.

## Who Can Contribute?

**No deep MoonBit expertise required!** If you have:

- Basic JavaScript/TypeScript knowledge
- Ability to follow existing patterns in the codebase
- Willingness to read the [MoonBit JS FFI guide](https://www.moonbitlang.com/pearls/moonbit-jsffi)

...then you can contribute!

## Getting Started

Use the template generator to create a new library:

```bash
./_scripts/new-library.sh <package_name> [npm_package_name]

# Examples
./_scripts/new-library.sh react
./_scripts/new-library.sh client_s3 @aws-sdk/client-s3
```

This creates the basic file structure. See [CONTRIBUTING.md](../CONTRIBUTING.md) for detailed setup instructions.

## Using AI to Help

We **encourage using AI tools** (Claude, GPT, Copilot, etc.) as pair programmers for creating bindings. Most bindings in this repository were generated with AI assistance.

**Tips for AI-assisted development:**

1. Provide the AI with the npm package documentation
2. Share existing binding examples from this repo as patterns (e.g., [react/react.mbt](../react/react.mbt))
3. Ask AI to generate the `.mbt` file, tests, and README
4. Use the [MoonBit cheatsheet](../_examples/moonbit_cheatsheet.mbt.md) for syntax reference

**Example prompt:**

```
I want to create MoonBit FFI bindings for the npm package "react".
Here's the pattern from an existing binding: [paste example from repo]
Please generate:
1. react.mbt - FFI bindings for createElement, useState, useEffect
2. react_test.mbt - Tests
3. README.mbt.md - Documentation with executable examples
```

## Human Review Required

AI-generated code must be reviewed and verified by a human before merging:

- Run all tests (`moon test --target js`)
- Verify the bindings work as expected
- Check for type safety and edge cases
- Ensure the README examples are accurate

**All PRs will be reviewed by maintainers to ensure quality.**

## How to Request a New Library

1. **Check existing issues** for duplicate requests
2. **Open an issue** with the `library-request` label
3. Include:
   - npm package name
   - Link to documentation
   - Which APIs you need most
   - (Optional) Example TypeScript usage

## How to Contribute a New Library

1. Comment on an existing issue or create a new one to avoid duplicate work
2. Run `./_scripts/new-library.sh <package_name>` to generate template files
3. Implement bindings following existing patterns
4. Submit a PR with your bindings
5. Respond to review feedback

## Quality Guidelines

**What makes a good binding:**

- Covers the most commonly used APIs
- Has clear, runnable examples in README.mbt.md
- Tests verify the bindings work correctly
- Type signatures are as specific as possible (avoid `@core.Any` when a proper type can be defined)

**Acceptable scope:**

- You don't need to cover 100% of the npm package's API
- Start with the most useful 20% of functions
- Mark the binding as "AI Generated" if not fully tested
- Others can expand coverage in future PRs

## PR Checklist

Before submitting your PR, ensure:

- [ ] `moon test --target js` passes
- [ ] `moon fmt` has been run
- [ ] README.mbt.md contains working examples
- [ ] Tests cover the main use cases
- [ ] No hardcoded secrets or credentials

## Getting Help

- **Questions?** Open a [Discussion](https://github.com/mizchi/npm_typed/discussions)
- **Found a bug?** Open an [Issue](https://github.com/mizchi/npm_typed/issues)
- **MoonBit syntax?** See the [cheatsheet](../_examples/moonbit_cheatsheet.mbt.md)

## Resources

- [MoonBit JS FFI Best Practices](https://www.moonbitlang.com/pearls/moonbit-jsffi)
- [MoonBit Documentation](https://www.moonbitlang.com/docs/)
