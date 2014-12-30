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
describe Meeting, :type => :model do
  let(:workshop) { create(:workshop) }
  let(:meeting) { create(:meeting, workshop: workshop) }
  subject { meeting }

  it { is_expected.to belong_to(:workshop) }
end
