'use strict'

m = require 'mithril'


module.exports =

  KeyCode:
    BACKSPACE: 8
    TAB: 9
    ENTER: 13
    ESCAPE: 27


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


  modal: ({onClose}, children) ->
    m '.modal.is-active', [
      m '.modal-background', onclick: onClose
      m '.modal-content', children
      m 'button.modal-close', onclick: onClose
    ]


  notification: ({type, title, onClose}, children) ->
    m '.notification', class: (if type then "is-#{type}"), [
      if onClose then m 'button.delete', onclick: onClose
      if title then m 'p.title.is-5', m 'strong', title
      children
    ]
