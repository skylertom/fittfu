FactoryGirl.define do
  factory :player do
    sequence(:name) { |n| "Person#{n}" }
    gender 0
    trait :ewo do
      gender 1
    end
    trait :eman do
      gender 0
    end
  end
end