require 'spec_helper'

describe DonationsController do
  before do
    Stripe.api_key = 'fake_stripe_test_key'
  end

  describe "POST 'create'" do
    it "charges credit card" do
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

      post :create, donation: {
        name: donation.name,
        email: donation.email,
        amount: donation.amount,
        comment: donation.comment,
        stripe_token: donation.stripe_token }

      assert_redirected_to root_path
      assert_equal "Thank you for your donation.", flash[:notice]

      assert_not_nil assigns(:donation)
      assert_equal donation.email, assigns(:donation).email
      assert_equal charge_id, assigns(:donation).stripe_charge_id
      assert_equal fee_cents, assigns(:donation).stripe_processing_fee_cents
    end
  end
end
