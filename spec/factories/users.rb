FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@example.com"
  end

  sequence :name do |n|
    "name #{n}"
  end

  factory :user do
    email
    password 'password'

    factory :admin do
      admin true
    end
  end
end
