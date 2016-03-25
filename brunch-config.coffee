exports.config =
  paths:
    watched: ['assets']

  files:
    javascripts:
      joinTo: 'vendor.js'

    stylesheets:
      joinTo: 'vendor.css'

  server:
    hostname: '0.0.0.0'
