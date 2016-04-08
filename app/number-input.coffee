'use strict'

m = require 'mithril'

{formatNumber, parseDigits} = require './format'
{createComponent, icon} = require './utils'


ICON =
  currency: 'dollar'
  integer: 'hashtag'
  percentage: 'percent'

MAX_DIGITS = 17


module.exports =
createComponent class NumberInput

  constructor: ({@type, @binding}) -> #


  handleFocus: (event) ->
    event.preventDefault()
    input = event.target
    end = input.value.length
    input.setSelectionRange end, end


  handleKeyDown: (event) ->
    char = String.fromCharCode event.keyCode
    return if char is '\t' or event.ctrlKey or event.metaKey

    event.preventDefault()
    digits = event.target.value.replace(/[.,]/g, '').split ''

    if /\d/.test char
      return if digits.length >= MAX_DIGITS
      digits.push char
    else if char is '\b'
      digits.pop()

    @binding parseDigits digits, @type


  render: ({label, @type, @binding}) ->
    value = @binding()

    m 'p.control', [
      m 'label.label', label

      m '.control.has-icon', [
        m 'input.input.is-text-right.is-large',
          type: 'text'
          pattern: '\\d*'
          placeholder: formatNumber 0, @type
          value: if value then formatNumber value, @type else ''
          onclick: @handleFocus
          onfocus: @handleFocus
          onkeydown: @handleKeyDown

        icon ICON[@type],
          style:
           'font-size': '150%'
           'line-height': '32px'
           'height': '32px'
           'width': '32px'
      ]
    ]
