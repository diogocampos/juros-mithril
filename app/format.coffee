'use strict'


Format =
  currency:   prefix: 'R$' , fixed: 2 , suffix: ''
  integer:    prefix: ''   , fixed: 0 , suffix: ''
  percentage: prefix: ''   , fixed: 2 , suffix: '%'


module.exports =

  formatNumber: (number, type, {annotated} = {}) ->
    format = Format[type] or {}
    [
      if annotated then format.prefix
      number.toFixed format.fixed
      if annotated then format.suffix
    ].join ''
