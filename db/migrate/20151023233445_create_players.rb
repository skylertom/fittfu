class CreatePlayers < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'
    create_table :players, id: :uuid do |t|
      t.string :name
      t.integer :gender

      t.timestamps
    end
  end
end
