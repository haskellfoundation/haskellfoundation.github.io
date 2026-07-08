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
    ...(process.env.NODE_ENV === "production"  ? {
      // Minify via cssnano, but only if NODE_ENV is set to production
      cssnano: {},
    }: {})
  }
}
