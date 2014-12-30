# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  email              :string(255)
#  name               :string(255)
#  phone_number       :string(255)
#  address1           :string(255)
#  address2           :string(255)
#  city               :string(255)
#  state              :string(255)
#  zip_code           :string(255)
#  birthday           :date
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(128)
#  confirmation_token :string(128)
#  remember_token     :string(128)
#  admin              :boolean          default(FALSE)
#  stripe_customer_id :string(255)
#  stripe_token       :string(255)
#  card_type          :string(255)
#  card_last4         :string(255)
#  card_expiration    :date
#
# Indexes
#
#  index_users_on_email           (email)
#  index_users_on_remember_token  (remember_token)
#
describe User, :type => :model do
  let(:user) { create(:user) }
  subject { user }

  it { is_expected.to validate_presence_of :name }

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
