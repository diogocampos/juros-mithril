'use strict'

m = require 'mithril'

{createComponent, icon} = require './utils'


module.exports =
createComponent class Tabs

  constructor: ({initial}) ->
    @active = initial

  handleClick: (id) -> (event) =>
    @active = id

  render: ({tabs}) ->
    m '', [

      m '.header.is-centered.has-shadow', m '.container',
        m '.header-left', style: {'font-size': '18px'},
          for id, attrs of tabs
            m 'a.header-tab',
              class: if id is @active then 'is-active'
              onclick: @handleClick id
              [
                m 'span.icon', icon attrs.icon
                ' '
                attrs.title
              ]

      m '.section', m '.container',
        m '.columns',
          m '.column.is-half.is-offset-quarter', key: @active,
            tabs[@active].children
    ]
