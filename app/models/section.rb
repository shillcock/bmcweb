# == Schema Information
#
# Table name: sections
#
#  id          :integer          not null, primary key
#  workshop_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Section < ActiveRecord::Base
  belongs_to :workshop
  has_many :meetings
  has_many :lessons, through: :meetings

  def start_date
    (meetings.empty? ? Time.zone.now : meetings.first.starts_at).to_date
  end
end

# SPRING EQUINOX   March     20, 12:57 P.M. EDT
# SUMMER SOLSTICE  June      21,  6:51 A.M. EDT
# FALL EQUINOX     September 22, 10:29 P.M. EDT
# WINTER SOLSTICE  December  21,  6:03 P.M. EST
