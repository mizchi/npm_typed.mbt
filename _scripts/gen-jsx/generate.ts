#!/usr/bin/env -S npx tsx
/**
 * Generate MoonBit JSX element bindings from JSON definitions.
 *
 * Usage:
 *   npx tsx _scripts/gen-jsx/generate.ts --framework=react
 *   npx tsx _scripts/gen-jsx/generate.ts --framework=react --dry-run
 *   npx tsx _scripts/gen-jsx/generate.ts --all
 */

import * as fs from "node:fs";
import * as path from "node:path";

// Types
interface Prop {
  name: string;
  type: string;
  jsName: string;
  required?: boolean;
}

interface EventDef {
  name: string;
  jsName: string;
  eventType: string;
}

interface CustomEvent {
  name: string;
  jsName: string;
  handlerType: string;
}

interface ElementDef {
  tagName: string;
  domType: string;
  hasChildren: boolean;
  props: Prop[];
  customEvents?: CustomEvent[];
  customCallbacks?: CustomEvent[];
}

interface ElementsSchema {
  commonProps: Prop[];
  commonEvents: EventDef[];
  elements: Record<string, ElementDef>;
}

interface FrameworkConfig {
  name: string;
  outputFile: string;
  generatorType?: "react" | "direct"; // react = common_node pattern, direct = call h() directly
  elementType: string;
  nodeTrait: string;
  nodeTraitMethod: string;
  domPackage: string | null;
  hasRefs: boolean;
  refType: string | null;
  hasEventHandlers: boolean;
  eventHandlers: Record<string, string>;
  classAttr: string;
  imports: string[];
  commonNodeFn: string;
  createElementFn: string;
  convertEventHandler: string | null;
  hasCssClass?: boolean;
  cssClassTrait?: string;
  features: {
    key: boolean;
    ref: boolean;
    style: boolean;
    events: boolean;
    cssClass?: boolean;
  };
  header: string;
}

// Parse args
const args = process.argv.slice(2);
const dryRun = args.includes("--dry-run");
const runAll = args.includes("--all");
const frameworkArg = args.find((a) => a.startsWith("--framework="));
const frameworkName = frameworkArg?.split("=")[1];

// Load data
const scriptsDir = path.dirname(new URL(import.meta.url).pathname);
const elements: ElementsSchema = JSON.parse(
  fs.readFileSync(path.join(scriptsDir, "elements.json"), "utf-8")
);

function loadFramework(name: string): FrameworkConfig {
  return JSON.parse(
    fs.readFileSync(
      path.join(scriptsDir, "frameworks", `${name}.json`),
      "utf-8"
    )
  );
}

// Code generation helpers
function indent(lines: string[], level: number = 1): string {
  const prefix = "  ".repeat(level);
  return lines.map((l) => (l ? prefix + l : l)).join("\n");
}

