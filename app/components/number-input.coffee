'use strict'

m = require 'mithril'

{createComponent, icon, KeyCode} = require './helpers'
{formatNumber, parseDigits} = require '../utils/format'


MAX_DIGITS = 17


module.exports =
createComponent class NumberInput

  constructor: ({@field, @binding, @onSubmit}) ->
    # no-op


  handleFocus: (event) ->
    event.preventDefault()
    input = event.target
    end = input.value.length
    input.setSelectionRange end, end


  handleKeyDown: (event) =>
    {keyCode} = event
    return if event.ctrlKey or event.metaKey or keyCode is KeyCode.TAB
    event.preventDefault()

    return if event.altKey or event.shiftKey
    return event.target.blur() + @onSubmit() if keyCode is KeyCode.ENTER
    return @binding 0 if keyCode is KeyCode.ESCAPE

    char = String.fromCharCode keyCode
    digits = event.target.value.replace(/[.,]/g, '').split ''
    if /\d/.test char
      return if digits.length >= MAX_DIGITS
      digits.push char
    else if keyCode is KeyCode.BACKSPACE
      digits.pop()

    @binding parseDigits digits, @field.type


  render: ({@field, @binding, @onSubmit, onBlur}) ->
    value = @binding()

    m 'p.control', [
      m 'label.label', @field.label

      m '.control.has-icon', [
        m 'input.input.has-text-right.is-large',
          type: 'text'
          pattern: '\\d*'
          placeholder: formatNumber 0, @field.type
          value: if value then formatNumber value, @field.type else ''
          onclick: @handleFocus
          onfocus: @handleFocus
          onkeydown: @handleKeyDown
          onblur: onBlur

        icon @field.icon
      ]
    ]
