///| npm registry types - Type definitions compatible with @npm/types
/// https://www.npmjs.com/package/@npm/types
/// https://github.com/npm/types

// =============================================================================
// Basic Types
// =============================================================================

///|
/// Contact information for a person (author, maintainer, contributor)
pub(all) struct Contact {
  name : String
  email : String? // Optional
  url : String? // Optional
} derive(Show, Eq, ToJson, FromJson)

///|
/// PGP signature data
pub(all) struct Signature {
  keyid : String
  sig : String
} derive(Show, Eq, ToJson, FromJson)

///|
/// Repository information
pub(all) struct Repository {
  url : String
  type_ : String? // Optional, "git", "svn", etc.
  directory : String? // Optional, subdirectory within repo
} derive(Show, Eq, ToJson, FromJson)

///|
/// Funding information
pub(all) struct Funding {
  type_ : String
  url : String
} derive(Show, Eq, ToJson, FromJson)

///|
/// Deprecated license format (pre-SPDX)
pub(all) struct DeprecatedLicense {
  type_ : String
  url : String
} derive(Show, Eq, ToJson, FromJson)

///|
/// Peer dependency metadata
pub(all) struct PeerDependencyMeta {
  optional : Bool
} derive(Show, Eq, ToJson, FromJson)

///|
/// Binary file distribution info
pub(all) struct BinDist {
  shasum : String
  tarball : String
} derive(Show, Eq, ToJson, FromJson)

///|
/// Distribution information for a package version
pub(all) struct Dist {
  shasum : String
  tarball : String
  signatures : Array[Signature]
  // Optional fields
  integrity : String? // Subresource integrity hash
  file_count : Int? // Number of files in tarball
  unpacked_size : Int? // Size in bytes when unpacked
  npm_signature : String? // Legacy npm signature
  bin : Map[String, BinDist]? // Binary distributions
} derive(Show, Eq, ToJson, FromJson)

///|
/// Development engine dependency (for devEngines field)
pub(all) struct DevEngineDependency {
  name : String
  version : String? // Optional version constraint
  on_fail : String? // "ignore" | "warn" | "error" | "download"
} derive(Show, Eq, ToJson, FromJson)

///|
/// Development engines configuration
pub(all) struct DevEngines {
  os : Array[DevEngineDependency]?
  cpu : Array[DevEngineDependency]?
  libc : Array[DevEngineDependency]?
  runtime : Array[DevEngineDependency]?
  package_manager : Array[DevEngineDependency]?
} derive(Show, Eq, ToJson, FromJson)

///|
/// Bugs/issue tracker information
pub(all) struct Bugs {
  email : String?
  url : String?
} derive(Show, Eq, ToJson, FromJson)

// =============================================================================
// PackageJSON - package.json file structure
// =============================================================================

///|
/// package.json file structure
/// A loose definition of the package.json structure
pub(all) struct PackageJSON {
  // Required fields
  name : String
  version : String
  // Optional metadata
  description : String?
  keywords : Array[String]?
  homepage : String?
  license : String?
  author : Contact?
  contributors : Array[Contact]?
  repository : Repository?
  bugs : Bugs?
  funding : Array[Funding]?
  // Entry points
  main : String?
  browser : String? // Can also be Record<string, string>
  types : String?
  // Files
  files : Array[String]?
  bin : Map[String, String]?
  man : Array[String]?
  directories : Map[String, String]?
  // Dependencies
  dependencies : Map[String, String]?
  dev_dependencies : Map[String, String]?
  peer_dependencies : Map[String, String]?
  peer_dependencies_meta : Map[String, PeerDependencyMeta]?
  optional_dependencies : Map[String, String]?
  bundled_dependencies : Array[String]?
  bundle_dependencies : Array[String]? // Alias for bundledDependencies
  overrides : Map[String, String]? // Simplified, actual type is recursive
  // Scripts
  scripts : Map[String, String]?
  config : Map[String, String]?
  // Platform constraints
  engines : Map[String, String]?
  os : Array[String]?
  cpu : Array[String]?
  dev_engines : DevEngines?
  // Publishing
  private : Bool?
  publish_config : Map[String, String]?
  workspaces : Array[String]?
  // Deprecated fields
  licenses : Array[DeprecatedLicense]?
} derive(Show, Eq, ToJson, FromJson)

// =============================================================================
// PackumentVersion - Registry metadata for a specific version
// =============================================================================

