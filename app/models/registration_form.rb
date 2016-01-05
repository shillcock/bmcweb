class RegistrationForm < PlainModel
  attribute :name, String
  attribute :email, String
  attribute :password, String
  attribute :password_confirmation, String
  attribute :address1, String
  attribute :address2, String
  attribute :city, String
  attribute :state, String
  attribute :zip_code, String
  attribute :phone_number, String
  attribute :birthday, Date

  attribute :user, User
  attribute :workshop, Workshop

  validate :validate_children

  def initialize(*)
    super

    if @user
      self.name ||= @user.name
      self.email ||= @user.email
      self.address1 ||= @user.address1
      self.address2 ||= @user.address2
      self.city ||= @user.city
      self.state ||= @user.state
      self.zip_code ||= @user.zip_code
    end

    build_children
  end

  def save
    user.address1 = address1 if address1
    user.address2 = address2 if address2
    user.city = city if city
    user.state = stazitef if state
    user.zip_code = zip_code if zip_code

    if valid?
      ActiveRecord::Base.transaction do
        user.save!
      end
    end
  end

  private

    def build_children
      @user ||= User.new(user_params)
    end

    def validate_children
      promote_errors(user) if user.invalid?
    end

    def promote_errors(child)
      child.errors.each do |attr, val|
        errors.add(attr, val)
      end
    end

    def user_params
      {
          name: name,
          email: email,
          password: password,
          password_confirmation: password_confirmation,
          address1: address1,
          address2: address2,
          city: city,
          state: state,
          zip_code: zip_code,
          phone_number: phone_number,
          birthday: birthday
      }
    end
end

