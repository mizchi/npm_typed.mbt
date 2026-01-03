#!/bin/bash
# moonwright-test: Build MoonBit tests and run with Playwright
#
# Usage: ./_scripts/moonwright-test.sh <package_path> [playwright_options...]
#
# Examples:
#   ./_scripts/moonwright-test.sh _examples/realworld/tests
#   ./_scripts/moonwright-test.sh _examples/realworld/tests --project=chromium-mbt
#   ./_scripts/moonwright-test.sh _examples/realworld/tests --list

set -e

if [ -z "$1" ]; then
  echo "Usage: $0 <package_path> [playwright_options...]"
  echo ""
  echo "Arguments:"
  echo "  package_path        Path to MoonBit package with Playwright tests"
  echo "  playwright_options  Additional options passed to 'npx playwright test'"
  echo ""
  echo "Examples:"
  echo "  $0 _examples/realworld/tests"
  echo "  $0 _examples/realworld/tests --project=chromium-mbt"
  echo "  $0 _examples/realworld/tests --list"
  echo ""
  echo "The script will:"
  echo "  1. Build the MoonBit package with 'moon build --target js'"
  echo "  2. Copy the built .js file to <package_path>/<name>_mbt.spec.js"
  echo "  3. Run 'npx playwright test' in the package directory"
  exit 1
fi

PACKAGE_PATH="$1"
shift  # Remove first argument, rest goes to playwright

# Get script directory and project root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# Resolve absolute package path
if [[ "$PACKAGE_PATH" = /* ]]; then
  ABS_PACKAGE_PATH="$PACKAGE_PATH"
else
  ABS_PACKAGE_PATH="$PROJECT_ROOT/$PACKAGE_PATH"
fi

# Check if package directory exists
if [ ! -d "$ABS_PACKAGE_PATH" ]; then
  echo "Error: Package directory '$PACKAGE_PATH' not found"
  exit 1
fi

# Check if moon.pkg.json exists
if [ ! -f "$ABS_PACKAGE_PATH/moon.pkg.json" ]; then
  echo "Error: No moon.pkg.json found in '$PACKAGE_PATH'"
  exit 1
fi

# Get package name from path (last component)
PACKAGE_NAME=$(basename "$PACKAGE_PATH")

# Build path for JS output
# moon build outputs to target/js/release/build/<package_path>/<name>.js
BUILD_OUTPUT="$PROJECT_ROOT/target/js/release/build/$PACKAGE_PATH/$PACKAGE_NAME.js"

echo "==> Building MoonBit package: $PACKAGE_PATH"
cd "$PROJECT_ROOT"
moon build --target js

# Check if build output exists
if [ ! -f "$BUILD_OUTPUT" ]; then
  echo "Error: Build output not found at '$BUILD_OUTPUT'"
  echo "Expected: target/js/release/build/$PACKAGE_PATH/$PACKAGE_NAME.js"
  exit 1
fi

# Copy built JS to package directory as *_mbt.spec.js
SPEC_FILE="$ABS_PACKAGE_PATH/${PACKAGE_NAME}_mbt.spec.js"
echo "==> Copying built JS to: ${PACKAGE_NAME}_mbt.spec.js"
cp "$BUILD_OUTPUT" "$SPEC_FILE"

# Run playwright test
echo "==> Running Playwright tests"
cd "$ABS_PACKAGE_PATH"
npx playwright test "$@"
