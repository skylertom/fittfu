class FixGameColumnName < ActiveRecord::Migration
  def change
    rename_column :games, :game_number, :time_slot
  end
end
