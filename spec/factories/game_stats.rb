FactoryGirl.define do
  factory :game_stat do
    association :team
    association :player
  end

end
