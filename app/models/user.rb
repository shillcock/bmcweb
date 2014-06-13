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

  has_one :profile, dependent: :destroy

  validates :name, presence: true

  def first_name
    name.split(" " ).first
  end

  def last_name
    name.split(" " ).last
  end

  private

    # def stripe_customer
    #   if stripe_customer_id.present?
    #     Stripe::Customer.retrieve(stripe_customer_id)
    #   end
    # end
end
