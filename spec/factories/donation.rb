FactoryGirl.define do
  factory :donation do
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    email Faker::Internet.email
    number "4111111111111111"
    expiration_date 1.month.from_now.to_date
    cvv 123
    amount 100
  end
end