///|
/// Registry metadata for a specific package version
/// Extends PackageJSON with npm-specific fields
pub(all) struct PackumentVersion {
  // Required fields from PackageJSON
  name : String
  version : String
  // Required npm-specific fields
  id : String // _id: "{name}@{version}"
  npm_version : String // _npmVersion
  dist : Dist
  // Optional fields from PackageJSON
  description : String?
  keywords : Array[String]?
  homepage : String?
  license : String?
  author : Contact?
  contributors : Array[Contact]?
  repository : Repository?
  bugs : Bugs?
  funding : Array[Funding]?
  main : String?
  browser : String?
  types : String?
  files : Array[String]?
  bin : Map[String, String]?
  man : Array[String]?
  directories : Map[String, String]?
  dependencies : Map[String, String]?
  dev_dependencies : Map[String, String]?
  peer_dependencies : Map[String, String]?
  peer_dependencies_meta : Map[String, PeerDependencyMeta]?
  optional_dependencies : Map[String, String]?
  bundled_dependencies : Array[String]?
  bundle_dependencies : Array[String]?
  overrides : Map[String, String]?
  scripts : Map[String, String]?
  config : Map[String, String]?
  engines : Map[String, String]?
  os : Array[String]?
  cpu : Array[String]?
  dev_engines : DevEngines?
  private : Bool?
  publish_config : Map[String, String]?
  workspaces : Array[String]?
  licenses : Array[DeprecatedLicense]?
  // Optional npm-specific fields
  has_shrinkwrap : Bool? // _hasShrinkwrap
  node_version : String? // _nodeVersion
  npm_user : Contact? // _npmUser
  maintainers : Array[Contact]?
  deprecated : String?
  git_head : String?
  readme : String?
  readme_filename : String?
} derive(Show, Eq, ToJson, FromJson)

// =============================================================================
// Packument - Full registry response for a package
// =============================================================================

///|
/// Time information for package versions
pub(all) struct PackumentTime {
  created : String // ISO date string
  modified : String // ISO date string
  versions : Map[String, String] // version -> ISO date
} derive(Show, Eq, ToJson, FromJson)

///|
/// Full registry response for a package
/// GET https://registry.npmjs.org/{package}
pub(all) struct Packument {
  // Required fields
  id : String // _id: package name
  rev : String // _rev: CouchDB revision
  name : String
  dist_tags : Map[String, String] // e.g., {"latest": "1.0.0"}
  time : PackumentTime
  versions : Map[String, PackumentVersion]
  // Optional fields (hoisted from latest version)
  description : String?
  keywords : Array[String]?
  homepage : String?
  license : String?
  author : Contact?
  contributors : Array[Contact]?
  repository : Repository?
  bugs : Bugs?
  maintainers : Array[Contact]?
  readme : String?
  readme_filename : String?
  // npm-specific optional
  cached : Bool? // _cached
  users : Map[String, Bool]? // deprecated star list
} derive(Show, Eq, ToJson, FromJson)

// =============================================================================
// ManifestVersion - Abbreviated version for install operations
// =============================================================================

///|
/// Abbreviated version info for install operations
/// Returned with Accept: application/vnd.npm.install-v1+json
pub(all) struct ManifestVersion {
  // Required fields
  name : String
  version : String
  dist : Dist
  // Optional install-relevant fields
  has_shrinkwrap : Bool?
  bin : Map[String, String]?
  bundled_dependencies : Array[String]?
  bundle_dependencies : Array[String]?
  dependencies : Map[String, String]?
  dev_dependencies : Map[String, String]?
  directories : Map[String, String]?
  engines : Map[String, String]?
  optional_dependencies : Map[String, String]?
  peer_dependencies : Map[String, String]?
  deprecated : String?
} derive(Show, Eq, ToJson, FromJson)

///|
/// Abbreviated package manifest for install operations
/// GET https://registry.npmjs.org/{package} with Accept: application/vnd.npm.install-v1+json
pub(all) struct Manifest {
  name : String
  dist_tags : Map[String, String]
  modified : String // ISO date string
  versions : Map[String, ManifestVersion]
  // Optional
  cached : Bool?
} derive(Show, Eq, ToJson, FromJson)

// =============================================================================
// Helper functions
// =============================================================================

///|
/// Create a new Contact with only name
pub fn Contact::new(name : String) -> Contact {
  { name, email: None, url: None }
}

///|
/// Create a Contact with all fields
pub fn Contact::with_email_and_url(
  name : String,
  email : String,
  url : String,
) -> Contact {
  { name, email: Some(email), url: Some(url) }
}

///|
/// Create a new Repository
pub fn Repository::new(url : String) -> Repository {
  { url, type_: None, directory: None }
}

///|
/// Create a Repository with type
pub fn Repository::git(url : String) -> Repository {
  { url, type_: Some("git"), directory: None }
}

///|
/// Create a new empty PackageJSON
pub fn PackageJSON::new(name : String, version : String) -> PackageJSON {
  {
    name,
    version,
    description: None,
    keywords: None,
    homepage: None,
    license: None,
    author: None,
    contributors: None,
    repository: None,
    bugs: None,
    funding: None,
    main: None,
    browser: None,
    types: None,
    files: None,
    bin: None,
    man: None,
    directories: None,
    dependencies: None,
    dev_dependencies: None,
    peer_dependencies: None,
    peer_dependencies_meta: None,
    optional_dependencies: None,
    bundled_dependencies: None,
    bundle_dependencies: None,
    overrides: None,
    scripts: None,
    config: None,
    engines: None,
    os: None,
    cpu: None,
    dev_engines: None,
    private: None,
    publish_config: None,
    workspaces: None,
    licenses: None,
  }
}
