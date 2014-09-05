# == Schema Information
#
# Table name: payments
#
#  id                 :integer          not null, primary key
#  user_id            :integer
#  date               :date
#  stripe_invoice_id  :string(255)
#  card_last4         :string(255)
#  email_sent         :boolean
#  created_at         :datetime
#  updated_at         :datetime
#  amount_cents       :integer
#  stripe_customer_id :string(255)
#  stripe_charge_id   :string(255)
#  guid               :string(255)
#  description        :string(255)
#  paid               :boolean
#

class Payment < ActiveRecord::Base
  belongs_to :user
  monetize :amount_cents
  validates_uniqueness_of :guid
  before_save :populate_guid

  def to_param
    guid
  end

  def update_from_stripe_charge(charge)
    self.stripe_charge_id = charge.id
    self.stripe_customer_id = charge.customer
    self.stripe_invoice_id = charge.invoice
    self.date = Time.at(charge.created).to_date
    self.description = charge.description
    self.amount_cents = charge.amount
    self.paid = charge.paid
    self.card_last4 = charge.card.last4
    self.save
 end

  private

    def populate_guid
      if new_record?
        while !valid? || self.guid.nil?
          self.guid = [Date.current.year, SecureRandom.random_number(1_000_000_000).to_s(32)].join('-')
        end
      end
    end
end
