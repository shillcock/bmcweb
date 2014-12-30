# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if User.count == 0
  user = User.create name: "System Admin", email: "admin@bmc.link", password: ENV["BASIC_AUTH_PASSWORD"], admin: true
end

Faker::Config.locale = "en-US"
def fake_user_params
  first_name = Faker::Name.first_name
  {
    name: "#{first_name} #{Faker::Name.last_name}",
    email: Faker::Internet.email(first_name),
    password: 'test1234', #Faker::Internet.password(12),
    phone_number: Faker::PhoneNumber.cell_phone,
    address1: Faker::Address.street_address,
    city: Faker::Address.city,
    state: "California",
    zip_code: Faker::Address.zip,
    birthday: "0001-#{rand(1..12)}-#{rand(1..31)}}"
  }
end

15.times do
  user = User.new(fake_user_params)
  if user.save
    CreateStripeCustomer.perform_async(user.id)
  end
end

