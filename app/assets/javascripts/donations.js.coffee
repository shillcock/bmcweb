jQuery ->
  Stripe.setPublishableKey($("#donation").data('stripe-key'))
  donation.setupForm()

  $("#donation_amount_slider").slider
    range: "min"
    animate: "fast"
    value: 100
    min: 10
    max: 1000
    slide: (event, ui) ->
      $("#donation_amount").val("$" + ui.value)
  $("#donation_amount").val("$" + $("#donation_amount_slider").slider("value"))

donation =
  setupForm: ->
    $("#donation_cc_number").payment "formatCardNumber"
    $("#donation_cc_cvc").payment "formatCardCVC"
    $("#donation_cc_number").keyup (event) ->
      number = $("#donation_cc_number").val()
      cardType = $.payment.cardType(number)
      img = $("#cc_image")[0]
      img.src = donation.cardTypeImage(cardType)
    $("#stripe_error").hide()
    $('#donation_form').submit ->
      $('#submit_button').attr('disabled', true)
      donation.processCard() if donation.isValid()
      false

  isValid: ->
    valid = true
    $('.donation_cc_number label').removeClass('error')
    $('.donation_cc_cvc label').removeClass('error')
    unless $.payment.validateCardNumber($('#donation_cc_number').val())
      $('.donation_cc_number label').addClass('error')
      valid = false
    unless $.payment.validateCardCVC($('#donation_cc_cvc').val())
      $('.donation_cc_cvc label').addClass('error')
      valid = false
    if valid
      true
    else
      $("#stripe_error").text("Your credit card information is not valid.")
      $("#stripe_error").show()
      $('#submit_button').attr('disabled', false)
      false

  processCard: ->
    card =
      number: $("#donation_cc_number").val()
      cvc: $("#donation_cc_cvc").val()
      exp_month: $("#donation_cc_expiration_2i").val()
      exp_year: $("#donation_cc_expiration_1i").val()
    Stripe.createToken(card, donation.handleStripeResonse)
    false

  handleStripeResonse: (status, response) ->
    if status == 200
      amount = $('#donation_amount').val() || "75"
      $('#donation_amount').val(amount)
      $form = $("#donation_form")
      # $form.append $('<input type="hidden" name="donation[last4]" />').val(response.card.last4)
      console.log("token: " + response.id)
      $form.append $('<input type="hidden" name="donation[stripe_token]" />').val(response.id)
      $form.get(0).submit()
    else
      console.log(response.error.message)
      $("#stripe_error").text(response.error.message)
      $("#stripe_error").show()
      $("#submit_button").attr('disabled', false)

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
