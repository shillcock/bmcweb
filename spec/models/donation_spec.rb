require 'spec_helper'

describe Donation do
  let(:donation) { build(:donation) }

  context "validations" do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
    it { should validate_presence_of :email }
    it { should validate_presence_of :amount }
    it { should validate_presence_of :number }
    it { should validate_presence_of :cvv }
    it { should validate_presence_of :expiration_date }
  end

  it { should respond_to :finished? }
  it { should_not be_persisted }

  context "#process_payment!" do
    it "finishes with a transaction_id" do
      donation.process_payment!

      expect(donation).to be_finished
      expect(donation.transaction_id).to_not be_nil
    end

    context "when all cards are declined" do
      before { FakeBraintree.decline_all_cards! }

      it "fails" do
        donation.process_payment!

        expect(donation).to_not be_finished
      end
    end

    context "when called with invalid credit card number" do
      it "fails" do
        donation.number = '1234'
        donation.process_payment!

        expect(donation).to_not be_finished
      end
    end

    context "when the sale is declined" do
      it "fails" do
        donation.amount = 3000.11
        donation.process_payment!

        expect(donation).to_not be_finished
      end
    end
  end
end
