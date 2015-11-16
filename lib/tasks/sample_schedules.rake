namespace :db do
  desc "Fill database with sample schedules"
  task sample_schedules: :environment do
    base_time = Time.zone.parse('2015-10-23 8:00pm')
    (0..7).each do |i|
      t = base_time.advance(weeks: i)
      Schedule.create(start_time: t, end_time: t.advance(hours: 2))
    end
  end
end