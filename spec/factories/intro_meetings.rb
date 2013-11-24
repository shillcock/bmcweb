# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :intro_meeting do
    title       "All Hands Meeting"
    date      { 1.day.from_now.to_date }
    starts_at   "19:00"
    ends_at     "21:00"
    description "This is a meeting about nothing."

    factory :future_intro_meeting do
      date { 1.week.from_now.to_date }
    end

    factory :past_intro_meeting do
      date { 1.days.ago.to_date }
    end
  end
end
