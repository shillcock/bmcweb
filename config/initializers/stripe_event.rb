StripeEvent.event_retriever = lambda do |params|
  return nil if StripeWebhook.exists?(stripe_id: params[:id])
  StripeWebhook.create!(stripe_id: params[:id])
  Stripe::Event.retrieve(params[:id])
end

StripeEvent.configure do |events|
  events.subscribe 'charge.dispute.created' do |event|
    # AccountMailer.admin_dispute_created(event.data.object).deliver
  end

  events.subscribe 'charge.succeeded' do |event|
    charge = event.data.object
    if user = User.find_by(stripe_customer_id: charge.customer)
      payment = user.payments.find_or_create_by(stripe_charge_id: charge.id)
      payment.update_from_stripe_charge(charge)
    end
  end

  events.subscribe 'invoice.payment.failed' do |event|
    invoice = event.data.object
    if user = User.find_by(stripe_customer_id: invoice.customer)
      # AccountMailer.payment_failed(user, invoice)
    end
  end

  events.subscribe 'customer.updated' do |event|
    customer = event.data.object
    if user = User.find_by(stripe_customer_id: customer.id)
      card = customer.cards.retrieve(customer.default_card)
      user.update_from_stripe_card(card)
    end
  end

  events.subscribe 'customer.subscription.deleted' do |event|
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

  events.subscribe 'customer.deleted' do |event|
    customer = event.data.object
    if user = User.find_by(stripe_customer_id: customer.id)
      user.update(stripe_customer_id: nil)
    end
  end
end


