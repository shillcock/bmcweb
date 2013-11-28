FactoryGirl.define do
  factory :intro_meeting_registration do
    first_name "Jon"
    last_name "Snow"
    email "jonsnow@example.com"
    association :intro_meeting
  end
end
