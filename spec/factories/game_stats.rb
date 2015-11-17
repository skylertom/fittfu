FactoryGirl.define do
  factory :game_stat do
    association :game
    association :player
  end
end
