FactoryGirl.define do
  factory :team_game do
    association :team
    association :game
  end
end
