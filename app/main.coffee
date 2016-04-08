'use strict'

m = require 'mithril'

JurosApp = require './components/juros-app'


rootElement = document.getElementById 'app-root'
m.mount rootElement, JurosApp
