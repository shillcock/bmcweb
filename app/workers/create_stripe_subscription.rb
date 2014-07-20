class CreateStripeSubscription
  include Sidekiq::Worker

  def perform(alumni_id)
    ActiveRecord::Base.connection_pool.with_connection do
      find_alumni(alumni_id)
      return if subscription_exists?
      create_subscription
      update_alumni
    end
  end

  private
    def find_alumni(alumni_id)
      @alumni = AlumniMembership.find(alumni_id)
      @user = @alumni.user
    end

    def subscription_exists?
      @alumni.stripe_subscription_id.present?
    end

    def customer_exists?
      @user.stripe_customer_id.present?
    end

    def update_alumni
      @alumni.update(
        stripe_subscription_id: @subscription.id,
        status: @subscription.status,
        deactivated_on: nil,
        stripe_token: nil
      )
    end

    def customer
      ensure_customer_exists
      @customer ||= retrieve_customer
    end

    def ensure_customer_exists
      unless customer_exists?
        CreateStripeCustomer.new.perform(@user.id)
        @user = @alumni.user(true) # reload user to reflect updates
      end
    end

    def retrieve_customer
      Stripe::Customer.retrieve(@user.stripe_customer_id)
    end

    def create_subscription
      @subscription = customer.subscriptions.create(subscription_attributes)
    end

    def subscription_attributes
      sub_attr = {
        plan: @alumni.plan,
        quantity: @alumni.amount,
         metadata: {
          alumni_membership_id: @alumni.id
        }
      }
      sub_attr[:card] = @alumni.stripe_token if @alumni.stripe_token.present?
      sub_attr
    end
end
