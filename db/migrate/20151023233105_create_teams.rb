class CreateTeams < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'
    create_table :teams, id: :uuid do |t|
      t.string :name
      t.string :color

      t.timestamps
    end
  end
end
