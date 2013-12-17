require 'spec_helper'

describe DonationProcessor do
  before do
    Stripe.api_key = 'fake_stripe_test_key'
  end

  context '#process' do
    it 'charges the donors card the amount of donation' do
      donation = build(:donation, stripe_charge_id: nil, stripe_processing_fee_cents: nil)
      charge_id = "CHARGE-ID"
      transaction_id = "TRX-ID"
      fee_cents = 247

      charge = stub("charge", id: charge_id, balance_transaction: transaction_id)
      Stripe::Charge.expects(:create).
        with(
          currency: 'usd',
          amount: donation.amount_cents,
          card: donation.stripe_token,
          description: "Donation from #{donation.email}",
          metadata: {
            name: donation.name,
            email: donation.email,
            comment: donation.comment
          }
        ).returns(charge)

      balance_transaction = stub("balance transaction", fee: fee_cents)
      Stripe::BalanceTransaction.expects(:retrieve).with(transaction_id).returns(balance_transaction)

      processor = DonationProcessor.new(donation)
      result = processor.process

      result.should be_true
      donation.stripe_charge_id.should == charge_id
      donation.stripe_processing_fee_cents.should == fee_cents
    end

    # it 'expects an error message when processing a bad card' do
    #   donation = build(:donation)

    #   Stripe::Charge.stubs(:create).raises(Stripe::CardError) #, 'An error occurred while processing the card.')

    #   processor = DonationProcessor.new(donation)
    #   result = processor.process

    #   result.should be_false
    #   donation.errors[:base].should include('An error occurred while processing the card.')
    # end

    it 'expects an error message when card is declined' do
      donation = build(:donation)

      Stripe::Charge.stubs(:create).raises(Stripe::StripeError, 'Your card was declined')

      processor = DonationProcessor.new(donation)
      result = processor.process

      result.should be_false
      donation.errors[:base].should include('There was a problem processing your credit card, your card was declined')
    end
  end
end
