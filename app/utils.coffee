'use strict'

m = require 'mithril'


module.exports =

  createComponent: (cls) ->
    controller: (attrs, children) ->
      ctlr = new cls attrs, children
      for key, handler of ctlr when 0 is key.indexOf 'handle'
        ctlr[key] = handler.bind ctlr
      ctlr

    view: (ctlr, attrs, children) ->
      ctlr.render attrs, children
