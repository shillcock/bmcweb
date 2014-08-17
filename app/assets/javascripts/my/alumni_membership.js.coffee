jQuery ->
  membershipCheckout = StripeCheckout.configure(
    key: $("#alumni_membership").data('stripe-key')
    name: "BMC"
    description: "Thank you :)"
    panelLabel: "Join Alumni - "
    token: (token, args) ->
      amount = $("#alumni_membership_amount").val() * billingCycleFactor()
      interval = billingCycleInterval()
      $form = $("#alumni_membership_form")
      $form.append $('<input type="hidden" name="alumni_membership[amount]" />').val(amount)
      $form.append $('<input type="hidden" name="alumni_membership[email]" />').val(token.email)
      $form.append $('<input type="hidden" name="alumni_membership[interval]" />').val(interval)
      $form.append $('<input type="hidden" name="alumni_membership[stripe_token]" />').val(token.id)
      $form.get(0).submit()
  )

  $("#alumni_membership_form").submit ->
    amount = $('#alumni_membership_amount').val()
    membershipCheckout.open
      amount: amount * 100 * billingCycleFactor()
      email: $("#alumni_membership").data('user-email')
      description: "#{alumniLevel(amount)} Level (#{billingCycleInterval()})"
    false

  $("#alumni_membership_amount_slider").slider
    range: "min"
    animate: "fast"
    value: $('#alumni_membership_amount').val()
    min: 10
    max: 250
    slide: (event, ui) ->
      $("#alumni_membership_amount").val(ui.value)
      updateJoinButton(ui.value)

  $("#billing_cycle_monthly, #billing_cycle_yearly").change ->
    updateJoinButton($('#alumni_membership_amount').val())

  $("#alumni_membership_amount").bind "input", ->
    val = $(@).val()
    $("#alumni_membership_amount_slider").slider("value", val)
    updateJoinButton(val)

  $("#alumni_membership_amount").val($("#alumni_membership_amount_slider").slider("value"))

  updateJoinButton($('#alumni_membership_amount').val())

billingCycleInterval = ->
  if $("#billing_cycle_monthly").prop("checked")
   $("#billing_cycle_monthly").val()
  else
   $("#billing_cycle_yearly").val()

billingCycleFactor = ->
  if $("#billing_cycle_monthly").prop("checked") then 1 else 12

updateJoinButton = (val) ->
  adjustedVal = val * billingCycleFactor()
  $('#submit_button').attr('disabled', if val and val > 9 then false else true)
  $("#submit_button").val("I would like to join at the #{alumniLevel(val)} Level of $#{adjustedVal} a #{billingCycleInterval()}")

alumniLevel = (amount) ->
  if amount <= 40
    "Awesome"
  else if amount <= 90
    "Fantastic"
  else if amount <= 175
    "Magnificent"
  else
    "Wild and Wooly"
