// This file is the configuration used by postcss, which is a transpiler for css files
// Confusingly: This file is invoked through the tailwindcss CLI tool by way of writing
// tailwindcss --postcss -o my-compiled-css-file.css
//
// This is how tailwind (v2)'s documentation suggests running things.
// Later versions of tailwind are "more normal" in that regard.

/** @type {import('postcss-load-config').Config} */
module.exports = {
  plugins: {
    // This must come first. It's what makes the tailwind directives work.
    'postcss-import': {},
    // This invokes talwind with the tailwind.config.js file
    // (confusingly: we invoke postcss via tailwind, so this is really
    // "tailwind inside postcss inside tailwind")
    'tailwindcss': {},
    // handles browser compatibility
    'autoprefixer': {},
    ...(process.env.NODE_ENV === "production"  ? {
      // Minify via cssnano, but only if NODE_ENV is set to production
      cssnano: {},
    }: {})
  }
}
