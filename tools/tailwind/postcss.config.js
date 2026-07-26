// This file is the configuration used by postcss, which is a transpiler for css files

/** @type {import('postcss-load-config').Config} */
module.exports = {
  plugins: {
    // Tailwind v4's PostCSS plugin handles @import internally, so plain
    // postcss-import is no longer needed here. Config lives in
    // assets/css/tailwind.css itself (@theme/@source/@plugin), not a JS file.
    '@tailwindcss/postcss': {},
    // handles browser compatibility
    'autoprefixer': {},
    // No minifier: the output is checked in as assets/css/tailwind.built.css and
    // shipped as-is, and a readable diff is worth more than the ~800 gzipped
    // bytes cssnano saved.
  }
}
