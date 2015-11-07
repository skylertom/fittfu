class MakeSchedule
  SIZE = Team::STD_SIZE

  def self.build
    new
  end

  def call(num_weeks)
    # TODO only use real teams (not fantasy)
    return false if Game.all.size >= num_weeks * Team::GAMES_IN_NIGHT
    team_ids = Team.all.pluck(:id)
    return false if team_ids.size < SIZE
    stationary = 0
    front = 1
    num_weeks.times do |week|
      current_front = front
      current_last = decrement(front)
      # TODO randomize time_slot each week otherwise team 0 plays first each time
      Team::GAMES_IN_NIGHT.times do |time|
        g = Game.create(week: week, time_slot: time)
        g.team_games.create(team_id: team_ids[current_last])
        current_last = decrement(current_last)
        if time == stationary
          g.team_games.create(team_id: team_ids[stationary])
        else
          g.team_games.create(team_id: team_ids[current_front])
          current_front = increment(current_front)
        end
      end
      front = increment(front)
    end
  end

  def decrement(index)
    index == 1 ? SIZE - 1 : index - 1
  end

  def increment(index)
    index == SIZE - 1 ? 1 : index + 1
  end
end