'use strict'

m = require 'mithril'

Calculator = require './calculator'
Tabs = require './tabs'
{createComponent} = require './utils'


module.exports =
createComponent class JurosApp

  constructor: ->
    @tabs =
      interest:
        title: 'Juros'
        icon: 'percent'
        children: m InterestCalculator

      installment:
        title: 'Parcela'
        icon: 'dollar'
        children: m InstallmentCalculator

  render: ->
    m Tabs, tabs: @tabs, initial: 'interest'


FIELDS =
  installment: type: 'currency'   , label: 'Valor da parcela'
  interest:    type: 'percentage' , label: 'Taxa de juros'
  length:      type: 'integer'    , label: 'Quantidade de parcelas'
  price:       type: 'currency'   , label: 'Preço à vista'
  total:       type: 'currency'   , label: 'Total a prazo'
  deposit:     type: 'currency'   , label: 'Entrada'


InterestCalculator = m.component Calculator,
  fields: FIELDS
  inputs: ['price', 'deposit', 'length', 'installment']
  calculate: -> interest: 0, total: 0


InstallmentCalculator = m.component Calculator,
  fields: FIELDS
  inputs: ['price', 'deposit', 'length', 'interest']
  calculate: -> installment: 0, total: 0
