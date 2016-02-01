class AddAdminColumn < ActiveRecord::Migration
  def change
    add_column :users, :user_type, :integer
    add_column :users, :name, :string
  end
end
