class CreateStripeCustomer
  include Sidekiq::Worker

  def perform(user_id)
    ActiveRecord::Base.connection_pool.with_connection do
      find_user(user_id)
      return if customer_exists?
      create_customer
      update_user
    end
  end

  private

    def find_user(user_id)
      @user = User.find(user_id)
    end

    def update_user
      @user.update(stripe_customer_id: @customer.id, stripe_token: nil)
    end

    def customer_exists?
      @user.stripe_customer_id.present?
    end

    def create_customer
      @customer = Stripe::Customer.create(customer_attributes)
    end

    def customer_attributes
      cust_attr = {
        email: @user.email,
        description: @user.name,
        metadata: {
          user_id: @user.id
        }
      }
      cust_attr[:card] = @user.stripe_token if @user.stripe_token.present?
      cust_attr
    end
end
