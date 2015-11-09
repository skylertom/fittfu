require 'activerecord-import/base'
ActiveRecord::Import.require_adapter(ActiveRecord::Base.configurations['production']['adapter'])

class MakeSchedule
  SIZE = Team::STD_SIZE

  def self.build
    new
  end

  def call(num_weeks)
    # TODO only use real teams (not fantasy)
    return false if Game.all.size > 0
    team_ids = Team.all.pluck(:id)
    return false if team_ids.size < SIZE
    create_schedule(team_ids, num_weeks)
  end

  def create_schedule(team_ids, num_weeks)
    stationary = 0
    front = 1
    columns = [:game_id, :team_id]
    values = []
    num_weeks.times do |week|
      current_front = front
      current_last = decrement(front)
      random = [0, 1, 2, 3].shuffle
      # TODO randomize time_slot each week otherwise team 0 plays first each time
      Team::GAMES_IN_NIGHT.times do |time|
        g = Game.create(week: week, time_slot: (random[time]))
        values.push([g.id, team_ids[current_last]])
        current_last = decrement(current_last)
        if time == stationary
          values.push([g.id, team_ids[stationary]])
        else
          values.push([g.id, team_ids[current_front]])
          current_front = increment(current_front)
        end
      end
      front = increment(front)
    end
    team_game_save = TeamGame.import columns, values
    if team_game_save.failed_instances.blank?
      return make_game_stats(values.each_with_index.map { |row, i| { team_game_id: team_game_save.ids[i], team_id: row[1] } })
    else
      p "Error: Failed to schedule all games"
      team_game_save.failed_instances.each do |i|
        p "Error: #{i}"
      end
      return false
    end
  end

  def get_spread(team_ids)
    team_ids.map do |team_id|
      name = Team.find(team_id).name
      { name: name,
        distribution: [0, 1, 2, 3].map do |time|
          Game.where(time_slot: time).inject(0) do |sum, game|
            game.teams.find_by(id: team_id).blank? ? sum : sum + 1
          end
        end
      }
    end
  end

  def make_game_stats(ids)
    columns = [:team_game_id, :player_id]
    values = []
    ms = []
    prev_team_id = nil
    ids.sort_by {|row| row[:team_id] }.each do |row|
      ms = Membership.where(team_id: row[:team_id]).pluck(:player_id) unless row[:team_id] == prev_team_id
      ms.each do |player_id|
        values.push([row[:team_game_id], player_id])
      end
    end
    game_stat_save = GameStat.import columns, values
    game_stat_save.failed_instances.blank?
  end

  def decrement(index)
    index == 1 ? SIZE - 1 : index - 1
  end

  def increment(index)
    index == SIZE - 1 ? 1 : index + 1
  end
end