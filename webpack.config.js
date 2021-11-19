var webpack = require("webpack");
var path = require("path");
var ExtractTextPlugin = require("extract-text-webpack-plugin");

module.exports = function config(env) {
  var devtool = env && env.production ? false : "eval";
  return {
    entry: {
      libs: "./web_player/www/libs.js",
      external: "./web_player/www/best-external.js",
      graph_libs: "./web_player/www/graph-libs.js",
      simple_video: "./web_player/www/best-simple-player.js",
      cycling: "./web_player/www/best-cycling.js",
      cycling_audio: "./web_player/www/best-cycling-audio.js",
      balance: "./web_player/www/best-balance.js",
      training: "./web_player/www/best-training.js",
      running: "./web_player/www/best-running.js",
      resume: "./web_player/www/best-resume.js",
      graph: "./web_player/www/best-graph.js",
      mind: "./web_player/www/best-mind.js",
    },

    module: {
      loaders: [
        {
          test: /\.js$/,
          use: [
            {
              loader: "babel-loader",
              options: {
                presets: ["es2015", "stage-2"],
              },
            },
          ],
          exclude: /node_modules/,
        },
        // Load underscore templates
        {
          test: /\.jst$/,
          loader: "underscore-template-loader",
        },
        // Extract css files
        {
          test: /\.css$/,
          loader: ExtractTextPlugin.extract({
            use: "css-loader",
          }),
        },
        // Load woff fonts
        {
          test: /\.woff(2)?(\?v=[0-9]\.[0-9]\.[0-9])?$/,
          loader:
            "url-loader?limit=10000&mimetype=application/font-woff&name=./fonts/[name].[ext]",
        },
        // Load fonts
        {
          test: /\.(otf|ttf|eot|svg)(\?v=[0-9]\.[0-9]\.[0-9])?$/,
          loader: "file-loader?&name=./fonts/[name].[ext]",
        },
        // Load images
        {
          test: /\.(png)$/,
          loader: "file-loader?name=./images/[name].[ext]",
        },
      ],
    },

    resolve: {
      alias: {
        underscore: "lodash",
      },
    },

    plugins: [
      new ExtractTextPlugin("[name].css"),
      new webpack.ProvidePlugin({
        $: "jquery",
        jQuery: "jquery",
      }),
      new webpack.DefinePlugin({
        "process.env.NODE_ENV": JSON.stringify("production"),
      }),
    ],

    devtool: devtool,

    output: {
      filename: "[name].js",
      path: path.resolve(__dirname, "assets/www"),
    },
  };
};
