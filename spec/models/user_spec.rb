require 'spec_helper'

describe User do
  before do
    @user = User.new(
      email: Faker::Internet.email,
      password: Faker::Internet.password)
  end

  subject { @user }

  it { should respond_to(:email) }
  it { should respond_to(:encrypted_password) }
  it { should respond_to(:confirmation_token) }
  it { should respond_to(:remember_token) }
  it { should be_valid }

  describe "when password is not present" do
    before do
      @user = User.new(email: Faker::Internet.email, password: nil)
    end

    subject { @user }

    it { should_not be_valid }
  end
end
