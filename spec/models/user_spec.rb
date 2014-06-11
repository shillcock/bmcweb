# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(128)
#  confirmation_token :string(128)
#  remember_token     :string(128)
#  admin              :boolean          default(FALSE)
#

require 'spec_helper'

describe User do
  let(:user) { create(:user) }
  subject { user }

  it { should have_one(:profile) }

  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }

  context "#full_name" do
    it "has a first_null that is the first and last names combined" do
      expect(user.full_name).to eq "#{user.first_name} #{user.last_name}"
    end
  end
end
