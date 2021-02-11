module.exports = {
  plugins: [
    require('postcss-import')({
      'path': process.cwd() + "/css"
    }),
    require('tailwindcss'),
    require('postcss-nested'),
    require('autoprefixer'),
    require('cssnano')({
       preset: 'default',
    })
  ]
}
