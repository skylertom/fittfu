class CreateGames < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'
    create_table :games, id: :uuid do |t|
      t.integer :game_number
      t.integer :week

      t.timestamps
    end
  end
end
