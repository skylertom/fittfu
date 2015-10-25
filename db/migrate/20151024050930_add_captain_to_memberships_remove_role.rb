class AddCaptainToMembershipsRemoveRole < ActiveRecord::Migration
  def change
    add_column :memberships, :captain, :boolean, default: false
    remove_column :memberships, :role, :string
  end
end
