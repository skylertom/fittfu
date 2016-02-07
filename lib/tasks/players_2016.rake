namespace :db do
  desc "Fill database with 2016 players"
  task players_2016: :environment do
    EWO = 1
    EMEN = 0
    colors = [:Orange, :Yellow, :Green, :Red, :Blue, :Black, :White, :Pink]
    players = {
        Orange: {
            captain: ["Emily", EWO],
            ewo: ['Kei', 'Sophie', 'Sophia', 'Posh', 'Ruth', 'Annie Bricker'],
            emen: ['Skyler', 'Jin', 'Jack Hatchett', 'Matt', 'Jem', 'Spiva', 'Pepon', 'Sloppy Joe', 'Noah Smith', 'David Leibert', 'Phallus']
        }, Yellow: {
            captain: ["Bryce", EMEN],
            ewo: ['Winnie', 'MO', 'Jaisal', 'Amy Kao', 'Clara E.', 'Margaret Z.'],
            emen: ['Tyler', 'Eric Chen', 'Walton', 'Jesse', 'Tom', 'Tate', 'DH', 'Bert', 'Garrett', 'Elliot', 'Noah Adler']
        }, Green: {
            captain: ["Sam", EWO],
            ewo: ['Val', 'Hadley', 'Jill', 'Ari', 'Carolyn Burtt', 'Bailey'],
            emen: ['Tang', 'Dillard', 'Tommy', 'Jac', 'Lloyd', 'Glenn', 'Lana', 'Will Norris', 'Noah Meixler', 'Henry', 'Brian Barrows']
        }, Red: {
            captain: ["Shayna", EWO],
            ewo: ['Lazer', 'Omelette', 'Grace', 'Mandy', 'Maggie', 'Mel'],
            emen: ['Owen', 'Lyle', 'Produce', 'Adrian', 'Charlie', 'Pudge', 'Django', 'Phil', 'King Ming', 'Lucas', 'Hazen']
        }, Blue: {
            captain: ["Mike", 1],
            ewo: ['Sarge', 'Stat', 'Jenna', 'Pups', 'Michelle Chan', 'Kristina'],
            emen: ['Carter', 'Wittenberg', 'Caulfield', 'Cones', 'Wild Man', 'Rafi', 'Dom', 'Sid', 'Noah Goldberg', 'Max', 'Noah Harris']
        }, Black: {
            captain: ["Bobby", EMEN],
            ewo: ['Hamm', 'Bekah', 'Rhea', 'Geena', 'Leena'],
            emen: ['Ferny', 'Eamon', 'Torsten', 'Addison', 'Sawyer', 'Eli', 'Arthur', 'Ben Zager', 'Alex Brodeur', 'Josh White', 'David Stack']
        }, White: {
            captain: ["Caroline", EWO],
            ewo: ['Jojo', 'Pip', 'MP', 'Julia Kang', 'Isabelle'],
            emen: ['Nicky', 'Gene', 'KG', 'Jam', 'Skach', 'Vinnie', 'Luke', 'Bangs', 'Ben Thorne', 'John Moore', 'Ryan Gossler']
        }, Pink: {
            captain: ["Suneeth", EMEN],
            ewo: ['Claudia', 'Sammy', 'Gecko', 'Pebbles', 'Emily Wilson'],
            emen: ['Remy', 'Oliver', 'Tegeler', 'Zieba', 'Frozone', 'Johnny Flickster', 'Marc Buggati', "Jack O'Shea", 'Abi', '3 alums', "Frozone's rando"]
        }
    }

    colors.each do |c|
      id = Team.find_by(color: c).id
      captain = players[c][:captain]
      p = Player.create(name: captain[0], gender: captain[1])
      p.memberships.create(team_id: id, captain: true)
      players[c][:ewo].each do |name|
        p = Player.create(name: name, gender: EWO)
        p.memberships.create(team_id: id)
      end
      players[c][:emen].each do |name|
        p = Player.create(name: name, gender: EMEN)
        p.memberships.create(team_id: id)
      end
    end
    p "Added 2016 players"
  end
end