FactoryGirl.define do
  factory :user do
    password "lolololol"
    password_confirmation "lolololol"
    sequence(:name) { |n| "Person#{n}" }
    sequence(:email) { |n| "person#{n}@tufts.edu" }
    trait :commissioner do
      commissioner true
    end
    trait :admin do
      admin true
    end
  end
end
