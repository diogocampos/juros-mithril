'use strict'

m = require 'mithril'

{createComponent, icon} = require './helpers'
{formatNumber, parseDigits} = require '../utils/format'


MAX_DIGITS = 17


module.exports =
createComponent class NumberInput

  constructor: ({@field, @binding}) ->
    # no-op


  onFocus: (event) ->
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

    @binding parseDigits digits, @field.type


  render: ({@field, @binding, onBlur}) ->
    value = @binding()

    m 'p.control', [
      m 'label.label', @field.label

      m '.control.has-icon', [
        m 'input.input.has-text-right.is-large',
          type: 'text'
          pattern: '\\d*'
          placeholder: formatNumber 0, @field.type
          value: if value then formatNumber value, @field.type else ''
          onclick: @onFocus
          onfocus: @onFocus
          onkeydown: @handleKeyDown
          onblur: onBlur

        icon @field.icon
      ]
    ]
