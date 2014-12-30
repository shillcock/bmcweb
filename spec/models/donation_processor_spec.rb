describe DonationProcessor, :type => :model do
  before do
    Stripe.api_key = 'fake_stripe_test_key'
  end

  context '#process' do
    it 'charges the donors card the amount of donation' do
      donation = build(:donation, id: 1, stripe_charge_id: nil)
      charge_id = "CHARGE-ID"

      card = double("card", brand: "visa", last4: 1234, exp_year: 15, exp_month: 2)
      charge = double("charge", id: charge_id, card: card)
      Stripe::Charge.expects(:create).
        with(
          currency: 'usd',
          amount: donation.amount_cents,
          card: donation.stripe_token,
          description: "Donation from #{donation.email}",
          metadata: {
            donation_id: donation.id
          }
        ).returns(charge)

      processor = DonationProcessor.new(donation)
      result = processor.process

      expect(result).to be_truthy
      expect(donation.stripe_charge_id).to eq(charge_id)
    end

    # it 'expects an error message when processing a bad card' do
    #   donation = build(:donation)

    #   Stripe::Charge.stubs(:create).raises(Stripe::CardError) #, 'An error occurred while processing the card.')

    #   processor = DonationProcessor.new(donation)
    #   result = processor.process

    #   expect(result).to be_falsey
    #   donation.errors[:base].should include('An error occurred while processing the card.')
    # end

    it 'expects an error message when card is declined' do
      donation = build(:donation)

      Stripe::Charge.stubs(:create).raises(Stripe::StripeError, 'Your card was declined')

      processor = DonationProcessor.new(donation)
      result = processor.process

      expect(result).to be_falsey
      expect(donation.errors[:base]).to include('There was a problem processing your credit card, your card was declined')
    end
  end
end

