const autoprefixer = require('autoprefixer');
const cssnano = require('cssnano');

module.exports = {
  plugins: [
    autoprefixer({
      browsers: [
        '>1%',
        'last 4 versions',
        'Firefox ESR',
        'not ie < 9', // React doesn't support IE8 anyway
      ],
    }),
    cssnano({
      discardComments: {
        removeAll: true,
      },
      colormin: true,
      core: true,
      discardDuplicates: true,
      discardOverriden: true,
      mergeLonghand: true,
      orderedValues: true,
      uniqueSelectors: true,
      discardEmpty: true,
      mergeIdents: true,
      mergeRules: true,
      zindex: true,
    }),
  ],
};
