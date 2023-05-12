const { join } = require('path');

/** @type {string[]} */
const topLevelFoldersWithTailwind = [
"board-nominations",
"contact",
"guidelines-for-respectful-communication",
"resources",
"templates",
"vision",
"whitepaper",
"who-we-are",
];

/** @type {string[]} */
const topLevelFilesWithTailwind = [
  '404.html'
]

/**
  * Turns a relative file path to an absolute file path.
  *
  * @param {string} file - Name of a file relative to the git repository.
  */
const makeAbsolute = file => join(__dirname, file);

// This fun little comment below lets us type the value of the tailwind config.
// This is done in a very roundabout way because we're using an ancient
// version of tailwind from before they had types included

/** @type {import('@types/tailwindcss/tailwind-config').TailwindConfig} */
module.exports = {
  purge: {
    // This is the default behavior if "enable" is not specified,
    // but it is explicitly spelled out here
    enabled: process.env.NODE_ENV === "production" ? true : false,
    content: [
      ...topLevelFoldersWithTailwind.map(f => join(makeAbsolute(f), '**', '*.html')),
      ...topLevelFilesWithTailwind.map(f => makeAbsolute(f))
    ],
  },
  darkMode: false, // or 'media' or 'class'
  theme: {
  },
  variants: {},
  plugins: [
  ],
}
