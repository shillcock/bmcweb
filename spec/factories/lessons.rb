# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :lesson do
    title "MyString"
    summary "MyText"
    lesson_number 1
    workshop nil
    meeting nil
  end
end
