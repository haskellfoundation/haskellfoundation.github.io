const colors = require('tailwindcss/colors');

module.exports = {
  purge: {
    enabled: true,
    mode: 'all',
    content: ['./**/*.html'],
  },
  theme: {
    fontFamily: {
      sans: ['Maven Pro', 'sans-serif'],
      display: ['Playfair Display', 'serif'],
      body: ['Maven Pro', 'sans-serif'],
    },
    extend: {
      typography: {
        DEFAULT: {
          css: {
            h2: {
              fontWeight: '400'
            },
            p: {
              color: colors.gray['700']
            },
            li: {
              color: colors.gray['700']
            },
            'ul > li::before': {
              backgroundColor: colors.purple['700']
            },
            a: {
              color: colors.purple['700'],
              textDecoration: 'none',
              fontWeight: 'regular'
            }
          }
        }
      },
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
    require('@tailwindcss/typography')
  ],
}
