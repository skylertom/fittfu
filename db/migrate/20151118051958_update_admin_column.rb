class UpdateAdminColumn < ActiveRecord::Migration
  def change
    remove_column :users, :user_type
    add_column :users, :admin, :boolean, default: false
    add_column :users, :commissioner, :boolean, default: false
  end
end
