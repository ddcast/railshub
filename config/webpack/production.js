const environment = require('./environment')

environment.loaders.set('ngAnnotate', {
  test: /.js$/,
  exclude: /node_modules/,
  use: [
    {
      loader: 'ng-annotate-loader',
      options: {
        ngAnnotate: 'ng-annotate-patched',
        es6: true,
        explicitOnly: false,
      }
    },
    'babel-loader',
  ]
});

module.exports = environment.toWebpackConfig()
