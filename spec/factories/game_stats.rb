FactoryGirl.define do
  factory :game_stat do
    association :team_game
    association :player
  end
end
