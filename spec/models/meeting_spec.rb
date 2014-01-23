# == Schema Information
#
# Table name: meetings
#
#  id         :integer          not null, primary key
#  date       :date
#  starts_at  :time
#  ends_at    :time
#  lesson_id  :integer
#  section_id :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Meeting do
  pending "add some examples to (or delete) #{__FILE__}"
end
