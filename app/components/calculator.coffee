'use strict'

m = require 'mithril'

NumberInput = require './number-input'

{createComponent, modal, notification} = require './helpers'
{formatNumber} = require '../utils/format'


module.exports =
createComponent class Calculator

  constructor: ({inputs, @calculate}) ->
    @inputs = {}
    @inputs[name] = m.prop 0 for name in inputs
    @results = null

  handleCalculate: ->
    values = {}
    values[name] = prop() for name, prop of @inputs
    @results = @calculate values

  handleClear: ->
    @inputs[name] 0 for name of @inputs
    @results = null

  handleClearResults: ->
    @results = null


  render: ({fields, @calculate}) ->
    m '', [

      m '.columns', m '.column',
        for name, prop of @inputs
          field = fields[name]
          m NumberInput,
            label: field.label
            type: field.type
            binding: prop

      m '.columns', m '.column',
        calculatorButtons
          onClear: @handleClear
          onCalculate: @handleCalculate

      if @results
        modal onClose: @handleClearResults,
          calculatorResults {@results, fields}
    ]


calculatorButtons = ({onClear, onCalculate}) ->
  m 'p.control.is-grouped', style: {'justify-content': 'center'}, [
    m 'button.button.is-link.is-medium', onclick: onClear, 'Limpar'
    m 'button.button.is-primary.is-medium', onclick: onCalculate, 'Calcular'
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
          m '.column.is-text-centered', [
            m 'p.heading', field.label
            m 'p.title', formatNumber value, field.type, annotated: true
          ]