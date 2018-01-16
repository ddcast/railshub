const { environment } = require('@rails/webpacker')

environment.loaders.set('raw', {
  test: /.html$/,
  loader: 'raw-loader'
});

module.exports = environment
