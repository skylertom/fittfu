class AddWinnerLoserToGame < ActiveRecord::Migration
  def change
    add_column :team_games, :winner, :boolean, default: nil
  end
end
