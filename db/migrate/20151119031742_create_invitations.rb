class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations, id: :uuid do |t|
      t.string :authority
      t.uuid :user_id
      t.uuid :code
      t.string :email
      t.uuid :invitor_id
      t.integer :accepted, default: 0

      t.timestamps null: false
    end

    add_column :users, :invite_code, :uuid
  end
end
