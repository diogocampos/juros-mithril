'use strict'

m = require 'mithril'


init = ->
  root = document.getElementById 'app-root'
  m.render root, view: body
  setTimeout -> require './index'


body = ->
  m 'div', [

    m '#juros', 'data-role': 'page', [

      m 'div', 'data-role': 'header', [
        m 'div', 'data-role': 'navbar', [
          m 'ul', [
            m 'li', [
              m 'a.ui-btn-active.ui-state-persist',
                href: '#juros'
                'data-icon': 'checkbox-on'
                m 'span', 'Juros'
            ]
            m 'li', [
              m 'a', href: '#parcela', 'data-icon': 'checkbox-off',
                m 'span', 'Parcela'
            ]
          ]
        ]
      ]

      m 'div', 'data-role': 'content', [
        m 'ul', 'data-role': 'listview', [
          m 'li', 'data-role': 'fieldcontain', [
            m 'label', for: 'juros-total', 'Total à vista'
            m 'input#juros-total', type: 'number', name: 'total'
          ]
          m 'li', 'data-role': 'fieldcontain', [
            m 'label', for: 'juros-entrada', 'Entrada'
            m 'input#juros-entrada',
              type: 'number', name: 'entrada', placeholder: '0'
          ]
          m 'li', 'data-role': 'fieldcontain', [
            m 'label', for: 'juros-periodo', 'Quantidade de parcelas'
            m 'input#juros-periodo', type: 'number', name: 'periodo'
          ]
          m 'li', 'data-role': 'fieldcontain', [
            m 'label', for: 'juros-parcela', 'Valor da parcela'
            m 'input#juros-parcela', type: 'number', name: 'parcela'
          ]
          m 'li', [
            m 'fieldset.ui-grid-a', [
              m '.ui-block-a', [
                m 'button#juros-limpar', type: 'button', 'Limpar'
              ]
              m '.ui-block-b', [
                m 'button#juros-calcular', type: 'button', 'data-theme': 'b',
                  'Calcular'
              ]
            ]
          ]
          m 'li.resultado', 'data-theme': 'e', [
            m 'span.resultado', [
              "Taxa de juros: "
              m 'span.valor', id: "juros-resultado"
            ]
          ]
        ]
      ]

    ]  # div#juros

    m '#parcela', 'data-role': 'page', [

      m 'div', 'data-role': 'header', [
        m 'div', 'data-role': 'navbar', [
          m 'ul', [
            m 'li', [
              m 'a', href: '#juros', 'data-icon': 'checkbox-off',
                m 'span', 'Juros'
            ]
            m 'li', [
              m 'a.ui-btn-active.ui-state-persist',
                href: '#parcela'
                'data-icon': 'checkbox-on'
                m 'span', 'Parcela'
            ]
          ]
        ]
      ]

      m 'div', 'data-role': 'content', [
        m 'ul', 'data-role': 'listview', [
          m 'li', 'data-role': 'fieldcontain', [
            m 'label', for: 'parcela-total', 'Total à vista'
            m 'input#parcela-total', type: 'number', name: 'total'
          ]
          m 'li', 'data-role': 'fieldcontain', [
            m 'label', for: 'parcela-entrada', 'Entrada'
            m 'input#parcela-entrada',
              type: 'number', name: 'entrada', placeholder: '0'
          ]
          m 'li', 'data-role': 'fieldcontain', [
            m 'label', for: 'parcela-periodo', 'Quantidade de parcelas'
            m 'input#parcela-periodo', type: 'number', name: 'periodo'
          ]
          m 'li', 'data-role': 'fieldcontain', [
            m 'label', for: 'parcela-juros', 'Taxa de juros'
            m 'input#parcela-juros', type: 'number', name: 'juros'
          ]
          m 'li', [
            m 'fieldset.ui-grid-a', [
              m '.ui-block-a', [
                m 'button#parcela-limpar', type: 'button', 'Limpar'
              ]
              m '.ui-block-b', [
                m 'button#parcela-calcular', type: 'button', 'data-theme': 'b',
                  'Calcular'
              ]
            ]
          ]
          m 'li.resultado', 'data-theme': 'e', [
            m 'span.resultado', [
              "Valor da parcela: "
              m 'span.valor', id: "parcela-resultado"
            ]
          ]
        ]
      ]

    ]  # div#parcela
  ]


init()
