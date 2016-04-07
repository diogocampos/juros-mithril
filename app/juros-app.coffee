'use strict'

m = require 'mithril'

Tabs = require './tabs'
{createComponent} = require './utils'


module.exports =
createComponent class JurosApp

  constructor: ->
    @tabs =
      interest:
        title: 'Juros'
        icon: 'percent'
        children: m ''

      installment:
        title: 'Parcela'
        icon: 'dollar'
        children: m ''

  render: ->
    m Tabs, tabs: @tabs, initial: 'interest'
