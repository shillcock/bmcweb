# == Schema Information
#
# Table name: alumni_memberships
#
#  id                     :integer          not null, primary key
#  user_id                :integer
#  stripe_subscription_id :string(255)
#  stripe_token           :string(255)
#  amount                 :integer
#  interval               :string(255)      default("month")
#  deactivated_on         :date
#  created_at             :datetime
#  updated_at             :datetime
#  status                 :string(255)      default("pending")
#
# Indexes
#
#  index_alumni_memberships_on_user_id  (user_id)
#

class AlumniMembership < ActiveRecord::Base
  belongs_to :user

  before_destroy :cancel_subscription

  #def self.active_as_of(time)
  #  where("deactivated_on is null OR deactivated_on > ?", time)
  #end

  def self.active
    where(status: "active")
  end

  def active?
    status == "active"
  end

  def plan
    "alumni_#{interval}ly"
  end

  def description
    "Alumni Association Membership"
  end

  def member_since
    created_at.strftime("%B %e, %Y")
  end

  private

    def cancel_subscription
      if stripe_customer_id and stripe_subscription_id

        CancelStripeSubscription.perform_async(
          stripe_customer_id,
          stripe_subscription_id)

        self.update(
          deactivated_on: Time.zone.today,
          stripe_subscription_id: nil,
          status: "canceled")
      end
    end

    def stripe_customer_id
      user.stripe_customer_id
    end
end
