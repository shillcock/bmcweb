# == Schema Information
#
# Table name: donations
#
#  id                          :integer          not null, primary key
#  name                        :string(255)
#  email                       :string(255)
#  comment                     :text
#  amount_cents                :integer
#  stripe_token                :string(255)
#  stripe_charge_id            :string(255)
#  stripe_processing_fee_cents :integer
#  created_at                  :datetime
#  updated_at                  :datetime
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
