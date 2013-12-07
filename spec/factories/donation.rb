FactoryGirl.define do
  factory :donation do
    first_name "Big"
    last_name "Donor"
    email "donor@exmaple.com"
    number "4111111111111111"
    expiration_date 1.month.from_now.to_date
    cvv 111
    amount 99
  end
end
