StripeEvent.setup do
  subscribe 'customer.subscription.deleted' do |event|
    subscription = event.data.object

    if user = User.find_by(stripe_customer_id: subscription.customer)
      # UserSubscription.new(user, subscription).subscription_deleted
      user.alumni_membership.update(
        deactivated_on: Time.zone.today,
        stripe_subscription_id: nil,
        status: "canceled")
    end
  end

  subscribe 'invoice.payment_failed' do |event|
    invoice = event.data.object

    if user = User.find_by(stripe_customer_id: invoice.customer)
      # InviocePayment.new(user, invoice).payment_failed
    end
  end

  subscribe 'invoice.payment_succeeded' do |event|
    invoice = event.data.object

    if user = User.find_by(stripe_customer_id: invoice.customer)
      # UserPayment.new(user, invoice).payment_succeeded
    end
  end
end
