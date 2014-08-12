require 'spec_helper'

describe Participant do
  before { pending }
  let(:user) { create(:user) }
  let(:section) { create(:section) }
  let(:participant) { Participant.new(user, section)}

  subject { participant }

  it { should_not be_enrolled }
  it { should_not be_a_student }
  it { should_not be_an_educator }
end
