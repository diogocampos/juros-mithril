'use strict'

m = require 'mithril'

{createComponent, icon} = require './utils'


module.exports =
createComponent class NumberInput

  constructor: ({@onInput}) -> #

  handleInput: (event) ->
    @onInput parseFloat event.target.value


  render: ({label, @onInput}) ->
    m 'p.control', [
      m 'label.label', label

      m '.control', [
        m 'input.input',
          type: 'text'
          placeholder: '0'
          oninput: @handleInput
      ]
    ]
