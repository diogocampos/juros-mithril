'use strict'

m = require 'mithril'

NumberInput = require './number-input'

{createComponent, modal, notification} = require './helpers'
{formatNumber} = require '../utils/format'
{storedObject} = require '../utils/storage'


Inputs = storedObject 'inputs'


module.exports =
createComponent class Calculator

  constructor: ({inputs, @calculate}) ->
    @inputs = {}
    @inputs[name] = m.prop Inputs.get(name, 0) for name in inputs
    @results = null

  getValues: ->
    values = {}
    values[name] = prop() for name, prop of @inputs
    values

  handleSaveInputs: ->
    Inputs.assign @getValues()

  handleCalculate: ->
    @results = @calculate @getValues()

  handleClear: ->
    @inputs[name] 0 for name of @inputs
    @handleSaveInputs()
    @results = null

  handleClearResults: ->
    @results = null


  render: ({fields, @calculate}) ->
    m '', [

      m '.columns', m '.column',
        for name, prop of @inputs
          m NumberInput,
            field: fields[name]
            binding: prop
            onBlur: @handleSaveInputs
            onSubmit: @handleCalculate

      m '.columns', m '.column',
        calculatorButtons
          onClear: @handleClear
          onCalculate: @handleCalculate

      if @results
        modal onClose: @handleClearResults,
          calculatorResults {@results, fields}
    ]


calculatorButtons = ({onClear, onCalculate}) ->
  m 'p.control.is-grouped.is-centered', [
    m 'button.button.is-medium', onclick: onClear, 'Limpar'
    m 'button.button.is-medium.is-primary', onclick: onCalculate, 'Calcular'
  ]


calculatorResults = ({results, fields}) ->
  if results.error
    notification type: 'danger', title: 'Erro',
      m 'p', 'Verifique os valores preenchidos.'

  else
    notification type: 'primary', title: 'Resultados',
      m '.columns',
        for name, value of results
          field = fields[name]
          m '.column.has-text-centered', [
            m 'p.heading', field.label
            m 'p.title', formatNumber value, field.type, annotated: true
          ]
