{ devMode ? false }:
''
module.exports = {
  plugins: {
    'tailwindcss': {},
    'autoprefixer': {},
    ${if devMode then "" else '''cssnano': {},''}
    'postcss-import': {}
  }
}
''
