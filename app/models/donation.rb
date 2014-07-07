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
#  created_at                  :datetime
#  updated_at                  :datetime
#

class Donation < ActiveRecord::Base
  monetize :amount_cents, numericality: { greater_than: 0 }
  validates :amount_cents, presence: true, numericality: { greater_than: 0 }
  validates :email, presence: true, format: { with: %r{\A.+@.+\..+\z} }
end
