const colors = require('tailwindcss/colors');

module.exports = {
  purge: {
    enabled: false,
    // mode: 'all', Due to this issue we can't use 'all' https://github.com/FullHuman/purgecss/issues/392
    content: [
      './templates/*.html'
    ],
  },
  theme: {
    fontFamily: {
      sans: ['Maven Pro', 'sans-serif'],
      display: ['Playfair Display', 'serif'],
      body: ['Maven Pro', 'sans-serif'],
    },
    typography: {
      default: {
        css: {
          p: {
            fontFamily: 'Lato, sans-serif'
          },
          ul: {
            fontFamily: 'Lato, sans-serif'
          },
          li: {
            fontFamily: 'Lato, sans-serif'
          },
          blockquote: {
            borderColor: '#A282E8'
          },
          pre: {
            background: '#F7F7F7',
            color: 'black',
            borderRadius: '0'
          }
        }
      }
    },
    extend: {
      borderRadius: {
        'xl': '1rem',
        '2xl': '1.5rem',
        '3xl': '2rem',
        '4xl': '3rem',
        '5xl': '4rem'
      },
      height: {
      },
      maxWidth: {
        'viewport': '100vp'
      },
      minWidth: {
        '0': '0',
        '1/4': '25%',
        '1/3': '33.33%',
        '1/2': '50%',
        '2/3': '66.66%',
        '3/4': '75%',
        'full': '100%',
        '24': '6rem',
        '32': '8rem',
        '40': '10rem'
      },
      colors: {
        trueGray: colors.trueGray
      },
      fontSize: {
        '8xl': '5rem',
        '10xl': '6rem',
      },
      borderWidth: {
        '3': '3px'
      }
    },
  },
  variants: {
  },
  plugins: [
  ],
}