// Generate common_node function
function generateCommonNode(fw: FrameworkConfig): string {
  const lines: string[] = [];

  lines.push("///|");

  // Build generic parameter if needed
  const hasRef = fw.features.ref && fw.hasRefs;
  const genericParam = hasRef ? "[T]" : "";

  // Function signature
  lines.push(`fn${genericParam} common_node(`);
  lines.push("  tag_name : String,");
  lines.push("  props : @core.Any,");
  lines.push(`  children~ : Array[&${fw.nodeTrait}],`);

  // Common props
  lines.push("  id~ : String?,");
  if (fw.features.cssClass && fw.hasCssClass) {
    lines.push(`  class~ : &${fw.cssClassTrait}?,`);
  } else {
    lines.push("  class~ : String?,");
  }
  lines.push("  style~ : Map[String, String]?,");
  lines.push("  tab_index~ : Int?,");

  // Framework-specific
  if (hasRef) {
    lines.push(`  ref_~ : ${fw.refType}[T]?,`);
  }
  lines.push("  key~ : String?,");

  // Event handlers
  if (fw.features.events) {
    for (const event of elements.commonEvents) {
      const handlerType = fw.eventHandlers[event.eventType];
      if (handlerType) {
        // Only add [T] for named types (like @react.MouseEventHandler), not function types
        if (hasRef && handlerType.startsWith("@")) {
          lines.push(`  ${event.name}~ : ${handlerType}[T]?,`);
        } else if (handlerType.startsWith("(")) {
          lines.push(`  ${event.name}~ : (${handlerType})?,`);
        } else {
          lines.push(`  ${event.name}~ : ${handlerType}?,`);
        }
      }
    }
  }

  lines.push(`) -> ${fw.elementType} {`);

  // Body - set common props
  lines.push('  if id is Some(id) {');
  lines.push('    props._set("id", id |> @core.any)');
  lines.push("  }");

  lines.push("  if class is Some(class) {");
  if (fw.features.cssClass && fw.hasCssClass) {
    lines.push(`    props._set("${fw.classAttr}", class.value())`);
  } else {
    lines.push(`    props._set("${fw.classAttr}", class |> @core.any)`);
  }
  lines.push("  }");

  lines.push("  if tab_index is Some(tab_index) {");
  lines.push('    props._set("tabIndex", tab_index |> @core.any)');
  lines.push("  }");

  // Style
  if (fw.features.style) {
    lines.push("  if style is Some(style) {");
    lines.push("    let style_obj = @core.new_object()");
    lines.push("    for k, v in style {");
    lines.push("      style_obj._set(k, v |> @core.any)");
    lines.push("    }");
    lines.push('    props._set("style", style_obj)');
    lines.push("  }");
  }

  // Ref
  if (hasRef) {
    lines.push("  if ref_ is Some(ref_) {");
    lines.push("    let ref_js : @core.Any = ref_.as_any().cast()");
    lines.push('    props._set("ref", ref_js)');
    lines.push("  }");
  }

  // Event handlers
  if (fw.features.events && fw.convertEventHandler) {
    for (const event of elements.commonEvents) {
      if (fw.eventHandlers[event.eventType]) {
        lines.push(`  if ${event.name} is Some(f) {`);
        lines.push(
          `    props._set("${event.jsName}", f |> ${fw.convertEventHandler})`
        );
        lines.push("  }");
      }
    }
  }

  // Children
  lines.push("  let children_count = children.length()");
  lines.push("  if children_count > 0 {");
  lines.push("    if children_count == 1 {");
  lines.push(`      props._set("children", children[0].${fw.nodeTraitMethod}())`);
  lines.push("    } else {");
  lines.push(
    `      let children_js : @core.Any = @core.any(children.map(_.${fw.nodeTraitMethod}()))`
  );
  lines.push('      props._set("children", children_js)');
  lines.push("    }");
  lines.push("  }");

  // Create element
  lines.push("  let props_js : @core.Any = props.cast()");
  lines.push(`  ${fw.createElementFn}(`);
  lines.push("    @core.any(tag_name),");
  lines.push("    props_js,");
  if (fw.features.key) {
    lines.push("    key,");
  }
  lines.push("    children_count~,");
  lines.push("  )");

  lines.push("}");

  return lines.join("\n");
}

