'use strict'

m = require 'mithril'


init = ->
  root = document.getElementById 'app-root'
  m.render root, view: body
  setTimeout -> require './index'


body = ->
  tabs =
    'juros': 'Juros'
    'parcela': 'Parcela'

  m 'div', [

    page '#juros',
      header: tabBar {tabs, active: 'juros'}
      content: calculator 'ul', [
        field 'li', page: 'juros', name: 'total', 'Total à vista'
        field 'li', page: 'juros', name: 'entrada', value: '0', 'Entrada'
        field 'li', page: 'juros', name: 'periodo', 'Quantidade de parcelas'
        field 'li', page: 'juros', name: 'parcela', 'Valor da parcela'
        buttons 'li', page: 'juros'
        result 'li', page: 'juros', label: 'Taxa de juros'
      ]

    page '#parcela',
      header: tabBar {tabs, active: 'parcela'}
      content: calculator 'ul', [
        field 'li', page: 'parcela', name: 'total', 'Total à vista'
        field 'li', page: 'parcela', name: 'entrada', value: '0', 'Entrada'
        field 'li', page: 'parcela', name: 'periodo', 'Quantidade de parcelas'
        field 'li', page: 'parcela', name: 'juros', 'Taxa de juros'
        buttons 'li', page: 'parcela'
        result 'li', page: 'parcela', label: 'Valor da parcela'
      ]

  ]


page = (selector, {header, content}) ->
  m selector, 'data-role': 'page', [
    m 'div', 'data-role': 'header', header
    m 'div', 'data-role': 'content', content
  ]


tabBar = ({active, tabs}) ->
  m 'div', 'data-role': 'navbar',
    m 'ul',
      for id, label of tabs
        tab 'li', for: id, active: (id is active), label


tab = (selector, options, label) ->
  attrs = href: "##{options.for}"

  if options.active
    attrs['data-icon'] = 'checkbox-on'
    attrs.class = 'ui-btn-active ui-state-persist'
  else
    attrs['data-icon'] = 'checkbox-off'

  m selector,
    m 'a', attrs,
      m 'span', label


calculator = (selector, children) ->
  m selector, 'data-role': 'listview',
    children


field = (selector, {page, name, value}, label) ->
  id = "#{page}-#{name}"

  attrs = {id, name, type: 'number'}
  attrs.placeholder = value if value?

  m selector, 'data-role': 'fieldcontain', [
    m 'label', for: id, label
    m 'input', attrs
  ]


buttons = (selector, {page}) ->
  m selector,
    m 'fieldset.ui-grid-a', [
      m '.ui-block-a',
        m 'button', type: 'button', id: "#{page}-limpar", 'Limpar'
      m '.ui-block-b',
        m 'button', type: 'button', id: "#{page}-calcular", 'data-theme': 'b',
          'Calcular'
    ]


result = (selector, {page, label}) ->
  m selector, class: 'resultado', 'data-theme': 'e',
    m 'span.resultado', [
      "#{label}: "
      m 'span.valor', id: "#{page}-resultado"
    ]


init()
