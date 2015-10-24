FactoryGirl.define do
  factory :team do
    sequence(:name) { |n| "Team#{n}" }
    sequence(:color) { |n| "Color#{n}" }
  end
end
