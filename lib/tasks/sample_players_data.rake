namespace :db do
  desc "Fill database with sample players"
  task sample_players_data: :environment do
    (0..31).each do |i|
      p = Player.create(name: "P#{i}_Team_#{i%8}", gender: 0)
      p.memberships.create(team_id: Team.find_by(name: "Team_#{i%8}").id)
    end
  end
end