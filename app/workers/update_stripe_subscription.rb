class UpdateStripeSubscription
  include Sidekiq::Worker

  def perform(alumni_id)
    ActiveRecord::Base.connection_pool.with_connection do
      find_alumni(alumni_id)
      return unless subscription_exists?
      update_subscription
      update_alumni
      update_user
    end
  end

  private
    def find_alumni(alumni_id)
      @alumni = AlumniMembership.find(alumni_id)
    end

    def subscription_exists?
      @alumni.user.stripe_customer_id.present? && @alumni.stripe_subscription_id.present?
    end

    def update_subscription
      subscription.card = @alumni.stripe_token if @alumni.stripe_token.present?
      subscription.plan = @alumni.plan
      subscription.quantity = @alumni.amount
      subscription.save
    end

    def update_alumni
      @alumni.update(stripe_token: nil, deactivated_on: nil, status: subscription.status)
    end

    def update_user
      card = customer.cards.retrieve(customer.default_card)
      user.update(
        stripe_token: nil,
        card_type: card.brand,
        card_last4: card.last4,
        card_expiration: Date.new(card.exp_year, card.exp_month, 1)
      )
    end

    def customer
      @customer ||= Stripe::Customer.retrieve(@alumni.user.stripe_customer_id)
    end

    def subscription
      @subscription ||= customer.subscriptions.retrieve(@alumni.stripe_subscription_id)
    end
end
