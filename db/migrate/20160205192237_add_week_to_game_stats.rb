class AddWeekToGameStats < ActiveRecord::Migration
  def up
    add_column :game_stats, :week, :integer

    Game.all.each do |g|
      g.game_stats.each do |stat|
        stat.update_attribute(:week, g.week)
      end
    end
  end

  def down
    remove_column :game_stats, :week, :integer
  end
end
