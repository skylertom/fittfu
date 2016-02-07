FactoryGirl.define do
  factory :schedule do
    start_time { Time.now }
    end_time { Time.now.advance(hours: 2) }
  end
end
