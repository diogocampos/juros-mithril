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


  icon: (name, attrs) ->
    m "i.fa.fa-#{name}", attrs


  message: ({type, title}, children) ->
    m '.message', class: (if type then "is-#{type}" else ''), [
      m '.message-header', title
      m '.message-body', children
    ]
