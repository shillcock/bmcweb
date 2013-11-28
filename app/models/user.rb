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

class User < ActiveRecord::Base
  include Clearance::User
end

