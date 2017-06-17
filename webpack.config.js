const path = require('path');
const webpack = require('webpack');
const ExtractTextPlugin = require('extract-text-webpack-plugin');
const HtmlWebpackPlugin = require('html-webpack-plugin');

module.exports = {
  entry: {
    bundle: [require.resolve('./client/polyfills.js'), './client/index.jsx'],
  },
  output: {
    filename: 'js/[name].js',
    path: path.resolve(__dirname, 'priv/static'),
  },
  module: {
    rules: [
      {
        test: /\.jsx?$/,
        loader: 'babel-loader',
        query: {
          cacheDirectory: '.webpack_cache/',
        },
        exclude: /(node_modules)/,
      },
      {
        test: /\.s?css$/,
        use: ExtractTextPlugin.extract({
          fallback: 'style-loader',
          use: [{
            loader: 'css-loader',
            options: {
              importLoader: 1,
            },
          },
            'postcss-loader?sourceMap',
          ],
        }),
      },
      {
        test: /\.(eot|otf|ttf|woff|woff2)(\?.*)?$/,
        loader: 'file-loader',
        options: {
          name: 'fonts/[name].[hash:8].[ext]',
        },
      },
      {
        test: /\.(ico|jpg|jpeg|png|gif|svg|webp)(\?.*)?$/,
        loader: 'file-loader',
        options: {
          name: 'images/[name].[hash:8].[ext]',
        },
      },
    ],
  },
  plugins: [
    new webpack.DefinePlugin({
      'process.env.NODE_ENV': JSON.stringify('development'),
    }),
    new webpack.optimize.CommonsChunkPlugin({
      name: 'commons',
      filename: 'js/commons.js',
      minChunks(module) {
        const { context } = module;
        return context && context.indexOf('node_modules') !== -1;
      },
    }),
    new webpack.optimize.CommonsChunkPlugin({
      name: 'view',
      filename: 'js/view.js',
      chunks: ['commons'],
      minChunks(module) {
        const { context } = module;
        return context && (context.indexOf('react') !== -1 || context.indexOf('immutable') !== -1);
      },
    }),
    new webpack.optimize.CommonsChunkPlugin({
      name: 'manifest',
      filename: 'js/manifest.js',
      minChunks: Infinity,
    }),
    new ExtractTextPlugin({
      allChunks: true,
      filename: 'css/[name].css',
    }),
    new HtmlWebpackPlugin({
      title: 'Hutch Calendar',
      filename: 'index.html',
      template: 'client/index.html',
    }),
  ],
};
