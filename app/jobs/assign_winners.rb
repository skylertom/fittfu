class AssignWinners
  include SuckerPunch::Job

  def perform
    p "Starting Assign Winners Task"
    Game.past.includes(:team_games).each do |g|
      home = g.team_games.first
      away = g.team_games.second
      winner = home.goals > away.goals ? home : away
      loser = winner.id == home.id ? away : home
      winner.update_attribute(:winner, true)
      loser.update_attribute(:winner, false)
    end
    p "Finished Assigning Winners"
  end
end