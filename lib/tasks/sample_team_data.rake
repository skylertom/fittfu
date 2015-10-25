namespace :db do
  desc "Fill database with sample teams"
  task sample_teams: :environment do
    colors = ["Black", "White", "Red", "Green", "Blue", "Purple", "Pink", "Yellow"]
    (0..7).each do |i|
      Team.create(name: "Team_#{i}", color: colors[i])
    end
  end
end