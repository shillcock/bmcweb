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

require 'spec_helper'

describe Donation do
  let(:donation) { build(:donation) }
  subject { donation }

  context "validations" do
    include MoneyRails::TestHelpers

    it { should validate_presence_of :email }
    it { should validate_presence_of :amount_cents }
    it { should monetize(:amount_cents) }
    it { should be_valid }
  end
end
