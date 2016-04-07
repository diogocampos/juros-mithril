'use strict'


_installment = (price, interest, length) ->
  price * interest / (1 - 1 / Math.pow(1 + interest, length))


module.exports =

  getInstallment: (price, deposit, length, interest) ->
    remaining = price - deposit
    _installment remaining, interest / 100, length


  getInterest: (price, deposit, length, installment) ->
    remaining = price - deposit
    converged = false
    [lowerBound, upperBound] = [0, 1000]
    iterations = 0

    while (iterations += 1) <= 1000
      guessedInterest = (lowerBound + upperBound) / 2
      guessedInstallment = _installment remaining, guessedInterest, length
      error = guessedInstallment - installment

      if Math.abs(error) < 1e-9
        converged = true
        break

      if error > 0
        upperBound = guessedInterest
      else
        lowerBound = guessedInterest

    if converged
      guessedInterest * 100
    else
      throw new Error 'interest calculation did not converge'


  getTotal: (deposit, length, installment) ->
    deposit + (length * installment)
