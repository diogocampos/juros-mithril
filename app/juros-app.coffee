'use strict'

m = require 'mithril'

Calculator = require './calculator'
Tabs = require './tabs'

{getInstallment, getInterest, getTotal} = require './interest'
{createComponent} = require './utils'


module.exports =
createComponent class JurosApp

  constructor: ->
    @tabs =
      interest:
        title: 'Juros', icon: 'percent'
        children: InterestCalculator
      installment:
        title: 'Parcela', icon: 'dollar'
        children: InstallmentCalculator

  render: ->
    m Tabs, {@tabs, initial: 'interest'}


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

  calculate: ({price, deposit, length, installment}) ->
    try
      interest: getInterest price, deposit, length, installment
      total: getTotal deposit, length, installment
    catch
      error: true


InstallmentCalculator = m.component Calculator,
  fields: FIELDS
  inputs: ['price', 'deposit', 'length', 'interest']

  calculate: ({price, deposit, length, interest}) ->
    installment = getInstallment price, deposit, length, interest

    installment: installment
    total: getTotal deposit, length, installment
