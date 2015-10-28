class CreateGameStats < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'
    create_table :game_stats, id: :uuid do |t|
      t.uuid :team_game_id
      t.uuid :player_id
      t.integer :ds, default: 0
      t.integer :turns, default: 0
      t.integer :goals, default: 0
      t.integer :assists, default: 0

      t.timestamps null: false
    end
  end
end
