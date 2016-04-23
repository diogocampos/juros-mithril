'use strict'


Format =
  currency:   prefix: 'R$' , fixed: 2 , suffix: ''
  integer:    prefix: ''   , fixed: 0 , suffix: ''
  percentage: prefix: ''   , fixed: 2 , suffix: '%'

Separator =
  DECIMAL: ','
  THOUSAND: '.'


module.exports =

  formatNumber: (number, type, {annotated} = {}) ->
    format = Format[type] or {}
    [integer, decimal] = number.toFixed(format.fixed).split '.'

    mod = integer.length % 3
    head = if mod then [integer.slice(0, mod)] else []
    tail = (integer.slice i, i + 3 for i in [mod ... integer.length] by 3)

    [
      if annotated then format.prefix
      head.concat(tail).join Separator.THOUSAND
      if decimal then Separator.DECIMAL + decimal
      if annotated then format.suffix
    ].join ''


  parseDigits: (digits, type) ->
    fixed = Format[type]?.fixed or 0
    string = digits.join ''
    len = string.length

    if len <= fixed
      integer = '0'
      decimal = '0'.repeat(fixed - len) + string
    else
      integer = string.slice 0, len - fixed
      decimal = string.slice len - fixed

    parseFloat integer + (if decimal then '.' + decimal else '')


String::repeat or= (count) ->
  Array(count + 1).join this
