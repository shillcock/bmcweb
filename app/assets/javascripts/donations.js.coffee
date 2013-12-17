jQuery ->
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
  donation.setupForm()

donation =
  setupForm: ->
    $("#card-number").payment "formatCardNumber"
    $("#card-cvc").payment "formatCardCVC"
    $("#card-expiry").payment "formatCardExpiry"
    $("#card-number").keyup (event) ->
      number = $("#card-number").val()
      cardType = $.payment.cardType(number)
      img = $("#card-image")[0]
      img.src = donation.cardTypeImage(cardType)
    $("#stripe-error").hide()
    $('#donation-form').submit ->
      $('#submit-button').attr('disabled', true)
      donation.processCard() if donation.isValid()
      false

  isValid: ->
    valid = true
    if not $.payment.validateCardNumber($('#card-number').val())
      $('#card-number').toggleClass('invalid')
      valid = false
    if not $.payment.validateCardCVC($('#card-cvc').val())
      $('#card-cvc').toggleClass('invalid')
      valid = false
    if valid
      true
    else
      $('#submit-button').attr('disabled', false)
      false

  processCard: ->
    card =
      number: $("#card-number").val()
      cvc: $("#card-cvc").val()
      exp_month: $("#card-month").val()
      exp_year: $("#card-year").val()
    Stripe.createToken(card, donation.handleStripeResonse)
    false

  handleStripeResonse: (status, response) ->
    if status == 200
      amount = $('#donation_amount').val() || "75"
      $('#donation_amount').val(amount)
      $form = $("#donation-form")
      # $form.append $('<input type="hidden" name="donation[last4]" />').val(response.card.last4)
      $form.append $('<input type="hidden" name="donation[stripe_token]" />').val(response.id)
      $form.get(0).submit()
    else
      console.log(response.error.message)
      $("#stripe-error").text(response.error.message)
      $("#stripe-error").show()
      $("#submit-button").attr('disabled', false)

  cardTypeImage: (cardType) ->
    if cardType is "visa"
      "/assets/creditcards/visa.png"
    else if cardType is "mastercard"
      "/assets/creditcards/mastercard.png"
    else if cardType is "discover"
      "/assets/creditcards/discover.png"
    else if cardType is "amex"
      "/assets/creditcards/amex.png"
    else if cardType is "dinersclub"
      "/assets/creditcards/diners.png"
    else if cardType is "maestro"
      "/assets/creditcards/maestro.png"
    else if cardType is "laser"
      "/assets/creditcards/laser.png"
    else
      "/assets/creditcards/credit.png"
