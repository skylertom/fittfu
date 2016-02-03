class AddColumnToGameStats < ActiveRecord::Migration
  def change
    add_column :game_stats, :swag, :integer, default: 0
  end
end
