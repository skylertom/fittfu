FactoryGirl.define do
  factory :membership do
    association :player
    association :team
    captain false

    trait :captain do
      captain true
    end
  end
end