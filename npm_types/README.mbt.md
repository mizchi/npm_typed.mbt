# mizchi/npm_typed/npm_types

MoonBit type definitions compatible with [@npm/types](https://www.npmjs.com/package/@npm/types).

This package provides type definitions for npm registry API responses. It does not require any npm dependencies as it only provides pure MoonBit types.

## Installation

```bash
moon add mizchi/npm_typed
```

Add to your `moon.pkg.json`:

```json
{
  "import": [
    "mizchi/npm_typed/npm_types"
  ]
}
```

## Types Overview

### Basic Types

- `Contact` - Person information (author, maintainer, contributor)
- `Signature` - PGP signature data
- `Repository` - Repository information
- `Funding` - Funding information
- `Dist` - Distribution information (tarball, shasum, integrity)
- `Bugs` - Issue tracker information

### Main Types

- `PackageJSON` - package.json file structure
- `PackumentVersion` - Registry metadata for a specific version
- `Packument` - Full registry response for a package
- `ManifestVersion` - Abbreviated version for install operations
- `Manifest` - Abbreviated package manifest

## Basic Usage

```mbt check
///|
test {
  let contact = @npm_types.Contact::new("Alice")
  inspect(contact.name, content="Alice")
  inspect(contact.email, content="None")
}
```

```mbt check
///|
test {
  let repo = @npm_types.Repository::git("https://github.com/example/repo.git")
  inspect(repo.url, content="https://github.com/example/repo.git")
  inspect(repo.type_, content="Some(\"git\")")
}
```

```mbt check
///|
test {
  let pkg = @npm_types.PackageJSON::new("my-package", "1.0.0")
  inspect(pkg.name, content="my-package")
  inspect(pkg.version, content="1.0.0")
}
```

## JSON Serialization

All types derive `ToJson` and `FromJson` for JSON interop:

```mbt check
///|
test {
  let contact = @npm_types.Contact::with_email_and_url(
    "Bob", "bob@example.com", "https://bob.example.com",
  )
  let json = contact.to_json()
  match json {
    Object(map) => {
      inspect(map["name"], content="String(\"Bob\")")
      inspect(map["email"], content="String(\"bob@example.com\")")
    }
    _ => fail("expected object")
  }
}
```

## API Endpoints

This package provides types for the following npm registry endpoints:

- `Packument` - `GET https://registry.npmjs.org/{package}`
- `PackumentVersion` - `GET https://registry.npmjs.org/{package}/{version}`
- `Manifest` - `GET https://registry.npmjs.org/{package}` with `Accept: application/vnd.npm.install-v1+json`

## See Also

- [npm package](https://www.npmjs.com/package/@npm/types)
- [npm registry API](https://github.com/npm/registry/blob/main/docs/REGISTRY-API.md)
