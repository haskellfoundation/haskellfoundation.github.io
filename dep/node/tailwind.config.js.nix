{ devMode ? false }:
''
module.exports = {
  ${if devMode
    then "purge: {},"
    else ''
  purge: {
    enabled: true,
    content: ['./templates/*.html']
  },''}
  darkMode: false, // or 'media' or 'class'
  theme: {
  },
  variants: {},
  plugins: [
  ],
}
''
