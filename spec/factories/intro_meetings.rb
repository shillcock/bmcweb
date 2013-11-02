# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :intro_meeting do
    title "All Hands Meeting"
    starts_at "2013-11-08 16:00:00"
    ends_at "2013-11-08 20:00:00"
    description "This is a meeting about nothing."
  end
end
