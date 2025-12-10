#!/bin/bash
# Create a new npm library binding boilerplate
#
# Usage: ./_scripts/new-library.sh <package_name> [npm_package_name]
#
# Examples:
#   ./_scripts/new-library.sh lodash
#   ./_scripts/new-library.sh client_dynamodb @aws-sdk/client-dynamodb

set -e

if [ -z "$1" ]; then
  echo "Usage: $0 <package_name> [npm_package_name]"
  echo ""
  echo "Arguments:"
  echo "  package_name      MoonBit package name (e.g., lodash, client_dynamodb)"
  echo "  npm_package_name  npm package name (defaults to package_name)"
  echo ""
  echo "Examples:"
  echo "  $0 lodash"
  echo "  $0 client_dynamodb @aws-sdk/client-dynamodb"
  exit 1
fi

PACKAGE_NAME="$1"
NPM_PACKAGE="${2:-$PACKAGE_NAME}"

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
PACKAGE_DIR="$PROJECT_ROOT/$PACKAGE_NAME"

# Check if directory already exists
if [ -d "$PACKAGE_DIR" ]; then
  echo "Error: Directory '$PACKAGE_DIR' already exists"
  exit 1
fi

echo "Creating new library: $PACKAGE_NAME"
echo "  npm package: $NPM_PACKAGE"
echo "  directory: $PACKAGE_DIR"
echo ""

# Create directory
mkdir -p "$PACKAGE_DIR"

# Create moon.pkg.json
cat > "$PACKAGE_DIR/moon.pkg.json" << EOF
{
  "supported-targets": ["js"],
  "import": [
    "mizchi/js/core"
  ]
}
EOF

# Create main .mbt file
cat > "$PACKAGE_DIR/$PACKAGE_NAME.mbt" << EOF
///| npm $NPM_PACKAGE package FFI bindings
/// https://www.npmjs.com/package/$NPM_PACKAGE

// TODO: Add your FFI bindings here
// Example:
//
// ///|
// /// Description of the function
// #module("$NPM_PACKAGE")
// pub extern "js" fn example_function(arg : String) -> String = "exampleFunction"

EOF

# Create test file
cat > "$PACKAGE_DIR/${PACKAGE_NAME}_test.mbt" << EOF
///|
test "placeholder" {
  // TODO: Add your tests here
  inspect(true, content="true")
}
EOF

# Create README.mbt.md (executable documentation)
cat > "$PACKAGE_DIR/README.mbt.md" << EOF
# mizchi/npm_typed/$PACKAGE_NAME

MoonBit FFI bindings for [$NPM_PACKAGE](https://www.npmjs.com/package/$NPM_PACKAGE).

## Installation

\`\`\`bash
moon add mizchi/js
moon add mizchi/npm_typed
npm install $NPM_PACKAGE
\`\`\`

Add to your \`moon.pkg.json\`:

\`\`\`json
{
  "import": [
    "mizchi/js",
    "mizchi/js/core",
    "mizchi/npm_typed/$PACKAGE_NAME"
  ]
}
\`\`\`

## Basic Usage

\`\`\`mbt test
// TODO: Add basic usage example
inspect(true, content="true")
\`\`\`

## See Also

- [npm package](https://www.npmjs.com/package/$NPM_PACKAGE)
EOF

# Create README.md as alias (symlink to README.mbt.md)
ln -s "README.mbt.md" "$PACKAGE_DIR/README.md"

# Create package.json with empty peerDependencies
cat > "$PACKAGE_DIR/package.json" << EOF
{
  "private": true,
  "peerDependencies": {
  }
}
EOF

echo "Created:"
echo "  $PACKAGE_DIR/moon.pkg.json"
echo "  $PACKAGE_DIR/package.json"
echo "  $PACKAGE_DIR/$PACKAGE_NAME.mbt"
echo "  $PACKAGE_DIR/${PACKAGE_NAME}_test.mbt"
echo "  $PACKAGE_DIR/README.mbt.md"
echo "  $PACKAGE_DIR/README.md -> README.mbt.md"
echo ""
echo "Next steps:"
echo "  1. Add peerDependencies to $PACKAGE_DIR/package.json"
echo "  2. Add FFI bindings to $PACKAGE_DIR/$PACKAGE_NAME.mbt"
echo "  3. Add tests to $PACKAGE_DIR/${PACKAGE_NAME}_test.mbt"
echo "  4. Update README.mbt.md with usage examples"
echo "  5. Run: moon test --package $PACKAGE_NAME --target js"
