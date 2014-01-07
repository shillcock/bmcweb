class Donation < ActiveRecord::Base
  monetize :amount_cents, numericality: { greater_than: 0 }
  monetize :stripe_processing_fee_cents, allow: nil, numericality: { greater_than_or_equal_to: 0 }
  validates :email, presence: true, format: { with: %r{.+@.+\..+} }
  validates :amount_cents, presence: true, numericality: { greater_than: 0 }
end
