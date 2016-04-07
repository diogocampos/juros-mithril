'use strict'

m = require 'mithril'

JurosApp = require './juros-app'


rootElement = document.getElementById 'app-root'
m.mount rootElement, JurosApp
