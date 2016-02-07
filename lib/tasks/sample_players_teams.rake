namespace :db do
  desc "Fill database with sample players and teams"
  task sample_players_teams: :environment do
    colors = %w(Black White Red Green Blue Purple Pink Yellow)
    (0..7).each do |i|
      Team.create(name: "Team_#{i}", color: colors[i])
    end
    p "Added Teams"
    (0..31).each do |i|
      player = Player.create(name: "P#{i}_T_#{i%8}", gender: 0)
      player.memberships.create(team_id: Team.find_by(name: "Team_#{i%8}").id)
    end
    p "Added Players"
  end
end