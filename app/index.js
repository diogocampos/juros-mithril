var funcoes = {

  juros: function (v) {
    var valor = v.total - v.entrada;
    var iter = 0, min = 0, max = 1000;
    var juros, parcela, erro;
    var achou = false;

    while ((iter++) < 1000) {
      juros = (min + max) / 2;
      parcela = valor * juros / (1 - 1 / Math.pow(1 + juros, v.periodo));
      erro = parcela - v.parcela;

      if (Math.abs(erro) < 1e-9) {
        achou = true;
        break;
      }
      if (erro > 0) {
        max = juros;
      }
      else {
        min = juros;
      }
    }
    return (achou) ? (juros * 100).toFixed(4) + '%' : '?';
  },

  parcela: function (v) {
    var valor = v.total - (v.entrada || 0);
    var juros = v.juros / 100;
    var parcela = valor * juros / (1 - 1 / Math.pow(1 + juros, v.periodo));
    return 'R$' + parcela.toFixed(2);
  }

};

$.each(funcoes, function (nome, calculo) {

  var body = $('body')[0];
  var $inputs = $('#'+nome).find('input[type="number"]');
  var $limpar = $('#'+nome+'-limpar');
  var $calcular = $('#'+nome+'-calcular');
  var $resultado = $('#'+nome+'-resultado');

  $inputs.bind('change', function () {
    $resultado.text('');
  });

  $limpar.bind('click', function () {
    $inputs.each(function () {
      this.value = (this.name === 'entrada') ? '0' : '';
    });
    $resultado.text('');
  });

  $calcular.bind('click', function () {
    $resultado.text('');
    var valores = {};

    var erro = $inputs.toArray().some(function (input) {
      var valor = parseFloat(input.value.replace(',', '.'));
      if (isNaN(valor)) {
        input.focus();
        return true;
      }
      else {
        valores[input.name] = valor;
      }
    });

    if (!erro) {
      var resultado = calculo(valores);
      $resultado.text(resultado.replace('.', ','));
      setTimeout(function () {
        scroll(0, body.scrollHeight);
      }, 100);
    }
  });

});
