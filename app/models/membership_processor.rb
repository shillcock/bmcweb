class MembershipProcessor
  def initialize(user)
    @user = user
  end

  def join(params)
    @token = params[:stripe_token]
    @amount = params[:amount]
    @interval = params[:interval]

    rescue_stripe_exception do
      ensure_customer_exists
      create_or_update_membership
      create_subscription
    end
  end

  def update(params)
    @token = params[:stripe_token]

    membership.update(params)
    update_subscription
  end

  def cancel
    membership.update(deactivated_on: Time.zone.now)
    subscription.delete
    true
  end

  private
    def rescue_stripe_exception
      yield
      true
    rescue Stripe::CardError => e
      body = e.json_body
      err = body[:err]
      membership.errors.add(:base, err[:message])
      false
    rescue Stripe::StripeError => e
      membership.errors.add(:base, "There was a problem processing your credit card, " + e.message.downcase)
      false
    end

    def create_or_update_membership
      if @user.alumni_membership.present?
        membership.update(amount: @amount, interval: @interval)
      else
        create_membership
      end
    end

    def create_membership
      new_membership = @user.create_alumni_membership(
        amount: @amount,
        interval: @interval
      )
    end

    def create_subscription
      params = {
        plan: membership.plan,
        quantity: membership.amount,
         metadata: {
          current_user_id: current_user.id,
          alumni_membership_id: membership.id
        }
      }

      params[:card] = @token if @token

      new_subscription = customer.subscriptions.create(parmas)
      membership.update(stripe_subscription_id: new_subscription.id)
    end

    def ensure_customer_exists
      unless customer_exists?
        create_customer
      end
    end

    def customer_exists?
      @user.stripe_customer_id.present?
    end

    def create_customer
      new_customer = Stripe::Customer.create(customer_attributes)
      @user.update(stripe_customer_id: new_customer.id)
    end

    def customer_attributes
      {
        card: @token,
        email: @user.email,
        description: @user.name,
        metadata: {
          current_user_id: current_user.id
        }
      }
    end

    def update_subscription
      subscription.card = @token if @token
      subscription.plan = membership.plan
      subscription.quantity = membership.amount
      subscription.save
    end

    def membership
      @alumni_membership ||= @user.alumni_membership
    end

    def subscription
      @stripe_subscription ||= stripe_customer.subscriptions.retrieve(membership.stripe_subscription_id)
    end

    def customer
      @stirpe_customer ||= Stripe::Customer.retrieve(@user.stripe_customer_id)
    end
end
