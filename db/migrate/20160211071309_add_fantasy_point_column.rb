class AddFantasyPointColumn < ActiveRecord::Migration
  def change
    add_column :game_stats, :points, :integer, default: 0
  end
end
