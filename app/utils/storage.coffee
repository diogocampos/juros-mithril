'use strict'


module.exports =

  storedObject: (storageKey, storage = window.localStorage) ->
    object = JSON.parse storage.getItem(storageKey) or '{}'
    save = -> try storage.setItem storageKey, JSON.stringify object

    get: (key, defaultValue) ->
      value = object[key]
      unless value?
        object[key] = value = defaultValue
      value

    assign: (source) ->
      Object.assign object, source
      save()
