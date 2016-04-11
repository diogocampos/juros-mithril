'use strict'

m = require 'mithril'

{createComponent, icon} = require './helpers'


module.exports =
createComponent class Tabs

  constructor: ({initial}) ->
    @active = initial

  handleClick: (id) -> (event) =>
    @active = id


  render: ({tabs}) ->
    m '', [

      m '.hero.is-primary', m '.hero-header',
        m '.header.is-centered', m '.container',
          m '.header-left',
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
