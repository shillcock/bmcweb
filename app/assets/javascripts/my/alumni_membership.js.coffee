jQuery ->
  try membershipCheckout = StripeCheckout.configure(
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
  catch error then console.log "Skipping StripeCheckout"

  $("#alumni_membership_form").submit ->
    amount = $('#alumni_membership_amount').val()
    if membershipCheckout
      membershipCheckout.open
        amount: amount * 100 * billingCycleFactor()
        email: $("#alumni_membership").data('user-email')
        description: "#{alumniLevel(amount)} Level (#{billingCycleInterval()})"
    else
      amount = $("#alumni_membership_amount").val() * billingCycleFactor()
      interval = billingCycleInterval()
      $form = $("#alumni_membership_form")
      $form.append $('<input type="hidden" name="alumni_membership[amount]" />').val(amount)
      $form.append $('<input type="hidden" name="alumni_membership[interval]" />').val(interval)
      $form.get(0).submit()
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

  $("#awesome-level a").on "click", ->
    updateLevel(25)
  $("#fantastic-level a").on "click", ->
    updateLevel(50)
  $("#magnificent-level a").on "click", ->
    updateLevel(100)
  $("#wild-and-wooly-level a").on "click", ->
    updateLevel(200)

  updateJoinButton($('#alumni_membership_amount').val())

updateLevel = (value) ->
  $("#alumni_membership_amount").val(value)
  $("#alumni_membership_amount_slider").slider("value", value)
  updateJoinButton(value)


billingCycleInterval = ->
  if $("#billing_cycle_monthly").prop("checked")
   $("#billing_cycle_monthly").val()
  else
   $("#billing_cycle_yearly").val()

billingCycleFactor = ->
  if $("#billing_cycle_monthly").prop("checked") then 1 else 12

updateJoinButton = (val) ->
  level = alumniLevel(val)
  updateActiveLevel(level)
  adjustedVal = val * billingCycleFactor()
  $('#submit_button').attr('disabled', if val and val > 9 then false else true)
  $("#submit_button").val("Set Membership to #{level} Level of $#{adjustedVal} a #{billingCycleInterval()}")

updateActiveLevel = (level) ->
  $("#awesome-level a").toggleClass("active", level == "Awesome")
  $("#fantastic-level a").toggleClass("active", level == "Fantastic")
  $("#magnificent-level a").toggleClass("active", level == "Magnificent")
  $("#wild-and-wooly-level a").toggleClass("active", level == "Wild and Wooly")

alumniLevel = (amount) ->
  if amount <= 40
    "Awesome"
  else if amount <= 90
    "Fantastic"
  else if amount <= 175
    "Magnificent"
  else
    "Wild and Wooly"
