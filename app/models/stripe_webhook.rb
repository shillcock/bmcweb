# == Schema Information
#
# Table name: stripe_events
#
#  id          :integer          not null, primary key
#  stripe_id   :string(255)
#  stripe_type :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class StripeWebhook < ActiveRecord::Base
  validates_uniqueness_of :stripe_id
end
