class UpdateUsersDefaultCreditCard
  include Sidekiq::Worker

  def perform(user_id, stripe_token)
    ActiveRecord::Base.connection_pool.with_connection do
      user = User.find(user_id)
      return unless user and user.stripe_customer_id.present?

      customer = Stripe::Customer.retrieve(user.stripe_customer_id)
      customer.card = stripe_token
      customer.save

      card = customer.cards.retrieve(customer.default_card)
      user.update(
        stripe_token: nil,
        card_type: card.brand,
        card_last4: card.last4,
        card_expiration: Date.new(card.exp_year, card.exp_month, 1)
      )
    end
  end
end
