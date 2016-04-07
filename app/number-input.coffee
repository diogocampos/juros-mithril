'use strict'

m = require 'mithril'

{createComponent, icon} = require './utils'


Icon =
  currency: 'dollar'
  integer: 'hashtag'
  percentage: 'percent'


module.exports =
createComponent class NumberInput

  constructor: ({@onInput}) -> #

  handleInput: (event) ->
    @onInput parseFloat event.target.value


  render: ({label, type, @onInput}) ->
    m 'p.control', [
      m 'label.label', label

      m '.control.has-icon', [
        m 'input.input.is-text-right.is-large',
          type: 'text'
          placeholder: '0'
          oninput: @handleInput

        icon Icon[type],
          style:
           'font-size': '150%'
           'line-height': '32px'
           'height': '32px'
           'width': '32px'
      ]
    ]
