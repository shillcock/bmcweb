# == Schema Information
#
# Table name: lessons
#
#  id            :integer          not null, primary key
#  title         :string(255)
#  summary       :text
#  lesson_number :integer
#  workshop_id   :integer
#  created_at    :datetime
#  updated_at    :datetime
#

require 'spec_helper'

describe Lesson do
  pending "add some examples to (or delete) #{__FILE__}"
end
