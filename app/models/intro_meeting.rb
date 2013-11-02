# == Schema Information
#
# Table name: intro_meetings
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text
#  starts_at   :datetime
#  ends_at     :datetime
#  created_at  :datetime
#  updated_at  :datetime
#

class IntroMeeting < ActiveRecord::Base
  validates :title, :starts_at, :ends_at, presence: true
end
