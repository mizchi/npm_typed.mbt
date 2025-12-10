#!/usr/bin/env -S npx tsx
/**
 * Generate package.json with peerDependencies for each npm binding package.
 *
 * Usage:
 *   npx tsx _scripts/gen-package-json.ts
 *   npx tsx _scripts/gen-package-json.ts --dry-run
 */

import * as fs from "node:fs";
import * as path from "node:path";

const dryRun = process.argv.includes("--dry-run");

// Package name mapping: directory -> npm package(s)
// Format: { dir: "npm-package" } or { dir: ["npm-pkg1", "npm-pkg2"] }
const packageMap: Record<string, string | string[]> = {
  // UI Frameworks
  react: "react",
  react_element: "react",
  react_dom: "react-dom",
  react_dom_client: "react-dom",
  react_dom_server: "react-dom",
  react_dom_static: "react-dom",
  react_router: "react-router",
  testing_library_react: "@testing-library/react",
  preact: "preact",
  testing_library_preact: "@testing-library/preact",
  ink: "ink",
  ink_ui: "@inkjs/ui",
  ink_testing_library: "ink-testing-library",

  // Web Frameworks
  hono: "hono",
  better_auth: "better-auth",
  helmet: "helmet",

  // AI / LLM
  ai: "ai",
  modelcontextprotocol: "@modelcontextprotocol/sdk",
  claude_code: "@anthropic-ai/claude-code",

  // Cloud Services
  client_s3: "@aws-sdk/client-s3",

  // Database
  pglite: "@electric-sql/pglite",
  duckdb: "@duckdb/duckdb-wasm",
  drizzle: "drizzle-orm",
  pg: "pg",

  // Validation / Schema
  zod: "zod",
  ajv: "ajv",

  // Build Tools
  terser: "terser",
  vite: "vite",
  unplugin: "unplugin",
  lighthouse: "lighthouse",
  esbuild: "esbuild",
  oxc_minify: "oxc-minify",

  // Utilities
  date_fns: "date-fns",
  semver: "semver",
  chalk: "chalk",
  colorette: "colorette",
  dotenv: "dotenv",
  chokidar: "chokidar",
  yargs: "yargs",
  debug: "debug",
  jose: "jose",
  comlink: "comlink",
  simple_git: "simple-git",
  ignore: "ignore",
  memfs: "memfs",
  minimatch: "minimatch",
  execa: "execa",
  pino: "pino",
  magic_string: "magic-string",

  // Testing / Development
  vitest: "vitest",
  puppeteer: "puppeteer",
  playwright: "playwright",
  playwright_test: "@playwright/test",
  jsdom: "jsdom",
  happy_dom: "happy-dom",
  global_jsdom: "global-jsdom",
  testing_library: "@testing-library/dom",
  msw: "msw",

  // Parsing
  htmlparser2: "htmlparser2",
  js_yaml: "js-yaml",
  source_map: "source-map",
  error_stack_parser: "error-stack-parser",

  // Vue
  vue: "vue",
  testing_library_vue: "@testing-library/vue",
};

// Get installed version from root package.json
function getInstalledVersion(pkgName: string): string | null {
  const rootPkg = JSON.parse(fs.readFileSync("package.json", "utf-8"));
  const deps = { ...rootPkg.dependencies, ...rootPkg.devDependencies };
  return deps[pkgName]?.replace(/^\^/, "") || null;
}

// Generate version range based on semver rules
// For prerelease versions (alpha/beta/rc): use exact version with prerelease tag
// major >= 1: ^major.x
// major = 0: ~0.minor.x (pin minor)
function generateVersionRange(version: string): string {
  // Handle prerelease versions (e.g., 6.0.0-beta.95, 8.0.0-beta.1)
  if (version.includes("-")) {
    const [base, prerelease] = version.split("-");
    const parts = base.split(".");
    const major = parseInt(parts[0], 10);
    const minor = parts[1] || "0";
    // Extract prerelease type (alpha, beta, rc, etc.)
    const prereleaseType = prerelease.split(".")[0];
    return `^${major}.${minor}.0-${prereleaseType}.0`;
  }

  const parts = version.split(".");
  const major = parseInt(parts[0], 10);

  if (major >= 1) {
    return `^${major}.0.0`;
  } else {
    // 0.x.y -> ~0.x.0
    const minor = parts[1] || "0";
    return `~0.${minor}.0`;
  }
}

// Generate package.json content
function generatePackageJson(
  dirName: string,
  npmPackages: string[]
): object | null {
  const peerDependencies: Record<string, string> = {};

  for (const pkg of npmPackages) {
    const version = getInstalledVersion(pkg);
    if (!version) {
      console.warn(`  Warning: ${pkg} not found in root package.json`);
      continue;
    }
    peerDependencies[pkg] = generateVersionRange(version);
  }

  if (Object.keys(peerDependencies).length === 0) {
    return null;
  }

  return {
    private: true,
    peerDependencies,
  };
}

// Main
function main() {
  console.log(dryRun ? "=== DRY RUN ===" : "Generating package.json files...");

  let created = 0;
  let skipped = 0;

  for (const [dir, pkgs] of Object.entries(packageMap)) {
    const dirPath = path.join(process.cwd(), dir);
    const pkgJsonPath = path.join(dirPath, "package.json");

    // Check if directory exists
    if (!fs.existsSync(dirPath)) {
      console.log(`  Skip: ${dir}/ does not exist`);
      skipped++;
      continue;
    }

    const npmPackages = Array.isArray(pkgs) ? pkgs : [pkgs];
    const content = generatePackageJson(dir, npmPackages);

    if (!content) {
      console.log(`  Skip: ${dir}/ - no valid dependencies`);
      skipped++;
      continue;
    }

    const json = JSON.stringify(content, null, 2) + "\n";

    if (dryRun) {
      console.log(`\n${pkgJsonPath}:`);
      console.log(json);
    } else {
      fs.writeFileSync(pkgJsonPath, json);
      console.log(`  Created: ${dir}/package.json`);
    }
    created++;
  }

  console.log(`\nDone: ${created} created, ${skipped} skipped`);
}

main();
