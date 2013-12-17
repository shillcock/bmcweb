FactoryGirl.define do
  factory :donation do
    name "Big Donor"
    email "donor@example.com"
    comment "Keep up the good work."
    amount 75
    stripe_token "stripe"
    stripe_charge_id "CHARGE-ID"
    stripe_processing_fee_cents (75 * 100 * 0.029 + 30)
  end
end