// Generate element function
function generateElement(
  name: string,
  elem: ElementDef,
  fw: FrameworkConfig
): string {
  const lines: string[] = [];
  const hasRef = fw.features.ref && fw.hasRefs;
  const domType = fw.domPackage ? `${fw.domPackage}.${elem.domType}` : "Unit";

  lines.push("///|");
  lines.push(`pub fn ${name}(`);

  // Children (if element supports them)
  if (elem.hasChildren) {
    lines.push(`  children : Array[&${fw.nodeTrait}],`);
  }

  // Element-specific props (required props use ~ syntax, optional use ?)
  for (const prop of elem.props) {
    if (prop.required) {
      lines.push(`  ${prop.name}~ : ${prop.type},`);
    } else {
      lines.push(`  ${prop.name}? : ${prop.type},`);
    }
  }

  // Custom events (like onSubmit for form)
  if (elem.customEvents && fw.features.events) {
    for (const ev of elem.customEvents) {
      lines.push(`  ${ev.name}? : ${ev.handlerType},`);
    }
  }

  // Custom callbacks (like action for form)
  if (elem.customCallbacks && fw.features.events) {
    for (const cb of elem.customCallbacks) {
      lines.push(`  ${cb.name}? : ${cb.handlerType},`);
    }
  }

  // Common props
  lines.push("  props? : @core.Any,");
  lines.push("  id? : String,");
  if (fw.features.cssClass && fw.hasCssClass) {
    lines.push(`  class? : &${fw.cssClassTrait},`);
  } else {
    lines.push("  class? : String,");
  }
  lines.push("  style? : Map[String, String],");
  lines.push("  tab_index? : Int,");

  // Ref
  if (hasRef) {
    lines.push(`  ref_? : ${fw.refType}[${domType}],`);
  }

  // Key
  lines.push("  key? : String,");

  // Event handlers
  if (fw.features.events) {
    for (const event of elements.commonEvents) {
      const handlerType = fw.eventHandlers[event.eventType];
      if (handlerType) {
        if (handlerType.startsWith("@")) {
          lines.push(`  ${event.name}? : ${handlerType}[${domType}],`);
        } else {
          lines.push(`  ${event.name}? : ${handlerType},`);
        }
      }
    }
  }

  // Children at the end for void elements (still needed for consistency)
  if (!elem.hasChildren) {
    lines.push(`  children? : Array[&${fw.nodeTrait}],`);
  }

  lines.push(`) -> ${fw.elementType} {`);

  // Body
  const hasCustomProps =
    elem.props.length > 0 ||
    (elem.customEvents && elem.customEvents.length > 0) ||
    (elem.customCallbacks && elem.customCallbacks.length > 0);

  if (hasCustomProps) {
    lines.push("  let custom_props = match props {");
    lines.push("    Some(p) => @core.object_assign(@core.new_object(), p)");
    lines.push("    None => @core.new_object()");
    lines.push("  }");

    // Set element-specific props
    for (const prop of elem.props) {
      if (prop.required) {
        lines.push(
          `  custom_props._set("${prop.jsName}", ${prop.name} |> @core.any)`
        );
      } else {
        lines.push(`  if ${prop.name} is Some(v) {`);
        lines.push(`    custom_props._set("${prop.jsName}", v |> @core.any)`);
        lines.push("  }");
      }
    }

    // Custom events
    if (elem.customEvents && fw.features.events && fw.convertEventHandler) {
      for (const ev of elem.customEvents) {
        lines.push(`  if ${ev.name} is Some(f) {`);
        lines.push(
          `    custom_props._set("${ev.jsName}", f |> ${fw.convertEventHandler})`
        );
        lines.push("  }");
      }
    }

    // Custom callbacks
    if (elem.customCallbacks && fw.features.events && fw.convertEventHandler) {
      for (const cb of elem.customCallbacks) {
        lines.push(`  if ${cb.name} is Some(f) {`);
        lines.push(
          `    custom_props._set("${cb.jsName}", f |> ${fw.convertEventHandler})`
        );
        lines.push("  }");
      }
    }
  }

  // Call common_node
  lines.push("  common_node(");
  lines.push(`    "${elem.tagName}",`);
  if (hasCustomProps) {
    lines.push("    custom_props,");
  } else {
    lines.push("    match props {");
    lines.push("      Some(p) => p");
    lines.push("      None => @core.new_object()");
    lines.push("    },");
  }
  lines.push("    id~,");
  lines.push("    class~,");
  lines.push("    style~,");
  lines.push("    tab_index~,");
  if (hasRef) {
    lines.push("    ref_~,");
  }
  lines.push("    key~,");

  // Event handlers
  if (fw.features.events) {
    for (const event of elements.commonEvents) {
      if (fw.eventHandlers[event.eventType]) {
        lines.push(`    ${event.name}~,`);
      }
    }
  }

  // Children
  if (elem.hasChildren) {
    lines.push("    children~,");
  } else {
    lines.push("    children=children.unwrap_or([]),");
  }

  lines.push("  )");
  lines.push("}");

  return lines.join("\n");
}

