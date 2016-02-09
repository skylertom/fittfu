# Note: using active-record-import is overkill and no longer efficient
#   in this scenario
#   the number of records isn't large enough to be necessary, but
#   I wanted to learn the gem
require 'activerecord-import/base'
ActiveRecord::Import.require_adapter(ActiveRecord::Base.configurations['production']['adapter'])

class MakeSchedule
  SIZE = Team::STD_SIZE

  def self.build
    new
  end

  # TEST function
  def make_times
    current = Time.zone.local(2016, 1, 29, 20)
    6.times do |i|
      Schedule.create(start_time: current, end_time: current.advance(hours: 2), year: current.year)
      current = current.advance(weeks: 1)
    end
  end

  def call()
    # TODO only use real teams (not fantasy)
    return false if Game.count > 10
    team_ids = Team.real.limit(SIZE).pluck(:id)
    return false if team_ids.size < SIZE
    create_schedule(team_ids)
  end

  def assign_times
    return false unless Schedule.for(Time.zone.now.year).any?
    Schedule.for(Time.zone.now.year).each_with_index do |s, i|
      week = Game.where(week: i).where('time IS ?', nil)
      Schedule::GAMES_IN_NIGHT.times do |time_slot|
        week.find_by(time_slot: time_slot).update(time: s.start_time.advance(minutes: (time_slot * Game::DURATION)))
      end
    end
  end

  def create_schedule(team_ids)
    stationary = 0
    front = 1
    columns = [:game_id, :team_id]
    values = []
    game_ids = []
    times = Schedule.where(year: Time.zone.now.year).pluck(:start_time)
    times.each_with_index do |time, week|
      current_front = front
      current_last = decrement(front)
      random = [0, 1, 2, 3].shuffle
      Schedule::GAMES_IN_NIGHT.times do |time_slot|
        g = Game.create(week: week, time_slot: random[time_slot], time: time.advance(minutes: Game::DURATION * random[time_slot]))
        values << [g.id, team_ids[current_last]]
        current_last = decrement(current_last)
        if time_slot == stationary
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
      return make_game_stats(team_game_save)
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

  def make_game_stats(team_game_save)
    columns = [:team_game_id, :player_id, :week]
    values = []
    TeamGame.all.each do |row|
      player_ids = row.team.players.pluck(:id)
      player_ids.each do |player_id|
        values << [row.id, player_id, row.game.week]
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