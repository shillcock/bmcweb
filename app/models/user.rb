# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  email              :string(255)
#  name               :string(255)
#  phone_number       :string(255)
#  address1           :string(255)
#  address2           :string(255)
#  city               :string(255)
#  state              :string(255)
#  zip_code           :string(255)
#  birthday           :date
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(128)
#  confirmation_token :string(128)
#  remember_token     :string(128)
#  admin              :boolean          default(FALSE)
#  stripe_customer_id :string(255)
#  stripe_token       :string(255)
#  card_type          :string(255)
#  card_last4         :string(255)
#  card_expiration    :date
#
# Indexes
#
#  index_users_on_email           (email)
#  index_users_on_remember_token  (remember_token)
#

class User < ActiveRecord::Base
  include Clearance::User
  has_paper_trail

  has_one :alumni_membership, dependent: :destroy

  has_many :workshop_enrollments, dependent: :destroy
  has_many :workshops, through: :workshop_enrollments

  has_many :payments

  validates :name, presence: true
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }

  scope :students, -> { joins(:workshop_enrollments).merge(WorkshopEnrollment.students) }
  scope :educators, -> { joins(:workshop_enrollments).merge(WorkshopEnrollment.educators) }

  scope :card_expiring, -> (date) { where("card_expiration <= ?", date) }

  before_validation :populate_username

  # after_save :create_stripe_customer, on: :create
  # before_destroy :delete_stripe_customer

  def first_name
    name.split(" ").first
  end

  def last_name
    name.split(" ").slice(1..-1).join(" ")
  end

  def alumni?
    alumni_membership.present? and alumni_membership.active?
  end

  def enrolled?(workshop)
    workshops.include?(workshop) if workshop
  end

  def update_credit_card(card)
    update(
      card_type: card.brand,
      card_last4: card.last4,
      card_expiration: Date.new(card.exp_year, card.exp_month, 1)
    ) if card
  end

  private

    # def create_stripe_customer
    #  CreateStripeCustomer.perform_async(self.id)
    # end

    # def delete_stripe_customer
    #  DeleteStripeCustomer.perform_async(stripe_customer_id) if stripe_customer_id.present?
    # end

    def populate_username
      self.username ||= name.parameterize("_")
    end
end
