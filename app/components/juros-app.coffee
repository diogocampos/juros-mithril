'use strict'

m = require 'mithril'

Calculator = require './calculator'
Tabs = require './tabs'

{createComponent} = require './helpers'
{getInstallment, getInterest, getTotal} = require '../utils/interest'


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
    m Tabs, {@tabs, default: 'interest'}


FIELDS =
  deposit:     type: 'currency'  , icon: 'dollar'  , label: 'Entrada'
  installment: type: 'currency'  , icon: 'dollar'  , label: 'Valor da parcela'
  interest:    type: 'percentage', icon: 'percent' , label: 'Taxa de juros'
  length:      type: 'integer'   , icon: 'calendar', label: 'Número de parcelas'
  price:       type: 'currency'  , icon: 'dollar'  , label: 'Total à vista'
  total:       type: 'currency'  , icon: 'dollar'  , label: 'Total a prazo'


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

    if isNaN installment
      error: true
    else
      installment: installment
      total: getTotal deposit, length, installment
