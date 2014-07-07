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
      @donation.save!
      charge = Stripe::Charge.create(
        currency: 'usd',
        amount: @donation.amount_cents,
        card: @donation.stripe_token,
        description: "Donation from #{@donation.email}",
        metadata: {
          donation_id: @donation.id
        }
      )
      update_with_stripe_data(charge)
    end

    def update_with_stripe_data(charge)
      @donation.update(
        stripe_charge_id: charge.id,
        card_type: charge.card.brand,
        card_last4: charge.card.last4,
        card_expiration: Date.new(charge.card.exp_year, charge.card.exp_month, 1)
      )
    end
end
