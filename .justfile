# MoonBit build and test commands

# Default recipe: show available commands
default:
    @just --list

setup:
    pnpm install
    moon install

# Build the project
build:
    moon build

# Run tests
test:
    moon test

# Run tests and update snapshots
test-update:
    moon test --update

# Show test coverage
coverage:
    moon coverage analyze

# Show coverage for a specific package
coverage-package pkg:
    moon coverage analyze --package {{pkg}}

# Clean build artifacts
clean:
    rm -r target
    moon clean

# CI workflow: format, info, check, build, test
ci: build test

# Development workflow: format, info, check
dev-react: build
    cd react/examples/router_app && pnpm dev

test-playwright: build
    PLAYWRIGHT_TEST=1 moon test --no-parallelize ./src/npm/playwright/playwright_test.mbt 