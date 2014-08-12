# == Schema Information
#
# Table name: meetings
#
#  id          :integer          not null, primary key
#  starts_at   :datetime
#  ends_at     :datetime
#  created_at  :datetime
#  updated_at  :datetime
#  title       :string(255)
#  position    :integer
#  workshop_id :integer
#
# Indexes
#
#  index_meetings_on_workshop_id  (workshop_id)
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
