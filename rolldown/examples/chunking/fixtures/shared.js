// Shared utility module - will be extracted as a separate chunk
export function greet(name) {
  return `Hello, ${name}!`;
}

export function formatDate(date) {
  return date.toISOString();
}

export const VERSION = "1.0.0";
