class CreateMemberships < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'
    create_table :memberships, id: :uuid do |t|
      t.uuid :player_id
      t.uuid :team_id
      t.string :role

      t.timestamps
    end
    add_index :memberships, :player_id
  end
end
