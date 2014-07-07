class CancelStripeSubscription
  include Sidekiq::Worker

  def perform(customer_id, subscription_id)
    find_customer(customer_id)
    cancel_subscription(subscription_id)
  end

  private
    def find_customer(customer_id)
      @customer = Stripe::Customer.retrieve(customer_id)
    end

    def cancel_subscription(subscription_id)
      subscription = @customer.subscriptions.retrieve(subscription_id)
      subscription.delete
    end
end
