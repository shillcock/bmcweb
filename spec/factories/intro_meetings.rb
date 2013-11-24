FactoryGirl.define do
  factory :intro_meeting do
    date      { 1.day.from_now.to_date }
    starts_at   "19:00"
    ends_at     "21:00"

    factory :future_intro_meeting do
      date { 1.week.from_now.to_date }
    end

    factory :past_intro_meeting do
      date { 1.days.ago.to_date }
    end
  end
end
