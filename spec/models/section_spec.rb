# == Schema Information
#
# Table name: sections
#
#  id          :integer          not null, primary key
#  workshop_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

require 'spec_helper'

describe Section do
  let(:section) { create(:section) }
  subject { section }

  it { should belong_to(:workshop) }
  it { should have_many(:meetings) }
end
