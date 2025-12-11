// Main entry point
import { greet, VERSION } from './shared.js';

export function main() {
  console.log(greet("World"));
  console.log("Version:", VERSION);
}

main();
