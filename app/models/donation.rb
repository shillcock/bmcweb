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

class Donation < ActiveRecord::Base
  monetize :amount_cents, numericality: { greater_than: 0 }
  monetize :stripe_processing_fee_cents, allow: nil, numericality: { greater_than_or_equal_to: 0 }
  validates :email, presence: true, format: { with: %r{.+@.+\..+} }
  validates :amount_cents, presence: true, numericality: { greater_than: 0 }
end
