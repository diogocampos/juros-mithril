exports.config =
  paths:
    watched: ['app', 'assets']

  files:
    javascripts:
      joinTo:
        'app.js': /^app/
        'vendor.js': /^(?!app)/

    stylesheets:
      joinTo: 'vendor.css'

  modules:
    autoRequire:
      'app.js': ['main']

  npm:
    enabled: true

  server:
    hostname: '0.0.0.0'
