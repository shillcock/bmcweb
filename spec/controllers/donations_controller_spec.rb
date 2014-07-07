require 'spec_helper'

describe DonationsController do
  before do
    Stripe.api_key = 'fake_stripe_test_key'
  end

  describe "POST 'create'" do
    it "charges credit card" do
      donation = build(:donation, id: 1, stripe_charge_id: nil)
      charge_id = "CHARGE-ID"

      card = stub("card", brand: 'visa', last4: 1234, exp_year: 15, exp_month: 2)
      charge = stub("charge", id: charge_id, card: card)
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

      post :create, donation: {
        email: donation.email,
        amount: donation.amount,
        stripe_token: donation.stripe_token
      }

      assert_redirected_to root_path
      assert_equal "Thank you for your donation.", flash[:notice]

      #assert_not_nil assigns(:donation)
      assert_equal donation.email, assigns(:donation).email
      assert_equal charge_id, assigns(:donation).stripe_charge_id
    end
  end
end
