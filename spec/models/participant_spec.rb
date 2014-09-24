require 'spec_helper'

describe Participant do
  let(:user) { create(:user) }
  let(:workshop) { create(:workshop) }
  let(:participant) { Participant.new(user, workshop)}

  subject { participant }

  it { should_not be_enrolled }
  it { should_not be_a_student }
  it { should_not be_an_educator }
end
