namespace :db do
  desc "Fill database with sample players"
  task sample_players_data: :environment do
    if Team.find_by(name: "Team_1").exists?
      (0..31).each do |i|
        player = Player.create(name: "P#{i}_Team_#{i%8}", gender: 0)
        player.memberships.create(team_id: Team.find_by(name: "Team_#{i%8}").id)
      end
    else
      p "Run sample_teams task first"
    end
  end
end