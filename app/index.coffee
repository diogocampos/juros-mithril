funcoes =

  juros: (v) ->
    valor = v.total - v.entrada
    iter = 0
    [min, max] = [0, 1000]
    achou = false

    while (iter++) < 1000
      juros = (min + max) / 2
      parcela = valor * juros / (1 - 1 / Math.pow(1 + juros, v.periodo))
      erro = parcela - v.parcela

      if Math.abs(erro) < 1e-9
        achou = true
        break

      if erro > 0
        max = juros
      else
        min = juros

    if achou then "#{(juros * 100).toFixed 4}%" else '?'

  parcela: (v) ->
    valor = v.total - (v.entrada or 0)
    juros = v.juros / 100
    parcela = valor * juros / (1 - 1 / Math.pow(1 + juros, v.periodo))
    "R$#{parcela.toFixed 2}"


$.each funcoes, (nome, calculo) ->
  $inputs = $("##{nome}").find 'input[type="number"]'
  $limpar = $("##{nome}-limpar")
  $calcular = $("##{nome}-calcular")
  $resultado = $("##{nome}-resultado")

  $inputs.bind 'change', ->
    $resultado.text('')

  $limpar.bind 'click', ->
    $inputs.each ->
      @value = if @name is 'entrada' then '0' else ''
    $resultado.text('')

  $calcular.bind 'click', ->
    $resultado.text('')
    valores = {}

    erro = $inputs.toArray().some (input) ->
      valor = parseFloat input.value.replace ',', '.'
      if isNaN valor
        input.focus()
        true
      else
        valores[input.name] = valor
        return

    unless erro
      resultado = calculo valores
      $resultado.text resultado.replace '.', ','
      setTimeout ->
        window.scroll 0, document.body.scrollHeight
      , 100
