class User < ActiveRecord::Base
  include Clearance::User

  structure do
    email              :string
    encrypted_password :string, :limit => 128
    confirmation_token :string, :limit => 128
    remember_token     :string, :limit => 128
    timestamps
  end
end

