# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(128)
#  confirmation_token :string(128)
#  remember_token     :string(128)
#  admin              :boolean          default(FALSE)
#

class User < ActiveRecord::Base
  include Clearance::User

  has_one :alumni_membership, dependent: :destroy

  validates :name, presence: true

  # after_save :create_stripe_customer
  # before_destroy :delete_stripe_customer

  def first_name
    name.split(" ").first
  end

  def last_name
    name.split(" ").last
  end

  def alumni?
    alumni_membership.present? and alumni_membership.active?
  end

  private

    # def create_stripe_customer
    #  CreateStripeCustomer.perform_async(self.id)
    # end

    # def delete_stripe_customer
    #  DeleteStripeCustomer.perform_async(stripe_customer_id) if stripe_customer_id.present?
    # end
end