// Generate "direct" style element (calls h() directly without common_node)
function generateDirectElement(
  name: string,
  elem: ElementDef,
  fw: FrameworkConfig
): string {
  const lines: string[] = [];

  lines.push("///|");
  lines.push(`pub fn ${name}(`);

  // Children
  if (elem.hasChildren) {
    lines.push(`  children : Array[&${fw.nodeTrait}],`);
  }

  // Element-specific props
  for (const prop of elem.props) {
    if (prop.required) {
      lines.push(`  ${prop.name}~ : ${prop.type},`);
    } else {
      lines.push(`  ${prop.name}? : ${prop.type},`);
    }
  }

  // Common props
  lines.push("  props? : Map[String, @core.Any],");
  if (fw.features.cssClass && fw.hasCssClass) {
    lines.push(`  class? : &${fw.cssClassTrait},`);
  }
  lines.push("  id? : String,");
  lines.push("  style? : Map[String, String],");

  // Ref
  if (fw.features.ref && fw.refType) {
    lines.push(`  ref_? : ${fw.refType},`);
  }

  // Key
  lines.push("  key? : String,");

  // Children for void elements
  if (!elem.hasChildren) {
    lines.push(`  children? : Array[&${fw.nodeTrait}],`);
  }

  lines.push(`) -> ${fw.elementType} {`);

  // Body - build props map with element-specific props
  // For frameworks without native id parameter, we need to pass id via props
  const needsIdInProps = fw.name !== "hono";
  const hasCustomProps = elem.props.length > 0 || needsIdInProps;

  if (hasCustomProps) {
    lines.push("  let custom_props : Map[String, @core.Any] = match props {");
    lines.push("    Some(p) => p");
    lines.push("    None => {}");
    lines.push("  }");

    // Add id to props for frameworks that don't have native id parameter
    if (needsIdInProps) {
      lines.push("  if id is Some(id) {");
      lines.push('    custom_props["id"] = id |> @core.any');
      lines.push("  }");
    }

    for (const prop of elem.props) {
      if (prop.required) {
        lines.push(
          `  custom_props["${prop.jsName}"] = ${prop.name} |> @core.any`
        );
      } else {
        lines.push(`  if ${prop.name} is Some(v) {`);
        lines.push(`    custom_props["${prop.jsName}"] = v |> @core.any`);
        lines.push("  }");
    }
    }
  }

  // Call the framework's h/jsx function
  lines.push(`  ${fw.createElementFn}(`);
  lines.push(`    "${elem.tagName}",`);

  // Children
  if (elem.hasChildren) {
    lines.push("    children,");
  } else {
    lines.push("    children.unwrap_or([]),");
  }

  // Props
  if (hasCustomProps) {
    lines.push("    props=custom_props,");
  } else {
    lines.push("    props?,");
  }

  // Style
  lines.push("    style?,");

  // Class (Hono uses class parameter)
  if (fw.features.cssClass && fw.hasCssClass) {
    lines.push("    class?,");
  }

  // ID (Hono has id parameter)
  if (fw.name === "hono") {
    lines.push("    id?,");
  }

  // Ref
  if (fw.features.ref && fw.refType) {
    lines.push("    ref_?,");
  }

  // Key
  lines.push("    key?,");

  lines.push("  )");
  lines.push("}");

  return lines.join("\n");
}

// Generate full file
function generateFile(fw: FrameworkConfig): string {
  const parts: string[] = [];

  // Header
  parts.push(fw.header);

  if (fw.generatorType === "direct") {
    // Direct style: no common_node, each element calls h() directly
    for (const [name, elem] of Object.entries(elements.elements)) {
      parts.push(generateDirectElement(name, elem, fw));
      parts.push("");
    }
  } else {
    // React style: common_node pattern
    parts.push(generateCommonNode(fw));
    parts.push("");

    for (const [name, elem] of Object.entries(elements.elements)) {
      parts.push(generateElement(name, elem, fw));
      parts.push("");
    }
  }

  return parts.join("\n");
}

// Main
function main() {
  const frameworks = runAll
    ? ["react", "preact", "vue", "hono"]
    : frameworkName
      ? [frameworkName]
      : [];

  if (frameworks.length === 0) {
    console.error("Usage: --framework=<name> or --all");
    process.exit(1);
  }

  console.log(dryRun ? "=== DRY RUN ===" : "Generating JSX elements...");

  for (const name of frameworks) {
    try {
      const fw = loadFramework(name);
      const content = generateFile(fw);
      const outPath = path.join(process.cwd(), fw.outputFile);

      if (dryRun) {
        console.log(`\n=== ${fw.outputFile} ===`);
        console.log(content.slice(0, 2000) + "...");
      } else {
        // Ensure directory exists
        const dir = path.dirname(outPath);
        if (!fs.existsSync(dir)) {
          fs.mkdirSync(dir, { recursive: true });
        }
        fs.writeFileSync(outPath, content);
        console.log(`  Generated: ${fw.outputFile}`);
      }
    } catch (e) {
      console.error(`Error generating ${name}:`, e);
    }
  }

  console.log("\nDone!");
}

main();
