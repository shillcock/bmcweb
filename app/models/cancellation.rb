class Cancellation
  def initialize(membership)
    @membership = membership
  end

  def process
    CancelStripeSubscription.perform_async(customer_id, subscription_id)
    @membership.update(deactivated_on: Time.zone.today, stripe_subscription_id: nil, status: "canceled")
  end

  private

    def customer_id
      @membership.user.stripe_customer_id
    end

    def subscription_id
      @membership.stripe_subscription_id
    end
end
