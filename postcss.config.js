// This file is the configuration used by postcss, which is a transpiler for css files

/** @type {import('postcss-load-config').Config} */
module.exports = {
  plugins: {
    // This must come first. It's what makes the tailwind directives work.
    'postcss-import': {},
    // This invokes talwind with the tailwind.config.js file
    'tailwindcss': { config: './tailwind.config.js' },
    // handles browser compatibility
    'autoprefixer': {},
    ...(process.env.NODE_ENV === "production"  ? {
      // Minify via cssnano, but only if NODE_ENV is set to production
      cssnano: {},
    }: {})
  }
}
