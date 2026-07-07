///|
test "Contact::new" {
  let contact = Contact::new("Alice")
  inspect(contact.name, content="Alice")
  debug_inspect(contact.email, content="None")
  debug_inspect(contact.url, content="None")
}

///|
test "Contact::with_email_and_url" {
  let contact = Contact::with_email_and_url(
    "Bob", "bob@example.com", "https://bob.example.com",
  )
  inspect(contact.name, content="Bob")
  debug_inspect(contact.email, content="Some(\"bob@example.com\")")
  debug_inspect(contact.url, content="Some(\"https://bob.example.com\")")
}

///|
test "Repository::new" {
  let repo = Repository::new("https://github.com/example/repo")
  inspect(repo.url, content="https://github.com/example/repo")
  debug_inspect(repo.type_, content="None")
  debug_inspect(repo.directory, content="None")
}

///|
test "Repository::git" {
  let repo = Repository::git("https://github.com/example/repo.git")
  inspect(repo.url, content="https://github.com/example/repo.git")
  debug_inspect(repo.type_, content="Some(\"git\")")
}

///|
test "PackageJSON::new" {
  let pkg = PackageJSON::new("my-package", "1.0.0")
  inspect(pkg.name, content="my-package")
  inspect(pkg.version, content="1.0.0")
  debug_inspect(pkg.description, content="None")
  debug_inspect(pkg.dependencies, content="None")
}

///|
test "Contact to_json" {
  let contact = Contact::new("Alice")
  let json = contact.to_json()
  // None fields are omitted in JSON
  debug_inspect(
    json,
    content=(
      #|Object({ "name": String("Alice") })
    ),
  )
}

///|
test "Signature" {
  let sig : Signature = { keyid: "abc123", sig: "signature_data" }
  inspect(sig.keyid, content="abc123")
  inspect(sig.sig, content="signature_data")
}

///|
test "Funding" {
  let funding : Funding = {
    type_: "github",
    url: "https://github.com/sponsors/user",
  }
  inspect(funding.type_, content="github")
  inspect(funding.url, content="https://github.com/sponsors/user")
}

///|
test "PeerDependencyMeta" {
  let meta : PeerDependencyMeta = { optional: true }
  inspect(meta.optional, content="true")
}

///|
test "Bugs" {
  let bugs : Bugs = {
    email: Some("bugs@example.com"),
    url: Some("https://github.com/example/repo/issues"),
  }
  debug_inspect(bugs.email, content="Some(\"bugs@example.com\")")
  debug_inspect(
    bugs.url,
    content="Some(\"https://github.com/example/repo/issues\")",
  )
}

///|
test "PackageJSON with dependencies" {
  let deps = { "lodash": "^4.17.21", "express": "^4.18.0" }
  let pkg : PackageJSON = {
    ..PackageJSON::new("my-app", "2.0.0"),
    description: Some("A sample application"),
    license: Some("MIT"),
    dependencies: Some(deps),
  }
  inspect(pkg.name, content="my-app")
  inspect(pkg.version, content="2.0.0")
  debug_inspect(pkg.description, content="Some(\"A sample application\")")
  debug_inspect(pkg.license, content="Some(\"MIT\")")
  inspect(!(pkg.dependencies is None), content="true")
}

///|
test "DevEngineDependency" {
  let dep : DevEngineDependency = {
    name: "node",
    version: Some(">=18.0.0"),
    on_fail: Some("error"),
  }
  inspect(dep.name, content="node")
  debug_inspect(dep.version, content="Some(\">=18.0.0\")")
  debug_inspect(dep.on_fail, content="Some(\"error\")")
}

///|
test "Dist" {
  let dist : Dist = {
    shasum: "abc123def456",
    tarball: "https://registry.npmjs.org/pkg/-/pkg-1.0.0.tgz",
    signatures: [],
    integrity: Some("sha512-abc123"),
    file_count: Some(10),
    unpacked_size: Some(12345),
    npm_signature: None,
    bin: None,
  }
  inspect(dist.shasum, content="abc123def456")
  debug_inspect(dist.integrity, content="Some(\"sha512-abc123\")")
  debug_inspect(dist.file_count, content="Some(10)")
}
