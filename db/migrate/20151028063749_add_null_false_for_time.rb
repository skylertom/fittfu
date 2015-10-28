class AddNullFalseForTime < ActiveRecord::Migration
  def change
    change_column :games, :created_at, :datetime, null: false
    change_column :games, :updated_at, :datetime, null: false
    change_column :team_games, :created_at, :datetime, null: false
    change_column :team_games, :updated_at, :datetime, null: false
    change_column :memberships, :created_at, :datetime, null: false
    change_column :memberships, :updated_at, :datetime, null: false
    change_column :players, :created_at, :datetime, null: false
    change_column :players, :updated_at, :datetime, null: false
    change_column :teams, :created_at, :datetime, null: false
    change_column :teams, :updated_at, :datetime, null: false
  end
end
