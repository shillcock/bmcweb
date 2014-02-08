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
  let(:workshop) { create(:workshop) }
  let(:lesson) { create(:lesson, workshop: workshop) }
  let(:section) { create(:section, workshop: workshop) }
  let(:meeting) { create(:meeting, section: section, lesson: lesson) }
  subject { meeting }

  it { should belong_to(:section) }
  it { should belong_to(:lesson) }
end
