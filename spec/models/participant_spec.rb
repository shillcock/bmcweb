describe Participant, :type => :model do
  let(:user) { create(:user) }
  let(:workshop) { create(:workshop) }
  let(:participant) { Participant.new(user, workshop)}

  subject { participant }

  it { is_expected.not_to be_enrolled }
  it { is_expected.not_to be_a_student }
  it { is_expected.not_to be_an_educator }
end
