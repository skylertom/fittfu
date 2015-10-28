class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :game_number
      t.integer :week

      t.timestamps null: false
    end
  end
end
