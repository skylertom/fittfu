require 'activerecord-import/base'
ActiveRecord::Import.require_adapter(ActiveRecord::Base.configurations['production']['adapter'])

class MakeSchedule
  SIZE = Team::STD_SIZE

  def self.build
    new
  end

  def call(num_weeks)
    # TODO only use real teams (not fantasy)
    return false if Game.count > 10
    team_ids = Team.real.limit(8).pluck(:id)
    return false if team_ids.size < SIZE
    create_schedule(team_ids, num_weeks)
  end

  def create_schedule(team_ids, num_weeks)
    stationary = 0
    front = 1
    columns = [:game_id, :team_id]
    values = []
    game_ids = []
    num_weeks.times do |week|
      current_front = front
      current_last = decrement(front)
      random = [0, 1, 2, 3].shuffle
      Team::GAMES_IN_NIGHT.times do |time|
        g = Game.create(week: week, time_slot: (random[time]))
        values << [g.id, team_ids[current_last]]
        current_last = decrement(current_last)
        if time == stationary
          values << [g.id, team_ids[stationary]]
        else
          values << [g.id, team_ids[current_front]]
          current_front = increment(current_front)
        end
        game_ids << g.id
      end
      front = increment(front)
    end
    team_game_save = TeamGame.import columns, values
    if team_game_save.failed_instances.blank?
      return make_game_stats(game_ids)
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

  def make_game_stats(game_ids)
    columns = [:game_id, :player_id]
    values = []
    games = Game.where(id: game_ids).includes(:players)
    games.each do |row|
      row.players.pluck(:id).each do |player_id|
        values << [row.id, player_id]
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