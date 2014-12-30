# == Schema Information
#
# Table name: donations
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  email            :string(255)
#  comment          :text
#  amount_cents     :integer
#  stripe_token     :string(255)
#  stripe_charge_id :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  card_type        :string(255)
#  card_last4       :string(255)
#  card_expiration  :date
#

describe Donation, :type => :model do
  let(:donation) { build(:donation) }
  subject { donation }

  context "validations" do
    include MoneyRails::TestHelpers

    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_presence_of :amount_cents }
    it { is_expected.to monetize(:amount_cents) }
    it { is_expected.to be_valid }
  end
end
