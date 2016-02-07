FactoryGirl.define do
  factory :invitation do
    code { SecureRandom.uuid }
    association :invitor, factory: :user
    accepted 0
    sequence :email do |n|
      "person#{n}@example.com"
    end
    trait :admin do
      authority "admin"
    end
    trait :commissioner do
      authority "commissioner"
    end
  end
end
