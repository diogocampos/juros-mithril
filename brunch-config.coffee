exports.config =
  paths:
    watched: ['app', 'assets']

  files:
    javascripts:
      joinTo:
        'js/app.js': /^app/
        'js/vendor.js': /^(?!app)/

    stylesheets:
      joinTo:
        'css/app.css': /^app/
        'css/vendor.css': /^(?!app)/

  modules:
    autoRequire:
      'js/app.js': ['main']

  npm:
    styles:
      'font-awesome': ['css/font-awesome.css']

  plugins:
    assetsmanager: copyTo:
      'fonts': ['node_modules/font-awesome/fonts/*']

    sass:
      mode: 'native'
      options:
        includePaths: ['node_modules']

  server:
    hostname: '0.0.0.0'
