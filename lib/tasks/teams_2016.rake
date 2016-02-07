namespace :db do
  desc "Fill database with 2016 teams"
  task teams_2016: :environment do
    colors = %w(Orange Yellow Green Red Blue Black White Pink)
    team_names = [
                    "Money on the Floor feat. 2 Chainz",
                    "Bryce Brice Baby",
                    "Green Eggs and Sam",
                    "Shayyna Lmao",
                    "Mike's Hard",
                    "Naked Bobby's Very Clothed Team",
                    "#passitatcha",
                    "Cloudy with a Chance of Suneeth"
                 ]
    (0..7).each do |i|
      Team.create(name: team_names[i], color: colors[i])
    end
    p "Added Teams"
  end
end