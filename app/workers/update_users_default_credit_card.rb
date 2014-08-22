class UpdateUsersDefaultCreditCard
  include Sidekiq::Worker

  def perform(user_id, stripe_token = nil)
    ActiveRecord::Base.connection_pool.with_connection do
      find_user(user_id)
      return unless customer_exists?
      find_customer
      save_card(stripe_token) if stripe_token
      find_default_card
      update_user
    end
  end

  private

    def find_user(user_id)
      @user = User.find(user_id)
    end

    def customer_exists?
      @user.stripe_customer_id.present?
    end

    def find_customer
      @customer = Stripe::Customer.retrieve(@user.stripe_customer_id)
    end

    def save_card(stripe_token)
      @customer.card = stripe_token
      @customer.save
    end

    def find_default_card
      @card = @customer.cards.retrieve(@customer.default_card) if @customer.default_card
    end

    def update_user
      @user.update_credit_card(@card)
    end
end
