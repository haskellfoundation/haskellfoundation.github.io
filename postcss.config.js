/** @type {import('postcss-load-config').Config} */
module.exports = {
  plugins: {
    'postcss-import': {},
    'tailwindcss': {},
    'autoprefixer': {},
    ...(process.env.NODE_ENV === "production"  ? {
      // This optionally enable cssnano only if NODE_ENV is set to production
      //
      cssnano: {},
    }: {})
  }
}
