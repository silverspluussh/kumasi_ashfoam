import { defineConfig, globalIgnores } from "eslint/config";
import nextVitals from "eslint-config-next/core-web-vitals";
import nextTs from "eslint-config-next/typescript";
import reactHooks from "eslint-plugin-react-hooks";

const eslintConfig = defineConfig([
  ...nextVitals,
  ...nextTs,
  {
    // Mount-time Dexie/local reads are the app-wide data pattern;
    // no cascading-render loop (stable callback deps). Keep visible.
    plugins: { "react-hooks": reactHooks },
    rules: { "react-hooks/set-state-in-effect": "warn" },
  },
  // Override default ignores of eslint-config-next.
  globalIgnores([
    // Default ignores of eslint-config-next:
    ".next/**",
    "out/**",
    "build/**",
    "next-env.d.ts",
    // P5/P6 generated output
    ".open-next/**",
    ".wrangler/**",
    "test-results/**",
    "playwright-report/**",
  ]),
]);

export default eslintConfig;
