// Admin entry point - shares utilities with main
import { greet, formatDate, VERSION } from './shared.js';

export function adminPanel() {
  console.log(greet("Admin"));
  console.log("Version:", VERSION);
  console.log("Time:", formatDate(new Date()));
}

adminPanel();
