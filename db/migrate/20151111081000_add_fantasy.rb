class AddFantasy < ActiveRecord::Migration
  def change
    add_column :teams, :fantasy, :boolean, default: false
    add_column :memberships, :fantasy, :boolean, default: false
  end
end
