FactoryGirl.define do
  factory :membership do
    association :player
    association :team
    role Team::Role::PLAYER

    trait :captain do
      role Team::Role::CAPTAIN
    end
  end
end