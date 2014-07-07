FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@example.com"
  end

  sequence :name do |n|
    "first#{n} last#{n}"
  end

  sequence :workshop_title do |n|
    "workshop #{n}"
  end

  sequence :lesson_title do |n|
    "lesson #{n}"
  end

  sequence :lesson_number

  factory :donation do
    email
    amount 75
    stripe_token "stripe"
    stripe_charge_id "CHARGE-ID"
  end

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

  factory :intro_meeting_registration do
    first_name "Jon"
    last_name "Snow"
    email "jonsnow@example.com"
    intro_meeting
  end

  factory :workshop do
    title { generate(:workshop_title) }
    description { "#{title} will rock your world." }

    factory :workshop_with_lessons do
      ignore do
        lesson_count 5
      end

      after(:create) do |instance, attributes|
        attributes.lesson_count.times do
          create(:lesson, workshop: instance)
        end
      end
    end
  end

  factory :lesson do
    title "Basic Assumption"
    summary "What do you really know about telling the truth."
    lesson_number
    # workshop
  end

  factory :section do
    workshop

    factory :section_with_meetings do
      after(:create) do |instance, attributes|
        attributes.workshop.lessons.each do |lesson|
          create(:meeting, section: instance, lesson: lesson)
        end
      end
    end
  end

  factory :meeting do
    ignore do
      dd 2.day.from_now.to_date
    end

    starts_at { DateTime.new(dd.year, dd.month, dd.day, 18, 30) }
    ends_at { DateTime.new(dd.year, dd.month, dd.day, 20, 30) }
    section
    lesson
  end

  factory :user do
    name
    email
    password 'password'

    phone_number "123-444-5678"
    address1 "123 My Street"
    address2 "PO Box 888"
    city "Over Here"
    state "CA"
    zip_code "98765"
    birthday "1974-02-12"

    #stripe_token 'tok_123'
    stripe_customer_id 'cus_123'
    #stripe_subscription_id 'sub_123'

    factory :admin do
      admin true
    end
  end
end
