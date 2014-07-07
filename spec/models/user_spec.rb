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

  it { should validate_presence_of :name }

  context "#first_name" do
    it "has a first_name that is the first part of name" do
      user = User.new(name: "first last")
      expect(user.first_name).to eq "first"
    end
  end

  context "#last_name" do
    it "has a last_name that is the last part of name" do
      user = User.new(name: "first last")
      expect(user.last_name).to eq "last"
    end
  end
end
