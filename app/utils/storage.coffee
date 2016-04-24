'use strict'


module.exports = $ =

  storedObject: (storageKey, options = {}) ->
    object = $.storedValue storageKey, Object.assign options, default: {}

    get: (key, defaultValue) ->
      value = object()[key]
      unless value?
        object()[key] = value = defaultValue
      value

    assign: (source) ->
      object Object.assign object(), source


  storedValue: (storageKey, {default: defaultValue, storage = localStorage}) ->
    value = if (json = storage.getItem storageKey) \
      then JSON.parse json
      else defaultValue

    getterSetter = (newValue) ->
      if arguments.length
        value = newValue
        try storage.setItem storageKey, JSON.stringify value
      value

    Object.assign getterSetter,
      get: -> getterSetter()
      set: (newValue) -> getterSetter newValue
