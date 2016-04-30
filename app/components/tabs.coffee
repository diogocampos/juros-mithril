'use strict'

m = require 'mithril'

{createComponent, icon} = require './helpers'
{storedValue} = require '../utils/storage'


module.exports =
createComponent class Tabs

  constructor: ({tabs, default: defaultTab}) ->
    @activeTab = storedValue 'activeTab', default: defaultTab

    @handleClick = {}
    for id of tabs
      @handleClick[id] = do (id = id) =>
        (event) => @activeTab id


  render: ({tabs}) ->
    activeTab = @activeTab()
    style = if navigator.standalone then 'padding-top': '20px' else {}

    m '', [
      m '.hero.is-primary', {style}, m '.hero-header',
        m '.header.is-centered', m '.container',
          m '.header-left',
            for id, attrs of tabs
              m 'a.header-tab',
                class: if id is activeTab then 'is-active'
                onclick: @handleClick[id]
                [
                  m 'span.icon', icon attrs.icon
                  ' '
                  attrs.title
                ]

      m '.section', m '.container',
        m '.columns.is-centered',
          m '.column.is-half', key: activeTab,
            tabs[activeTab].children
    ]
