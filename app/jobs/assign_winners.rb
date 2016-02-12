class AssignWinners
  include SuckerPunch::Job

  def perform(absolute)
    p "Starting Assign Winners Task"
    ActiveRecord::Base.connection_pool.with_connection do
      games = absolute ? Game.past.includes(:team_games) : Game.where("time < ?", Time.zone.now.advance(minutes: 30)).includes(:team_games)
      games.each do |g|
        home = g.team_games.first
        away = g.team_games.second
        winner = home.goals > away.goals ? home : away
        loser = winner.id == home.id ? away : home
        winner.update_attribute(:winner, true)
        loser.update_attribute(:winner, false)
      end
    end
    p "Finished Assigning Winners"
  end
end