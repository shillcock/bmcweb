jQuery ->
  donationCheckout = StripeCheckout.configure(
    key: $("#donation").data('stripe-key')
    name: "BMC"
    description: "Thank you :)"
    panelLabel: "Donate"
    token: (token, args) ->
      amount = $("#donation_amount").val()
      $form = $("#donation_form")
      $form.append $('<input type="hidden" name="donation[amount]" />').val(amount)
      $form.append $('<input type="hidden" name="donation[email]" />').val(token.email)
      $form.append $('<input type="hidden" name="donation[stripe_token]" />').val(token.id)
      $form.get(0).submit()
  )

  $("#donation_form").submit ->
    donationCheckout.open(amount: $('#donation_amount').val() * 100)
    false

  $("#donation_amount_slider").slider
    range: "min"
    animate: "fast"
    value: 100
    min: 10
    max: 1000
    slide: (event, ui) ->
      $("#donation_amount").val(ui.value)
      updateDonateButton(ui.value)

  $("#donation_amount").bind "input", ->
    val = $(@).val()
    $("#donation_amount_slider").slider("value", val)
    updateDonateButton(val)

  $("#donation_amount").val($("#donation_amount_slider").slider("value"))

updateDonateButton = (val) ->
  $('#submit_button').attr('disabled', if val and val > 0 then false else true)
  $("#submit_button").val("I would like to donate $#{val || 100} to the Breakthrough Men's Community")
