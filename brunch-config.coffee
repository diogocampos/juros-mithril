exports.config =
  paths:
    watched: ['app', 'assets']

  files:
    javascripts:
      joinTo:
        'js/app.js': /^app/
        'js/vendor.js': /^(?!app)/

    stylesheets:
      joinTo: 'css/vendor.css'

  modules:
    autoRequire:
      'js/app.js': ['main']

  npm:
    styles:
      'font-awesome': ['css/font-awesome.css']
      'bulma': ['css/bulma.css']

  plugins:
    assetsmanager: copyTo:
      'fonts': ['node_modules/font-awesome/fonts/*']

  server:
    hostname: '0.0.0.0'
