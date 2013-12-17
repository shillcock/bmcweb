require 'spec_helper'

describe Donation do
  let(:donation) { build(:donation) }
  subject { donation }

  context "validations" do
    include MoneyRails::TestHelpers

    it { should validate_presence_of :email }
    it { should validate_presence_of :amount_cents }
    it { should monetize(:amount) }
    it { should monetize(:stripe_processing_fee) }
    it { should be_valid }
  end
end
