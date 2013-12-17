class DonationProcessor
  def initialize(donation)
    @donation = donation
  end

  def process
    rescue_stripe_exception do
      charge_card!
    end
  end

  private
    def rescue_stripe_exception
      yield
      true
    rescue Stripe::CardError => e
      body = e.json_body
      err = body[:err]
      @donation.errors.add(:base, err[:message])
      false
    rescue Stripe::StripeError => e
      @donation.errors.add(:base, "There was a problem processing your credit card, " + e.message.downcase)
      false
    end

    def charge_card!
      charge = Stripe::Charge.create(
        currency: 'usd',
        amount: @donation.amount_cents,
        card: @donation.stripe_token,
        description: "Donation from #{@donation.email}",
        metadata: {
          name: @donation.name,
          email: @donation.email,
          comment: @donation.comment
        }
      )
      @donation.stripe_charge_id = charge.id
      @donation.stripe_processing_fee_cents = stripe_fee(charge)
      @donation.save!
    end

    def stripe_fee(charge)
      Stripe::BalanceTransaction.retrieve(charge.balance_transaction).fee
    end
end
