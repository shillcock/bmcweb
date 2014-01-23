# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :meeting do
    date "2014-01-22"
    starts_at "2014-01-22 21:17:17"
    ends_at "2014-01-22 21:17:17"
    lesson nil
    section nil
  end
end
