StripeEvent.setup do
  subscribe 'customer.subscription.deleted' do |event|
    subscription = event.data.object

    if user = User.find_by(stripe_customer_id: subscription.customer)
      if user.alumni_membership
        user.alumni_membership.update(
          deactivated_on: Time.zone.today,
          stripe_subscription_id: nil,
          status: "canceled")
      end
    end
  end

  subscribe 'customer.deleted' do |event|
    customer = event.data.object

    if user = User.find_by(string_customer_id: customer.id)
      user.update(stripe_customer_id: nil)
    end
  end

  subscribe 'customer.updated' do |event|
    customer = event.data.object

    if user = User.find_by(stripe_customer_id: customer.id)
      card = customer.cards.retrieve(customer.default_card)
      user.update_credit_card(card)
    end
  end

  subscribe 'invoice.payment_failed' do |event|
    invoice = event.data.object

    if user = User.find_by(stripe_customer_id: invoice.customer)
      # AccountMailer.payment_failed(user, invoice)
    end
  end

  subscribe 'charge.succeeded' do |event|
    charge = event.data.object

    if user = User.find_by(stripe_customer_id: charge.customer)
      user.payments.find_or_create_by(stripe_charge_id: charge.id) do |payment|
        # payment.stripe_charge_id = charge.id
        payment.stripe_customer_id = charge.customer
        payment.stripe_invoice_id = charge.invoice
        payment.date = Time.at(charge.created).to_date
        payment.description = charge.description
        payment.amount_cents = charge.amount
        payment.paid = charge.paid
        payment.card_last4 = charge.card.last4
      end
    end
  end

  # subscribe 'invoice.payment_succeeded' do |event|
  #   invoice = event.data.object

  #   InvoicePaymentSucceeded.perform_async(invoice.customer, invoice.id)

  #   # if user = User.find_by(stripe_customer_id: invoice.customer)
  #   #   user.alumni_membership.payment_succeeded(invoice)
  #   # end
  # end

  subscribe 'charge.dispute.created' do |event|
    charge = event.date.object
    # AccountMailer.admin_dispute_created(charge).deliver
  end
end
