class CreateTeamGames < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'
    create_table :team_games, id: :uuid do |t|
      t.uuid :team_id
      t.uuid :game_id
      t.integer :points, default: 0

      t.timestamps
    end
    add_index :team_games, :team_id
  end
end
