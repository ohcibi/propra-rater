/* global require, module */

var EmberApp = require('ember-cli/lib/broccoli/ember-app');

var app = new EmberApp({
  sassOptions: {
    ext: "sass"
  },
  autoprefixer: {
    browsers: "last 2 Chrome versions, last 2 Firefox versions, last 2 Safari versions, last 2 Explorer versions",
    cascade: false
  }
});

app.import("bower_components/bootstrap/dist/css/bootstrap.css");
app.import("bower_components/bootstrap/dist/css/bootstrap-theme.css");
app.import("bower_components/bootstrap/js/tooltip.js");
app.import("bower_components/bootstrap/js/collapse.js");

app.import("bower_components/Chart.js/Chart.js");

app.import("vendor/skullfont/styles.css");
app.import("vendor/skullfont/fonts/skullfont.eot", { destDir: "assets/fonts" });
app.import("vendor/skullfont/fonts/skullfont.svg", { destDir: "assets/fonts" });
app.import("vendor/skullfont/fonts/skullfont.ttf", { destDir: "assets/fonts" });
app.import("vendor/skullfont/fonts/skullfont.woff", { destDir: "assets/fonts" });

// Use `app.import` to add additional libraries to the generated
// output files.
//
// If you need to use different assets in different
// environments, specify an object as the first parameter. That
// object's keys should be the environment name and the values
// should be the asset to use in that environment.
//
// If the library that you are including contains AMD or ES6
// modules that you would like to import into your application
// please specify an object with the list of modules as keys
// along with the exports of each module as its value.

module.exports = app.toTree();
